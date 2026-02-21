# Troubleshooting Window Focus Problems

## The Problem

When running ***limmaGUI*** under the ***Windows*** operating system, it is common for users to experience
problems with window focusing. If running ***Rgui*** in Multiple Document Interface (**MDI**) mode, than the main ***Rgui***
windows often tries to steal the focus from the ***limmaGUI*** windows. This problem is not specific to ***limmaGUI***, but
is a general problem with running a Graphical User Interface built with ***Tcl/Tk*** (e.g. ***limmaGUI***) from
within ***Rgui*** for ***Windows***.

## The Short-Term Solution

For now, the best two solutions for ***Windows*** users are the following:

1. Run ***Rgui*** in **SDI** (Single Document Interface) mode:
   * Select "**GUI Preferences**" from the "**Edit**" menu, select "**SDI**", save your preferences and restart ***R***.
   * OR, edit the **`Rconsole`** file in the **`etc`** subdirectory of your **`R_HOME`** directory,
     (e.g. `C:\Program Files\R\rw1091\etc\Rconsole`).
2. If you still have problems, you can also minimize ***Rgui*** immediately after starting ***limmaGUI***.

## The Long-Term Solution (for advanced users/software developers)

Part of the problem is that under ***Windows***, you are trying to run two GUIs at once: ***Rgui*** and ***Tcl/Tk***.
The windows focus problems could possibly be avoided by rewriting ***limmaGUI*** in ***GraphApp***
(used to implement ***Rgui*** for ***Windows***),
but then ***limmaGUI*** wouldn't be portable to ***Linux*** and ***MacOS X***.

Another option is to rewrite the way in which ***Tcl/Tk***
is embedded in ***R*** for ***Windows***, (see the
[***tkEmbed***](http://bioinf.wehi.edu.au/folders/james/tkEmbed) link below),
but this would take some considerable work, and there is a feeling in the ***R*** core development team that the
***GraphApp*** ***Rgui*** may soon be replaced by something
else which is more platform-independent, such as a ***wxWidgets*/*wxPython*** GUI
(see the [***R-wxPython***](http://bioinf.wehi.edu.au/folders/james/wxPython) link below)
or a ***Java Swing*** GUI such as [***JGR***](http://stats.math.uni-augsburg.de/JGR/).

* [tkEmbed](http://bioinf.wehi.edu.au/folders/james/tkEmbed)
* [R-wxPython](http://bioinf.wehi.edu.au/folders/james/wxPython)
* [JGR (Java GUI for R)](http://stats.math.uni-augsburg.de/JGR/)