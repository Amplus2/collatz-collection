#include <map>

void draw_chart_to_canvas(char              *canvas,
                          std::map<int, int> data,
                          unsigned           width,
                          unsigned           height,
                          char              *fillStyle);

extern "C" void draw_count_chart(char *canvas,
                                 int start, int end,
                                 int width, int height,
                                 char *fillStyle);

extern "C" void draw_step_chart(char *canvas,
                                int start, int end,
                                int width, int height,
                                char *fillStyle);
