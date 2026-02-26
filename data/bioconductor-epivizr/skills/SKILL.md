---
name: bioconductor-epivizr
description: This tool provides an interactive interface for visualizing genomic data by establishing two-way communication between R/Bioconductor and the Epiviz web browser. Use when user asks to start an Epiviz session, plot genomic objects like GRanges or SummarizedExperiment, navigate the genome browser from R, or manage synchronized interactive visualizations.
homepage: https://bioconductor.org/packages/release/bioc/html/epivizr.html
---


# bioconductor-epivizr

name: bioconductor-epivizr
description: Interactive visualization of genomic data using the epivizr R package. Use this skill to create two-way communication between R/Bioconductor and the Epiviz web app, allowing for interactive genome browsing, plotting GRanges, SummarizedExperiment, and ExpressionSet objects, and managing synchronized visualizations.

# bioconductor-epivizr

## Overview

The `epivizr` package provides an interface between R/Bioconductor and the Epiviz interactive web-based genome browser. It uses Websockets to enable two-way communication: data from R can be pushed to the browser as tracks or plots, and interactions in the browser (like "brushing" or navigating) can be reflected back in the R session.

## Core Workflow

### 1. Initialize the App
Start the Epiviz session to open the browser and establish the connection.

```r
library(epivizr)
# Start app and open browser
app <- startEpiviz(workspace="optional_workspace_id")

# Windows users: Use service() to allow R to respond to UI requests
# app$server$service() 
```

### 2. Adding Data Tracks and Plots
Use the `plot` method to send Bioconductor objects to the browser. The package automatically handles object types like `GRanges`, `ExpressionSet`, and `SummarizedExperiment`.

```r
# Add a genomic regions track (Blocks)
blocks_chart <- app$plot(my_granges, datasource_name="Methylation Blocks")

# Add a line track for base-pair resolution data
means_track <- app$plot(my_curves, datasource_name="Mean Meth", type="bp", columns=c("cancerMean", "normalMean"))

# Add a scatter plot for ExpressionSet (MA plot)
eset_chart <- app$plot(maEset, datasource_name="MAPlot", columns=c("colonA", "colonM"))
```

### 3. Customizing Charts
Modify settings (margins, step size, interpolation) and colors dynamically.

```r
# List available settings for a chart type
app$chart_mgr$print_chart_type_info("BlocksTrack")

# Update an existing chart
blocks_chart$set(settings=list(minBlockDistance=50), colors=c("#FF0000", "#00FF00"))

# Update data in an existing track without creating a new one
ms_obj <- app$get_ms_object(blocks_chart)
app$update_measurements(ms_obj, new_granges_subset)
```

### 4. Navigation and Interaction
Control the browser state from R.

```r
# Navigate to a specific location
app$navigate("chr11", 110000000, 120000000)

# Run a slideshow through a list of regions
app$slideshow(granges_list, n=5)
```

### 5. Managing the Session
List active charts, save the workspace, or stop the app.

```r
# List all active charts
app$chart_mgr$list_charts()

# Remove a specific chart
app$chart_mgr$rm_chart(means_track)

# Save workspace state to an RDA file
app$save(file="my_workspace.rda", include_data=TRUE)

# Stop the app and close connection
app$stop_app()
```

## Tips for Effective Use
- **Windows Compatibility**: On Windows, the R session is blocking. You must call `app$server$service()` to allow the browser to fetch data, then hit `Esc` to return to the R prompt.
- **Data Types**: 
    - Use `type="bp"` for base-pair resolution data (Line tracks).
    - Use `type="block"` for region-based data (Blocks tracks).
- **Remote Data**: You can integrate local R data with remote data hosted on the Epiviz server using `app$load_remote_measurements()`.
- **Printing**: Use `app$chart_mgr$print_chart(chart_object, file_type="pdf")` to export specific visualizations.

## Reference documentation
- [Introduction to epivizr: interactive visualization for genomic data](./references/IntroToEpivizr.md)