// Copy or share a route card's permalink (progressive enhancement over the plain #id anchor).
(function () {
    var buttons = document.querySelectorAll(".route-copy-link");

    buttons.forEach(function (button) {
        button.addEventListener("click", function () {
            var url = location.origin + location.pathname + "#" + button.dataset.routeId;
            var feedback = button.nextElementSibling;
            // Touch devices get the native share sheet; desktop pointers copy straight to the clipboard.
            var isTouch = window.matchMedia && window.matchMedia("(pointer: coarse)").matches;

            function showFeedback(message) {
                if (!feedback) {
                    return;
                }
                feedback.textContent = message;
                window.setTimeout(function () {
                    feedback.textContent = "";
                }, 3000);
            }

            function copyLink() {
                if (navigator.clipboard && navigator.clipboard.writeText) {
                    navigator.clipboard.writeText(url).then(function () {
                        showFeedback("Copied!");
                    }).catch(function () {
                        window.prompt("Copy this link:", url);
                    });
                } else {
                    window.prompt("Copy this link:", url);
                }
            }

            if (navigator.share && isTouch) {
                navigator.share({ url: url }).then(function () {
                    showFeedback("Shared!");
                }).catch(function (error) {
                    if (error && error.name === "AbortError") {
                        return;
                    }
                    copyLink();
                });
            } else {
                copyLink();
            }
        });
    });
})();
