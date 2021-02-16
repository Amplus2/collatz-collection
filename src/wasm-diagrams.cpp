#include "wasm-diagrams.h"
#include "collatz.h"
#include <emscripten.h>
#include <iostream>

void setScale(char *canvas, double xScale, double yScale) {
#ifdef DEBUG
        std::cout << "applying scale (" << xScale << "," << yScale << ") to "
                  << "canvas \"" << canvas << "\"" << std::endl;
#endif
        EM_ASM({
                document.getElementById(UTF8ToString($0)).getContext('2d')
                        .setTransform($1, 0, 0, $2, 0, 0);
        }, canvas, xScale, yScale);
}

void setFillStyle(char *canvas, char *fillStyle) {
#ifdef DEBUG
        std::cout << "applying fill style \"" << fillStyle << "\" to "
                  << "canvas \"" << canvas << "\"" << std::endl;
#endif
        EM_ASM({
                document.getElementById(UTF8ToString($0)).getContext('2d')
                        .fillStyle = $1;
        }, canvas, fillStyle);
}

struct dimensions {
        int width;
        int height;
};

struct dimensions getDimensions(char *canvas) {
#ifdef DEBUG
        std::cout << "getting dimensions from "
                  << "canvas \"" << canvas << "\"" << std::endl;
#endif
        int width = EM_ASM_INT({
                return document.getElementById(UTF8ToString($0)).width;
        }, canvas);
        int height = EM_ASM_INT({
                return document.getElementById(UTF8ToString($0)).height;
        }, canvas);
#ifdef DEBUG
        std::cout << "got dimensions (" << width << "," << height << ") from "
                  << "canvas \"" << canvas << "\"" << std::endl;
#endif
        return {width, height};
}

void fillRect(char *canvas,
              double x, double y,
              double width, double height) {
#ifdef DEBUG
        std::cout << "filling (" << x      << ","
                                 << y      << ","
                                 << width  << ","
                                 << height << ") on "
                  << "canvas \"" << canvas << "\"" << std::endl;
#endif
        EM_ASM({
                document.getElementById(UTF8ToString($0)).getContext('2d')
                        .fillRect($1, $2, $3, $4);
        }, canvas, x, y, width, height);
}

void draw_chart_to_canvas(char              *canvas,
                          std::map<int, int> data,
                          unsigned           width,
                          unsigned           height,
                          char              *fillStyle) {
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
