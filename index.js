let cart = [];

function addToCart(item) {
    cart.push(item);
    alert(`${item} foi adicionado ao carrinho!`);
}

function openDrinkOptions(item) {
    document.getElementById('drink-options').classList.remove('hidden');
    cart.push(item);
}

function addToCartWithDrink() {
    const size = document.getElementById('size').value;
    const brand = document.getElementById('brand').value;

    if (brand === "") {
        alert("Por favor, insira a marca do refrigerante.");
        return;
    }

    cart.push(`Refrigerante: ${size} - Marca: ${brand}`);
    alert('Combo adicionado ao carrinho!');
    document.getElementById('drink-options').classList.add('hidden');
    document.getElementById('drinkForm').reset();
}
