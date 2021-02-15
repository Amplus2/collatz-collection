#include "wasm-diagrams.h"
#include "collatz.h"
#include <emscripten.h>

void setScale(std::string canvas, double xScale, double yScale) {
        EM_ASM({
                document.getElementById($0).getContext('2d')
                        .setTransform($1, 0, 0, $2, 0, 0);
        }, canvas.c_str(), xScale, yScale);
}

void setFillStyle(std::string canvas, std::string fillStyle) {
        EM_ASM({
                document.getElementById($0).getContext('2d')
                        .fillStyle = $1;
        }, canvas.c_str(), fillStyle.c_str());
}

struct dimensions {
        int width;
        int height;
};

struct dimensions getDimensions(std::string canvas) {
        int width = EM_ASM_INT({
                return document.getElementById($0).width;
        }, canvas.c_str());
        int height = EM_ASM_INT({
                return document.getElementById($0).height;
        }, canvas.c_str());
        return {width, height};
}

void fillRect(std::string canvas,
              double x, double y,
              double width, double height) {
        EM_ASM({
                document.getElementById($0).getContext('2d')
                        .fillRect($1, $2, $3, $4);
        }, canvas.c_str(), x, y, width, height);
}

void draw_chart_to_canvas(std::string        canvas,
                          std::map<int, int> data,
                          unsigned           width,
                          unsigned           height,
                          std::string        fillStyle) {
        auto dimensions = getDimensions(canvas);
        auto xScale = (double)width  / (double)dimensions.width;
        auto yScale = (double)height / (double)dimensions.height;
        setScale(canvas, xScale, yScale);
        setFillStyle(canvas, fillStyle);
        for(std::pair<int, int> pair : data) {
                fillRect(canvas, pair.first, pair.second, 1, pair.second);
        }
}

EMSCRIPTEN_KEEPALIVE
extern "C" void draw_count_chart(char *canvas,
                                 int start, int end,
                                 int width, int height,
                                 char *fillStyle) {
        draw_chart_to_canvas(canvas,
                             collatz_count(start, end),
                             width, height,
                             fillStyle);
}

EMSCRIPTEN_KEEPALIVE
extern "C" void draw_step_chart(char *canvas,
                                int start, int end,
                                int width, int height,
                                char *fillStyle) {
        draw_chart_to_canvas(canvas,
                             collatz_batch_steps(start, end),
                             width, height,
                             fillStyle);
}
