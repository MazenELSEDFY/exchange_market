document.addEventListener("DOMContentLoaded", function () {
    var mybutton = document.querySelector(".return-to-top");
    window.onscroll = function () {
        scrollFunction();
    };

    function scrollFunction() {
        if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
            mybutton.style.display = "block";
        } else {
            mybutton.style.display = "none";
        }
    }

    mybutton.addEventListener("click", function () {
        document.body.scrollTop = 0;
        document.documentElement.scrollTop = 0;
    });
});

function validateForm() {
    var name = document.getElementById('name').value;
    var passport = document.getElementById('passport').value;
    var email = document.getElementById('email').value;
    var phone = document.getElementById('phone').value;
    var date = document.getElementById('date').value;
    var amountBefore = document.getElementById('amountBefore').value;
    var fromCurrency = document.getElementById('fromCurrency').value;
    var toCurrency = document.getElementById('toCurrency').value;
    var password = document.getElementById("password").value;
    var confirmPassword = document.getElementById("confirmPassword").value;
    var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    var phoneRegex = /^[0-9]+$/;
    var nameRegex = /^[a-zA-Z\s]+$/;
    var passwordRegex = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*_-]).{8,}$/;



    if (name === '' && passport === '' && email === '' && phone === '' && date === '' && amountBefore === '') {
        alert('Please fill in all fields.');
        return false;
    } else if (!nameRegex.test(name)) {
        alert('Please enter a valid name (only characters are allowed).');
        return false;
    } else if (passport === '') {
        alert('Please fill in the passport field.');
        return false;
    } else if (!emailRegex.test(email)) {
        alert('Please enter a valid email address.');
        return false;
    } else if (!phoneRegex.test(phone)) {
        alert('Please enter a valid phone number.');
        return false;
    } else if (date === '') {
        alert('Please fill in the date field.');
        return false;
    } else if (amountBefore === '') {
        alert('Please fill in the amount before conversion field.');
        return false;
    } else if (fromCurrency === toCurrency) {
        alert('Cannot convert the same Currency. Please Try Again.');
        return false;
    }
    if (password !== confirmPassword) {
        alert("Passwords do not match");
        return false;
    }
    if (!passwordRegex.test(password)) {
        alert("Password must contain at least 8 characters, one uppercase letter, one lowercase letter, one number, and one special character.");
        return false;
    }

    return true;
}
function validateAndRedirect() {
    if (validateForm()) {
        window.location.href = 'SEARCH.html';
        return true; 
    }
    return false; 
}




function calculateAmountAfter() {
    if (!validateForm()) {
        return;
    }

    var amountBefore = parseFloat(document.getElementById('amountBefore').value);
    var fromCurrency = document.getElementById('fromCurrency').value;
    var toCurrency = document.getElementById('toCurrency').value;

    fetch('https://open.er-api.com/v6/latest/USD')
        .then(response => response.json())
        .then(data => {
            var exchangeRateFrom = data.rates[fromCurrency];
            var exchangeRateTo = data.rates[toCurrency];
            var amountAfter = (amountBefore / exchangeRateFrom) * exchangeRateTo;
            document.getElementById('amountAfter').value = amountAfter.toFixed(4);
        })
        .catch(error => console.error('Error fetching exchange rates:', error));
}
function togglePasswordVisibility() {
    var passwordInput = document.getElementById("password");
    if (passwordInput.type === "password") {
        passwordInput.type = "text";
    } else {
        passwordInput.type = "password";
    }
}