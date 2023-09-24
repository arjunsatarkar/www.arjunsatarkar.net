(() => {
    const sparkle_loop = {
        "🌟": "✨",
        "✨": "💫",
        "💫": "🌟",
    };
    const sparkle_loop_elem = document.querySelector("#sparkle_loop");
    sparkle_loop_elem.setAttribute("tabindex", "0");
    function update_sparkle_loop() {
        sparkle_loop_elem.innerText = sparkle_loop[sparkle_loop_elem.innerText];
    }
    sparkle_loop_elem.addEventListener("click", (_) => update_sparkle_loop());
    sparkle_loop_elem.addEventListener("keydown", (e) => {
        if (e.key === "Enter") {
            update_sparkle_loop();
        }
    });
})();
