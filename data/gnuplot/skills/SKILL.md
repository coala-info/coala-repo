---
name: gnuplot
description: Gnuplot creates professional charts and visualizations from command-line data or files using the feedgnuplot interface. Use when user asks to plot streaming data, visualize columns from a file, generate histograms, or create real-time line charts from system metrics.
homepage: https://github.com/dkogan/feedgnuplot
metadata:
  docker_image: "quay.io/biocontainers/gnuplot:5.2.3"
---

# gnuplot

## Overview
This skill focuses on using `feedgnuplot`, a flexible command-line interface that pipes data into gnuplot. It simplifies the process of turning STDIN or file-based data into professional charts. It is particularly effective for "quick-look" data analysis, monitoring live system metrics via streaming, and handling data formats where the X-axis (domain) or curve identifiers are embedded in the data stream.

## Common CLI Patterns

### Basic Plotting
Plot simple columns of data where the X-axis is the line number:
`seq 10 | awk '{print $1*$1}' | feedgnuplot --lines --points --title "Parabola"`

### Domain and Range
Use the first column as the X-axis (domain) and subsequent columns as Y-values:
`cat data.txt | feedgnuplot --domain --lines --xlabel "Time" --ylabel "Value"`

### Real-time Streaming
Visualize live data (e.g., network throughput) with a rolling window:
`command_generating_data | feedgnuplot --stream --xlen 10 --lines`
*   `--stream`: Enables live updates.
*   `--xlen [seconds]`: Sets the fixed width of the X-axis to show only the most recent data.

### Handling Multiple Curves
*   **Sequential**: By default, each column after the domain is a new curve.
*   **Tagged Data**: Use `--dataid` if your data is in the format `ID Value`.
    `printf "curveA 1\ncurveB 5\ncurveA 2\ncurveB 10" | feedgnuplot --dataid --autolegend`
*   **Vnlog Format**: Use `--vnlog` to automatically pull curve names from commented headers.

### Advanced Styling and Commands
Pass raw gnuplot commands for features not covered by standard flags:
*   **Grid and Legend**: `feedgnuplot --set "grid" --unset "key" ...`
*   **Specific Styles**: Use `--style [curveID] [style]` or `--with` for all curves.
    `feedgnuplot --with "linespoints" --style 0 "with lines lw 3"`

### Output Formats
*   **Interactive**: Default behavior opens a gnuplot window.
*   **Hardcopy**: Save directly to a file.
    `feedgnuplot --hardcopy "output.pdf" --lines`

## Expert Tips
*   **Data Parsing**: `feedgnuplot` is flexible; lines do not need the same number of points. It will create new curves as new columns appear.
*   **Secondary Y-Axis**: Use `--y2 [column_index]` to plot a specific data column on the right-hand axis.
*   **Histogramming**: Use `--histo [column_index]` to generate histograms instead of line plots.
*   **Terminal Persistence**: If generating a plot and exiting immediately, ensure the terminal stays open or use `--hardcopy`.

## Reference documentation
- [feedgnuplot README and Manual](./references/github_com_dkogan_feedgnuplot.md)