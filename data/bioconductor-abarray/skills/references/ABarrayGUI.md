AB1700 Microarray Data Analysis

Yongming Andrew Sun, Applied Biosystems
sunya@appliedbiosystems.com

October 29, 2025

1 ABarray GUI

The ABarrayGUI can be used to perform analysis on AB1700 output. The analysis is the same as the command-line
version of ABarray. To start the GUI, perform the following in R:

> library(ABarray)

Loading required package: Biobase
Loading required package: tools

Welcome to Bioconductor

Vignettes contain introductory material.
To view, simply type 'openVignette()' or start with 'help(Biobase)'.
For details on reading vignettes, see the openVignette help page.

Loading required package: multtest
Loading required package: survival
Loading required package: splines

Welcome to Applied Biosystems AB1700

This package performs analysis for AB1700
gene expression data

> ABarrayGUI()

Loading required package: tcltk
Loading Tcl/Tk interface ... done
<Tcl>

GUI window starts (Figure 1). There are several options need to be selected.

2 GUI options

As with the command-line version, two files should be ready before analysis can be performed. One is design file, the
other one is data file. See document ABarray.pdf for information how to prepare these 2 files.

• DesignFile: Press Browse File to navigate and select the design file. Once design file is selected, the R working

directory will change to where the design file is located.

• DataFile: Press Bowse File to navigate and select the data file to be used.

• Choose impute function: There are 2 impute functions available.

1

AB1700 Gene Expression

• Use t test:
subgroups).

If this is selected, t test will be performed on the specified group (and ANOVA if more than 2

• Specify t test group: Which group should the t test be performed on? Even if you do not intend to perform t test,
you should supply the group information, as the ordering of array experiments relies on the group information.
The group is automatically selected from the design file (the first group in the disign file).

• Specify filtering options

– S/N threshold: The S/N threshold a probe is considered detectable.
– % Detect Samples: The percentage of samples in any given subgroup in which a probe can be detected in

order to be included in t test or ANOVA analysis. Note, the number is in decimal format.

• Perform Analysis: Press the button to begin data analysis.

Once the analysis is done, the following message will appear:

******Analysis completed******

and the GUI window (Figure 1) will go away.

Figure 1: ABarray GUI window

2

ABarray package

