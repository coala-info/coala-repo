---
name: perl-gdgraph
description: This tool creates presentation-quality charts and graphs from data using the GD library. Use when user asks to generate bar charts, plot line graphs, create pie charts, or render visual reports from tabular data.
homepage: https://metacpan.org/pod/GDGraph
metadata:
  docker_image: "quay.io/biocontainers/perl-gdgraph:1.56--pl5321hdfd78af_0"
---

# perl-gdgraph

## Overview
The `perl-gdgraph` skill enables the automated creation of presentation-quality charts. It leverages the GD library to render data into various image formats (PNG, JPEG, GIF). This tool is particularly useful for generating visual reports from tabular data or bioinformatics pipelines where a lightweight, scriptable graphing solution is required without the overhead of a full GUI.

## Usage Patterns

### Basic Script Structure
To use GD::Graph, you must instantiate a specific chart object, provide data as an array of arrays, and write the output to a file handle.

```perl
use GD::Graph::bars; # Or lines, pie, points, area, mixed

my @data = ( 
    ["Jan", "Feb", "Mar", "Apr"], # X-axis labels
    [10, 22, 15, 18],             # Dataset 1
    [5, 8, 12, 10]                # Dataset 2
);

my $graph = GD::Graph::bars->new(400, 300);

$graph->set( 
    x_label           => 'Month',
    y_label           => 'Sales',
    title             => 'Monthly Performance',
    y_max_value       => 30,
    y_tick_number     => 6,
    y_label_skip      => 1,
    barplot_spacing   => 10,
) or die $graph->error;

my $gd = $graph->plot(\@data) or die $graph->error;

open(IMG, '>chart.png') or die $!;
binmode IMG;
print IMG $gd->png;
close IMG;
```

### Common Chart Types
- **GD::Graph::lines**: For time-series or continuous data.
- **GD::Graph::bars**: For categorical comparisons.
- **GD::Graph::points**: For scatter plots.
- **GD::Graph::pie**: For proportional data (requires a single data set).
- **GD::Graph::mixed**: Allows combining lines, points, and bars on one axes.

### Expert Tips
- **Data Format**: The first array in your data list is always the X-axis labels. Subsequent arrays are the Y-values for different datasets.
- **Error Handling**: Always check `$graph->error` after `set` and `plot` calls; GD::Graph fails silently otherwise.
- **Fonts**: If labels look poor, use `set_x_label_font` and `set_y_label_font` with TrueType (.ttf) paths for better anti-aliasing.
- **Colors**: Customize the palette using `$graph->set_clr_mutations` or by passing an array of hex codes to the `dclrs` attribute.
- **Aesthetics**: Use `long_ticks => 1` to create a grid effect and `transparent => 0` if you need a solid background for web embedding.

## Reference documentation
- [GDGraph Documentation](./references/metacpan_org_pod_GDGraph.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-gdgraph_overview.md)