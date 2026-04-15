---
name: r-rpmg
description: The RPMG package provides a lightweight framework for creating interactive R sessions using buttons and mouse clicks on plots. Use when user asks to create interactive plots, add buttons to R graphics, or build simple graphical user interfaces for data picking and analysis.
homepage: https://cran.r-project.org/web/packages/rpmg/index.html
---

# r-rpmg

## Overview
The `rpmg` (Really Poor Man's GUI) package provides a lightweight framework for creating interactive R sessions. It allows users to interact with plots using buttons and mouse clicks without requiring complex external GUI toolkits like Tcl/Tk or Gtk. It is widely used as a foundation for interactive data picking and analysis in packages like `RSEIS` and `GEOmap`.

## Installation
To install the package from CRAN:
```R
install.packages("RPMG")
```

## Core Workflow: The RPMG Loop
The primary way to use `rpmg` is through a `while` loop that listens for user interaction on a plot.

### 1. Define Buttons
Create a vector of character strings that will serve as button labels.
```R
buttons <- c("ZOOM IN", "ZOOM OUT", "RESET", "QUIT")
```

### 2. Initialize the Plot
Use `which_ptype` or standard R plotting functions to set up the initial view.

### 3. The Interaction Loop
Use `get_buttonclick` to capture user input.
```R
while(TRUE) {
  # Plot your data here
  plot(x, y)
  
  # Add the buttons to the plot
  # labels: button text, col: button colors, pch: button shapes
  iloc <- which_ptype(buttons) 
  
  # Wait for user click
  click <- locator(1)
  if(is.null(click)) break
  
  # Identify which button was pressed
  selection <- check_button(click$x, click$y, iloc)
  
  if(selection == "QUIT") break
  if(selection == "ZOOM IN") {
    # Update logic
  }
}
```

## Key Functions
- `rowBUTTONS`: Low-level function to draw a row of buttons on a plot.
- `which_ptype`: Sets up the geometry for button placement.
- `check_button`: Determines if a coordinate (from `locator`) falls within a defined button area.
- `get_buttonclick`: A wrapper to handle the click-and-identify process.
- `textrect`: Draws a rectangle with text inside, useful for custom UI elements.
- `itoxyz`: Converts interactive coordinates to specific data indices.

## Tips for Interactive Sessions
- **Screen Refresh**: Always wrap the plotting logic inside the loop so the screen refreshes after every interaction.
- **Color Coding**: Use the `col` argument in button functions to highlight active states or group functional buttons.
- **Exit Strategy**: Always provide a "QUIT" or "DONE" button to ensure the user can break out of the `while` loop gracefully.
- **Coordinate Systems**: `rpmg` works within the standard R graphics coordinate system. If you resize the window, you may need to recalculate button positions.

## Reference documentation
- [RPMG Home Page](./references/home_page.md)