function RunAll(profiles, XYProfile_indx, VelocProfile_indx)
[lHandle, num_columns, fig] = createFig;

output_vec = AllCalculations(profiles, XYProfile_indx, VelocProfile_indx);
output_vec.lHandle = lHandle;
output_vec.num_columns = num_columns;
output_vec.fig = fig;
PlotAllFunc(output_vec);

end