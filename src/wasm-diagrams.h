#include <map>
#include <string>

void draw_chart_to_canvas(std::string        canvas,
                          std::map<int, int> data,
                          unsigned           width,
                          unsigned           height,
                          std::string        fillStyle);

extern "C" void draw_count_chart(char *canvas,
                                 int start, int end,
                                 int width, int height,
                                 char *fillStyle);

extern "C" void draw_step_chart(char *canvas,
                                int start, int end,
                                int width, int height,
                                char *fillStyle);
