document.addEventListener('DOMContentLoaded', function() {
    // Determine the API URL based on the environment
    const isLocalhost = window.location.hostname === 'localhost';
    const apiUrl = isLocalhost 
        ? 'http://localhost:5000/api/titles'
        : '/api/titles';  // This will be proxied by Azure Static Web Apps

    const tableBody = document.getElementById('titlesTableBody');

    // Show loading state
    tableBody.innerHTML = '<tr><td colspan="4" class="loading">Loading titles...</td></tr>';

    // Fetch titles from the API
    fetch(apiUrl)
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            // Clear loading state
            tableBody.innerHTML = '';

            // Display the titles
            data.value.forEach(title => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${title.id}</td>
                    <td>${title.title || ''}</td>
                    <td>${title.type || ''}</td>
                    <td>${title.price || ''}</td>
                `;
                tableBody.appendChild(row);
            });
        })
        .catch(error => {
            // Show error state
            tableBody.innerHTML = `
                <tr>
                    <td colspan="4" class="error">
                        Error loading titles: ${error.message}
                    </td>
                </tr>
            `;
        });
}); 