#include <map>
#include <string>

void drawChartToCanvas(std::string        canvas,
                       std::map<int, int> data,
                       unsigned           width,
                       unsigned           height,
                       std::string        fillStyle);

extern "C" void drawCountChart(char *canvas,
                               int start, int end,
                               int width, int height,
                               char *fillStyle);
