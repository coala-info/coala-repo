---
name: r-shinybs
description: Adds easy access to additional Twitter Bootstrap components to Shiny. </p>
homepage: https://cloud.r-project.org/web/packages/shinyBS/index.html
---

# r-shinybs

## Overview
The `shinyBS` package bridges the gap between Shiny and several Bootstrap features. It allows developers to create more professional, interactive interfaces by adding tooltips, popovers, modal windows, and collapsible accordion groups directly from R code.

## Installation
Install the stable version from CRAN:
```r
install.packages("shinyBS")
```

## Main Components and Workflows

### 1. Tooltips and Popovers
Used to provide context-sensitive help or additional information without cluttering the UI.
- **Tooltips**: Small text labels that appear on hover.
- **Popovers**: Larger boxes that can contain titles and more descriptive content.

**Static Implementation (UI):**
```r
bsTooltip(id = "elementID", title = "Help text", placement = "right", trigger = "hover")
bsPopover(id = "elementID", title = "More Info", content = "Detailed explanation", placement = "top")
```

**Dynamic Implementation (Server):**
Use `addTooltip()` or `addPopover()` to attach these to elements created dynamically.

### 2. Modals
Modals are child windows that layer over the main application.
- **UI**: Define the structure with `bsModal(id, title, trigger, ...)`.
- **Server**: Control programmatically using `toggleModal(session, modalId, toggle = "open")`.

```r
# UI
actionButton("go", "Launch Modal")
bsModal("modalExample", "Data Summary", "go", size = "large", plotOutput("summaryPlot"))
```

### 3. Collapse (Accordions)
Organize content into collapsible panels to save vertical space.
- `bsCollapse()`: The container for panels.
- `bsCollapsePanel()`: Individual sections.
- **Server**: Use `updateCollapse()` to open or close panels based on logic.

```r
bsCollapse(id = "collapseExample", open = "Panel 1",
  bsCollapsePanel("Panel 1", "Content for panel 1", style = "primary"),
  bsCollapsePanel("Panel 2", "Content for panel 2", style = "success")
)
```

### 4. Alerts
Create non-intrusive status messages.
- **UI**: `alertsControlBar()` or `bsAlert(anchorId)`.
- **Server**: `createAlert(session, anchorId, alertId, title, content, style, append)` to trigger notifications.

## Tips and Best Practices
- **IDs**: Ensure the `id` or `anchorId` matches the `inputID` or `outputID` of the element you are attaching the component to.
- **Styles**: Many components support Bootstrap context classes: `default`, `primary`, `success`, `info`, `warning`, `danger`.
- **Dependencies**: `shinyBS` must be loaded (`library(shinyBS)`) for the custom tags to work in the UI.

## Reference documentation
- [shinyBS Home Page](./references/home_page.md)