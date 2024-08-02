async function fetchData(section) {
    try {
        const response = await fetch(`/${section}`);
        const data = await response.json();
        displayData(section, data);
    } catch (error) {
        console.error('Error fetching data:', error);
    }
}

function displayData(section, data) {
    const list = document.getElementById(`${section}-list`);
    list.innerHTML = ''; // Clear any existing data
    data.forEach(item => {
        const div = document.createElement('div');
        div.className = `${section}-item`;
        div.textContent = JSON.stringify(item); // Customize as needed
        list.appendChild(div);
    });
}
