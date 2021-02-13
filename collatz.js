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

async function get_wasm_exports(path) {
    return (await WebAssembly.instantiate(await (await fetch(path)).arrayBuffer())).instance.exports;
}

var ran_once = false;
async function collatz_test(exports) {
    if (ran_once) return;
    ran_once = true;
    const a = new Int32Array(exports.memory);
    exports._Z19collatz_batch_stepsiiPi(1n, 100n, a.byteOffset);
    console.log(a);
}

async function collatz_steps(path, range) {
    //if (slow_wasm()) return collatz_steps_js(range);
    const result = [];
    const exports = await get_wasm_exports(path);
    const collatz_steps = exports._Z13collatz_stepsy;
    for (var i = 0; i < range.length; i++) result.push(collatz_steps(BigInt(range[i])));
    return result;
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