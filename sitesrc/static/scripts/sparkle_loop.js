/*
The license for this file, sparkle_loop.js, is below.

MIT License

Copyright (c) 2023-present Arjun Satarkar <me@arjunsatarkar.net>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/
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
