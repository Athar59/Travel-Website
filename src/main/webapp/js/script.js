document.addEventListener("DOMContentLoaded", function () {
    const navbarToggle = document.getElementById("navbar-toggle");
    const navContainer = document.getElementById("nav-links");

    if (navbarToggle && navContainer) {
        navbarToggle.addEventListener("click", function (event) {
            navContainer.classList.toggle("show");
            event.stopPropagation(); 
        });

        document.addEventListener("click", function (event) {
            if (!navContainer.contains(event.target) && !navbarToggle.contains(event.target)) {
                navContainer.classList.remove("show");
            }
        });

        window.addEventListener("scroll", function () {
            navContainer.classList.remove("show");
        });
    }
});

// Smooth Scrolling for Internal Links
document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll(".nav-link").forEach(link => {
        link.addEventListener("click", function (e) {
            const href = this.getAttribute("href");

            if (href.includes("#")) {
                e.preventDefault();
                const targetId = href.split("#")[1];
                const target = document.getElementById(targetId);

                if (target) {
                    target.scrollIntoView({ behavior: "smooth", block: "start" });
                } else {
                    
                    window.location.href = "index.jsp#" + targetId;
                }
            }
        });
    });

    if (window.location.hash) {
        let target = document.querySelector(window.location.hash);
        if (target) {
            target.scrollIntoView({ behavior: "smooth", block: "start" });
        }
    }
});



// Payment Calculation
function updateTotalPrice() {
    let packagePriceElement = document.getElementById("package_price");
    let numPersonsElement = document.getElementById("num_persons");

    let packagePrice = packagePriceElement ? parseFloat(packagePriceElement.value) : 0;
    let numPersons = numPersonsElement ? parseInt(numPersonsElement.value) : 1;

    numPersons = Math.max(numPersons, 1); 

    let totalPrice = packagePrice * numPersons;
    
    let totalPriceDisplay = document.getElementById("total_price_display");
    let totalPriceInput = document.getElementById("total_price");

    if (totalPriceDisplay) {
        totalPriceDisplay.innerText = totalPrice.toFixed(2);
    }
    if (totalPriceInput) {
        totalPriceInput.value = totalPrice;
    }
}

document.addEventListener("DOMContentLoaded", function () {
    let numPersons = document.getElementById("num_persons");
    if (numPersons) {
        numPersons.addEventListener("input", updateTotalPrice);
    }
});
