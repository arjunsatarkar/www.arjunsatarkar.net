(() => {
    const sparkle_loop = {
        "🌟": "✨",
        "✨": "💫",
        "💫": "🌟",
    };
    const sparkle_loop_elem = document.querySelector("#sparkle_loop");
    sparkle_loop_elem.addEventListener("click", (_) => sparkle_loop_elem.innerText = sparkle_loop[sparkle_loop_elem.innerText]);
})();
