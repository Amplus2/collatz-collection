function range(start, end) {
    const result = [];
    if (end === undefined)
        for (var i = 0; i < start; i++)
            result.push(i);
    else
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

async function get_wasm_exports(path, memory_size) {
    let importObj = undefined;
    if(memory_size !== undefined) {
        importObj = {js: {mem: new WebAssembly.Memory({initial: 10})}};
    }
    const res = await WebAssembly.instantiate(await (await fetch(path)).arrayBuffer(), importObj);
    return res.instance.exports;
}

async function collatz_steps(path, start, end) {
    const len = end-start;
    const exports = await get_wasm_exports(path, len*4);
    const v = new Int32Array(exports.memory.buffer, 0*4, len*4);
    exports.collatz_batch_steps(start, end, v.byteOffset);
    return Array.from(v);
}

async function collatz_amount_steps(path, start, end) {
    const collatz_nums = (await collatz_steps(path, start, end));
    collatz_nums.sort((a, b) => a - b);
    const result = new Map();
    for (var i = 0; i < collatz_nums.length; i++) {
        const a = collatz_nums[i];
        if (!result.has(a)) result.set(a, 1);
        else result.set(a, 1 + result.get(a));
    }
    return result;
}
