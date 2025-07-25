let items = [];
let filteredItems = [];

window.addEventListener('message', function (event) {
    if (event.data.action === 'openMenu') {
        items = event.data.items || [];
        filteredItems = items;
        document.body.style.display = 'block';
        document.getElementById('menu').classList.add('active');
        renderItems();
        document.getElementById('search').focus();
    } else if (event.data.action === 'closeMenu') {
        document.getElementById('menu').classList.remove('active');
        setTimeout(() => {
            document.body.style.display = 'none';
        }, 400); // match slide-out time
    }
});

function renderItems() {
    const grid = document.getElementById('itemGrid');
    grid.innerHTML = '';

    filteredItems.forEach(item => {
        const div = document.createElement('div');
        div.className = 'itemCard';

        // Use ox_inventory's image path
        const imgPath = `nui://ox_inventory/web/images/${item.name}.png`;

        div.innerHTML = `
            <img src="${imgPath}" alt="${item.name}" onerror="this.src='fallback.png';" />
            <strong>${item.label}</strong>
            <span>${item.name}</span>
        `;

        div.onclick = () => {
            const amount = parseInt(document.getElementById('quantity').value, 10) || 1;
            fetch(`https://${GetParentResourceName()}/addItem`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    itemName: item.name,
                    amount: amount
                })
            });
        };

        grid.appendChild(div);
    });
}


document.getElementById('search').addEventListener('input', (e) => {
    const val = e.target.value.toLowerCase();
    filteredItems = items.filter(i =>
        i.name.toLowerCase().includes(val) || i.label.toLowerCase().includes(val)
    );
    renderItems();
});

document.getElementById('closeBtn').addEventListener('click', () => {
    fetch(`https://${GetParentResourceName()}/closeMenu`, {
        method: 'POST'
    });
});
