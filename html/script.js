let items = [];
let filteredItems = [];
let selectedItem = null;

window.addEventListener('message', function (event) {
    if (event.data.action === 'openMenu') {
        items = event.data.items || [];
        filteredItems = items;
        selectedItem = null;
        document.getElementById('quantity').value = 1;
        document.getElementById('addItemBtn').disabled = true;
        renderList();
        document.getElementById('menu').style.display = 'block';
        document.body.style.display = 'block';
        document.getElementById('search').focus();
    } else if (event.data.action === 'closeMenu') {
        document.getElementById('menu').style.display = 'none';
        document.body.style.display = 'none';
    }
});

function renderList() {
    const list = document.getElementById('itemList');
    list.innerHTML = '';

    filteredItems.forEach(item => {
        const li = document.createElement('li');
        li.textContent = item.label + ' (' + item.name + ')';
        li.dataset.name = item.name;

        li.onclick = () => {
            selectedItem = item;
            updateSelection();
        };

        list.appendChild(li);
    });
}

function updateSelection() {
    const lis = document.querySelectorAll('#itemList li');
    lis.forEach(li => {
        li.classList.toggle('selected', li.dataset.name === selectedItem.name);
    });
    document.getElementById('addItemBtn').disabled = !selectedItem;
}

document.getElementById('search').addEventListener('input', (e) => {
    const val = e.target.value.toLowerCase();
    filteredItems = items.filter(i =>
        i.name.toLowerCase().includes(val) || i.label.toLowerCase().includes(val)
    );
    selectedItem = null;
    updateSelection();
    renderList();
});

document.getElementById('addItemBtn').addEventListener('click', () => {
    if (!selectedItem) return;
    const quantity = parseInt(document.getElementById('quantity').value, 10);
    fetch(`https://${GetParentResourceName()}/addItem`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            itemName: selectedItem.name,
            amount: quantity > 0 ? quantity : 1
        })
    }).then(() => {
        fetch(`https://${GetParentResourceName()}/closeMenu`, { method: 'POST' });
    });
});

document.getElementById('closeBtn').addEventListener('click', () => {
    fetch(`https://${GetParentResourceName()}/closeMenu`, {
        method: 'POST'
    });
});
