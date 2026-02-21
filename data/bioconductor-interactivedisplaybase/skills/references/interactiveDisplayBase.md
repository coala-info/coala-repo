```
library(interactiveDisplayBase)
```

# interactiveDisplayBase

[interactiveDisplayBase](http://bioconductor.org/packages/2.13/bioc/html/interactiveDisplayBase.html)

`interactiveDisplayBase` uses the function `display()` to host a browser based
application on the fly using the Shiny package. Shiny UI elements are available based on the
object passed to `display()`. These allow the user to modify how the plot is
displayed, and for some objects, modify or subset the data and send it back to
the console.

## Methods

Many of the display method will have a button that allows you return
subset values back to the R session. To use these, couple the intial
call with an assignment operator like this:

```
mtcars2 <- display(mtcars)
```

Once you leave the diplay web gui, the results of the above
interaction will be captured inside of mtcars2.

## Acknowledgments

Shiny
Joe Cheng and Winston Chang
<http://www.rstudio.com/shiny/>

Force Layout
Jeff Allen
<https://github.com/trestletech/shiny-sandbox/tree/master/grn>

gridSVG
Simon Potter
<http://sjp.co.nz/projects/gridsvg/>

Zoom/Pan JavaScript libraries
John Krauss
<https://github.com/talos/jquery-svgpan>
Andrea Leofreddi
<https://code.google.com/p/svgpan/>

JavaScript Color Chooser
Jan Odvarko
<http://jscolor.com/>

Data-Driven Documents
Michael Bostock
<http://d3js.org/>

Javascript for returning values from data.frames
Kirill Savin

Help with the display method for data.frames
Dan Tenenbaum