// Copy or share a route card's permalink (progressive enhancement over the plain #id anchor).
(function () {
    var buttons = document.querySelectorAll(".route-copy-link");

    buttons.forEach(function (button) {
        button.addEventListener("click", function () {
            var url = location.origin + location.pathname + "#" + button.dataset.routeId;
            var feedback = button.nextElementSibling;

            function showCopied() {
                if (!feedback) {
                    return;
                }
                feedback.textContent = "Copied!";
                window.setTimeout(function () {
                    feedback.textContent = "";
                }, 2000);
            }

            if (navigator.share) {
                navigator.share({ url: url }).catch(function () {});
            } else if (navigator.clipboard) {
                navigator.clipboard.writeText(url).then(showCopied).catch(function () {});
            }
        });
    });
})();
