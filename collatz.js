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
    const res = await WebAssembly.instantiate((await fetch(path)).arrayBuffer(), importObj);
    return res.instance.exports;
}

async function collatz_steps(path, start, end) {
    //if (slow_wasm()) return collatz_steps_js(range);
    const exports = await get_wasm_exports(path, (end-start)*2);
    const len = end-start;
    const k = new Int32Array(exports.memory.buffer,   0*4, len);
    const v = new Int32Array(exports.memory.buffer, len*4, len);
    exports.collatz_batch_steps(start, end, k.byteOffset, v.byteOffset);
    return [Array.from(k), Array.from(v)];
}

function collatz_steps_js(range) {
    function steps(input) {
        if (input < 1) return -1;
        var steps = 0;
        while (true) {
            if(input == 1) return steps;
            input = input % 2 == 1 ? 3 * input + 1 : input / 2;
            steps++;
        }
    }
    const result = [];
    for(var i = 0; i < range.length; i++) result.push(steps(range[i]));
    return result;
}


async function collatz_amount_steps(path, start, end) {
    const collatz_nums = (await collatz_steps(path, start, end))[1];
    collatz_nums.sort((a, b) => a - b);
    const result = new Map();
    for (var i = 0; i < collatz_nums.length; i++) {
        const a = collatz_nums[i];
        if (!result.has(a)) result.set(a, 1);
        else result.set(a, 1 + result.get(a));
    }
    return result;
}
