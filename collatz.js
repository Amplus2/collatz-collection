function range(start, end) {
    if (end === undefined)
        return range(0, start-1);
    const result = [];
    for (var i = start; i <= end; i++)
        result.push(i);
    return result;
}

function uses_mobile() {
    return navigator.userAgent.toLowerCase().indexOf("mobile") !== -1;
}

function no_landscape() {
    return window.innerHeight > window.innerWidth;
}

function slow_wasm() {
    return navigator.userAgent.toLowerCase().indexOf("firefox") !== -1;
}

async function get_wasm_exports(path) {
    return (await WebAssembly.instantiate(await (await fetch(path)).arrayBuffer())).instance.exports;
}

var ran_once = false;
async function collatz_test(path) {
    if (ran_once) return;
    console.log(await collatz_batch_steps(path, 1, 100));
    ran_once = true;
}

async function collatz_steps(path, range) {
    const result = [];
    const exports = await get_wasm_exports(path);
    const collatz_steps = exports.collatz_steps;
    for (var i = 0; i < range.length; i++) result.push(collatz_steps(range[i]));
    return result;
}

async function collatz_batch_steps(path, start, end) {
    const exports = await get_wasm_exports(path);
    const a = new Int32Array(exports.memory.buffer, 0, end-start);
    exports.collatz_batch_steps(start, end, a.byteOffset);
    return Array.from(a);
}

async function collatz_count(path, start, end) {
    const exports = await get_wasm_exports(path);
    const a = new Int32Array(exports.memory.buffer, 0, 600000);
    exports.collatz_count(start, end, a.byteOffset);
    return Array.from(a);
}

async function collatz_amount_steps(path, range) {
    const collatz_nums = await collatz_steps(path, range);
    collatz_nums.sort((a, b) => a - b);
    const result = new Map();
    for (var i = 0; i < collatz_nums.length; i++) {
        const a = collatz_nums[i];
        if (!result.has(a)) result.set(a, 1);
        else result.set(a, 1 + result.get(a));
    }
    return result;
}
