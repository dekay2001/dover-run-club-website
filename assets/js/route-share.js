// Copy or share a route card's permalink (progressive enhancement over the plain #id anchor).
(function () {
    var buttons = document.querySelectorAll(".route-copy-link");

    buttons.forEach(function (button) {
        button.addEventListener("click", function () {
            var url = button.dataset.routeUrl;
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

            function legacyCopy() {
                var field = document.createElement("textarea");
                field.value = url;
                field.setAttribute("readonly", "");
                field.style.position = "fixed";
                field.style.opacity = "0";
                document.body.appendChild(field);
                field.select();
                var copied = false;
                try {
                    copied = document.execCommand("copy");
                } catch (error) {
                    copied = false;
                }
                document.body.removeChild(field);
                showFeedback(copied ? "Copied!" : "Couldn't copy. Use the route title link instead.");
            }

            function copyLink() {
                if (navigator.clipboard && navigator.clipboard.writeText) {
                    navigator.clipboard.writeText(url).then(function () {
                        showFeedback("Copied!");
                    }).catch(legacyCopy);
                } else {
                    legacyCopy();
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
