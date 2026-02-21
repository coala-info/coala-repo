# Customizing the menus in limmaGUI (for Advanced users)

The pull-down menus in limmaGUI are defined in `limmaGUI-menus.txt` in the `etc`
subdirectory of the `limmaGUI` package installation. To find out exactly where this directory
is on your computer, you can paste the following into R:

```

system.file("etc",package="limmaGUI")
```

R source files can be added to this `etc` directory (and must have extension `.R`).

Try uncommenting (i.e. removing the # from) the histogram menu item in `limmaGUI-menus.txt`
to enable the histogram command in the plot menu.

You can add as many menu items as you wish.

The reason that the histogram example plots the graph in the standard R graphics device rather than in a Tk
window is simply to keep this example brief and avoid calling `tkrplot`. Generally graphs are plotted
in Tk windows and users of the Windows operating system can keep their main RGui window minimized while they
run `limmaGUI`.