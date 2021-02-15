#include "wasm-diagrams.h"
#include <emscripten.h>

void setScale(std::string &canvas, double xScale, double yScale) {
        EM_ASM({
                document.getElementById($0).getContext('2d')
                        .setTransform($1, 0, 0, $2, 0, 0);
        }, canvas.c_str(), xScale, yScale);
}

void setFillStyle(std::string &canvas, std::string &fillStyle) {
        EM_ASM({
                document.getElementById($0).getContext('2d')
                        .fillStyle = $1;
        }, canvas.c_str(), fillStyle.c_str());
}

int getWidth(std::string &canvas) {
        return EM_ASM_INT({
                return document.getElementById($0).width;
        }, canvas.c_str());
}

int getHeight(std::string &canvas) {
        return EM_ASM_INT({
                return document.getElementById($0).height;
        }, canvas.c_str());
}

void fillRect(std::string &canvas,
              double x, double y,
              double width, double height) {
        EM_ASM({
                document.getElementById($0).getContext('2d')
                        .fillRect($1, $2, $3, $4);
        }, canvas.c_str(), x, y, width, height);
}

void drawChartToCanvas(std::string       &canvas,
                       std::map<int, int> data,
                       unsigned           width,
                       unsigned           height,
                       std::string       &fillStyle) {
        auto xScale = (double)width  / (double)getWidth(canvas);
        auto yScale = (double)height / (double)getHeight(canvas);
        setScale(canvas, xScale, yScale);
        setFillStyle(canvas, fillStyle);
        for(std::pair<int, int> pair : data) {
                fillRect(canvas, pair.first, pair.second, 1, pair.second);
        }
}
