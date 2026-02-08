function [lHandle, num_columns, fig] = createFig()
screen_size = get(0,'screensize');
screen_size = screen_size(3:4);
ratio2screen = 2/3;
fig_size = screen_size * ratio2screen;
fig_pos = fig_size - (fig_size * ratio2screen);
fig_pos_siz = [fig_pos, fig_size];
fig = figure;
set(gcf, 'Position', fig_pos_siz);
[lHandle, num_columns, fig] = FigureHandlerFunc(fig);

end