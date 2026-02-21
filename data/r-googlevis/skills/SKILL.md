---
name: r-googlevis
description: R package googlevis (documentation from project home).
homepage: https://cran.r-project.org/web/packages/googlevis/index.html
---

# r-googlevis

## Overview
The `googleVis` package provides an interface between R and the Google Chart Tools. It allows users to create interactive charts based on R data frames without uploading data to Google. The package generates HTML code containing the data and JavaScript calls to the Google Visualization API, which is then rendered in a web browser.

## Installation
To install the stable version from CRAN:
```R
install.packages("googleVis")
```

## Core Workflow
1. **Prepare Data**: Ensure data is in a standard R `data.frame`.
2. **Call Chart Function**: Use a `gvis<ChartType>` function (e.g., `gvisMotionChart`, `gvisGeoChart`).
3. **Visualize**: Use the `plot()` method to render the chart in your default browser.
4. **Export**: Use the `$html$chart` component to embed the visualization in other HTML documents or Shiny apps.

## Key Functions
- `gvisMotionChart(data, idvar, timevar)`: Creates an interactive five-dimensional chart (popularized by Hans Rosling).
- `gvisGeoChart(data, locationvar, colorvar, sizevar)`: Creates interactive maps (regions, markers, or text).
- `gvisTable(data)`: Creates a searchable, sortable HTML table.
- `gvisTreeMap(data, idvar, parentvar, sizevar, colorvar)`: Creates hierarchical tree maps.
- `gvisComboChart(data, xvar, yvar)`: Mixes lines, areas, and bars in one chart.
- `gvisMerge(x, y, horizontal)`: Combines two `googleVis` objects into a single page.

## Usage Example
```R
library(googleVis)

# Create a Geo Chart using the Exports dataset
Geo <- gvisGeoChart(Exports, locationvar="Country", 
                    colorvar="Profit",
                    options=list(width=600, height=400))

# Plot the chart (opens in browser)
plot(Geo)

# View the underlying HTML code
print(Geo)
```

## Tips and Best Practices
- **Internet Connection**: A modern browser and an active internet connection are required to load the Google JavaScript libraries.
- **Data Privacy**: Data is not sent to Google; it is embedded in the HTML file generated locally on your machine.
- **Options**: Most functions accept an `options` list that maps directly to Google Visualization API parameters (e.g., `list(colors="['#cbb69d', '#603913']", backgroundColor="lightblue")`).
- **Shiny Integration**: Use `renderGvis()` and `htmlOutput()` to include these charts in Shiny applications.
- **Naming Conventions**: All chart functions start with the prefix `gvis`.

## Reference documentation
- [NEWS.md](./references/NEWS.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)
- [wiki.md](./references/wiki.md)