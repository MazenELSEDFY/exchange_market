function searchTransaction() {
    var passport = document.getElementById('passport').value;
    var password = document.getElementById('password').value;

    // Send data to the server using AJAX
    var xhr = new XMLHttpRequest();
    xhr.open('POST', 'SEARCH.php', true);
    xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');

    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4 && xhr.status == 200) {
            document.getElementById('result').innerHTML = xhr.responseText;
        }
    };

    // Send the data as a POST request
    xhr.send('passport=' + passport + '&password=' + password);
}
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