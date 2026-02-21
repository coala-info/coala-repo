# LimmaGUI Developers' Guide

## The limmaGUI environment

`limmaGUI` creates an R environment called `limmaGUIenvironment` within the
global environment `.GlobalEnv` and stores information about a particular data set in this
environment. When the user saves or loads a "Limma File" (.lma) i.e. an RData file, it would be a
mistake to include objects related to the basic windows and menus included in limmaGUI. For example,
if limmaGUI's main TK Toplevel window `ttMain` had a window ID of 5 and another version
of the `ttMain` object was loaded from disk with an ID of 6, then trying to activate (focus)
this window may give an error because there may be no valid widget with an ID of 6.

All of the objects described below can be found within the environment, `limmaGUIenvironment`.

## Global Objects

|  |  |
| --- | --- |
| **LimmaFileName** | Initialized to "Untitled", LimmaFileName is displayed in the title bar and will store the full filename (with path) of any file saved or opened. |
| **limmaDataSetNameText** | Initialized to "Untitled", limmaDataSetNameText is displayed above the left status window. The filename may differ from the data set name, e.g. the data set "Swirl" could be saved as "SwirlArraysLoaded.lma" or "SwirlLinearModelComputed.lma". (The "Text" at the end of the variable name was meant to distinguish it from the Tk label widget containing this text.) |

## Status Objects

|  |  |
| --- | --- |
| **ArraysLoaded** | Initialized to FALSE, then set to TRUE after a set of arrays has been succesfully loaded. This flag variable is often checked before attempting to plot a graph which requires that some data be loaded. |
| **RG.Available** | Initialized to FALSE, then set to TRUE after a set of arrays has been succesfully loaded. This is really the same thing as ArraysLoaded. It is used after an RData file is loaded, to set the tree widget in the left status window to show whether an RG object is available. |
| **Layout.Available** | Initialized to FALSE, then set to TRUE after a layout has been specified, usually after the user has clicked "OK" from the layout entry dialog. It is used after an RData file is loaded, to set the tree widget in the left status window to show whether a layout object (maLayout) is available. |
| **MA.Available** | Initialized to a list of FALSE's, MA.Available contains attributes Raw, WithinArrays, BetweenArrays and Both, specifying which MA objects are available. The user may want to experiment with different normalization options. The current interface encourages them to at least stick with one within-array method for a while (e.g. the M Box plots simply ask whether to normalize within arrays and whether to normalize between - the user must explicitly say whether to change the within-array normalization method in the Normalization menu.) The intention of this was to make the main decisions seem simple to the user (within arrays? and between arrays?) and to store up to four MA objects, so that when the same MA object is requested again for a particular plot (e.g. within-yes, between-no) , it does not need to be recomputed unless the within-array normalization method has been changed. |
| **LinearModelComputed[NumParameterizations]** | Initialized to a vector of FALSE's, each component contains a TRUE or FALSE revealing whether a linear model fit is available for the parameterization indexed by this component of the vector. |

## Raw Objects

These objects have meaning before M and A are computed, i.e. before normalization and before linear modelling.

|  |  |
| --- | --- |
| **maLayout** | A list with components ngrid.r, ngrid.c, nspot.r and nspot.c giving the layout of spots on the arrays. |
| **RG** | An object of class RGList (which can be treated as a standard R list) with attributes R (red foreground intensity), G (green foreground intensity), Rb (red background intensity) and Gb (green background intensity). If the user chooses to avoid background correction when loading the arrays, the Rb and Gb attributes will be removed from the RG object. |
| **GALFile** | The full filename (with path) for the GAL file (currently required, even for input files which would not normally need a GAL file). |
| **gal** | The GAL file stored as a data frame. |
| **NumSlides** | The number of slides (determined from the number of rows in the Targets file). |
| **NumRNATypes** | The number of RNA types, determined from the number of unique entries in the Cy3 and Cy5 columns of the Targets file. |
| **SlideNamesVec** | A vector of slide names, determined from the Name column of the Targets file if it exists, otherwise "Slide 1", "Slide 2" etc. based on the SlideNumber column of the Targets file. The SlideNumber column is currently compulsory. It should be made optional eventually. |
| **Targets** | A dataframe containing the RNA Targets (from the Targets file). See the documentation on input files for a description of the Targets file. |
| **SpotTypes** | A dataframe containing the spot types (from the Spot Types file). See the documentation on input files for a description of the Spot Types file. Note that column headings of "Color" and "PointSize"(optional) can be used, or "col and "cex"(optional). |
| **SpotTypeStatus** | A vector giveing the status of each spot e.g. "gene", "control" or "blank". |
| **ndups** | The number of times each spot is replicated on each array (e.g. 1 for no duplicates, or 2 for pairs of duplicates.) |
| **spacing** | The spacing between duplicate spots, (1 for consecutive duplicates and n/2 for duplicates halfway down an array with n spots). |
| **WeightingType** | A string describing the spot quality weighting type (to be displayed in the left status window), e.g. "None", or "wtarea (160,170)", meaning that the limma function wtarea was used to specify that spots with areas between 160 and 170 pixels were of good quality and spots outside this range should be weighted down. |
| **AreaLowerLimit** | Only relevant for image-processing files of type "Spot". The lower limit (in pixels) for good quality spots, e.g. 160. |
| **AreaUpperLimit** | Only relevant for image-processing files of type "Spot". The upper limit (in pixels) for good quality spots, e.g. 170. |
| **numConnectedSubGraphs** | For a connected design, the number of parameters estimated in the linear model by limmaGUI is one less than the number of RNA types, but for an unconnected design things are a little more complicated. The number of parameters to be estimated is the number of RNA types minus the number of connected subgraphs (which would be 1 for a connected design). |
| **connectedSubGraphs** | A list containing the connected sub graphs in the experimental design. |

## Objects Relating to M, i.e. log2(R/G) and A, i.e. 0.5log2(RG)

|  |  |
| --- | --- |
| **MA** | Originally this was the working MA object but this is being phased out and replaced with MAraw, MAwithinArrays, MAbetweenArrays and MAboth, so that the user can request plots using different versions of M and A (e.g. normalized within arrays only or normalized within arrays and between arrays) without having to recompute them. |
| **MAraw** | An MAList object (can be treated as a standard list), with attributes M and A, containing raw (unnormalized) M and A values, calculated from MA.RG(RG). In recent versions of limmaGUI, MAraw is always created after the arrays are loaded, whereas the other MA objects, are only created when required for a plot or a linear model. When limmaGUI is first launched, each MA objects is initialized to an empty list in the function initGlobals. |
| **MAwithinArrays** | An MAList object with attributes M and A, containing M and A values which have been normalized wihtin arrays (using WithinArryNormalizationMethod). If the user changes the within-array normalization method, then all MA objects which depend on this method will be reset to an empty list, and be displayed as "Not available" in the left status window. |
| **MAbetweenArrays** | An MA object containing M and A value which have been normalized between arrays only (rare) or an empty list if unavailable. |
| **MAboth** | An MA object containing M and A value which have been normalized within arrays and then between arrays, or an empty list if unavailable. |
| **WithinArrayNormalizationMethod** | A string describing the current WithinArrayNormalizationMethod, one of "printtiploess","loess","median","composite" or "robustspline". See the function GetNormalizationMethod in normalize.R. |
| **MA.Available** | A list, initialized to list(FALSE,FALSE,FALSE,FALSE), with attributes Raw, WithinArrays, BetweenArrays and Both. This list keeps track of which MA objects are available. The function OpenLimmaFile checks this list and then modifies the left status window's tree widget to show the user which MA objects are available. One reason why the user might want to know which MA objects are available is that they may want to know why a plot is taking a long time - whether it is because M and A need to be normalized for that plot or whether normalized versions are already available. |

## Objects Relating to the Linear Model

|  |  |
| --- | --- |
| **ParameterizationList** | A list, which will be empty when no linear models have been created, and will contain one element (a list) after one linear model had been created. ParameterizationList[[1]] will contain a number of objects related to the (first) linear model and some related to the tree widget displayed for that linear model. Some of the attributes should be familiar to limma users: genelist, fit, eb, dupcor. The attributes WhetherToNormalizeWithinArrays and WhetherToNormalizeBetweenArrays contain "yes" or "no" depending on the user's normalization decisions for this linear model fit. There should be an attribute called WithinArrayNormalizationMethod, e.g. containing "printtiploess", but at the time of writing a bug was found: an occurence of [[WithinArrayNormalizationMethod]] instead of [["WithinArrayNormalizationMethod"]], so there may be an attribute called "printtiploess" or similar in some ParameterizationLists. The attribute designList is a list containing the design matrix (called "design") and a Boolean variable designCreatedFromDropDowns which is TRUE if the design was specified as pairs of RNA types e.g. Knockout vs Wild Type. If so, the design will be displayed in this way when the user requests "view parameterization". If not, it can only be displayed as a matrix. The attribute SpotTypesForLinearModel is a vector of Boolean values specifying which spot types were included in the linear model, e.g. c(TRUE,FALSE) if genes were included but not controls. The attribute NumContrastParameterizations contains the number of contrast parameterizations, i.e. the number of contrast matrices corresponding to the current design matrix. The attribute ContrastsParameterizationTreeIndexVec is the contrasts version of ParameterizationTreeIndexVec. The attribute "Contrasts" is a list containing objects related to the contrasts parameterization. Other attributes correspond to nodes in the Tcl/Tk tree widget and contain the text displayed at these nodes. |
| **NumParameterizations** | The number of parameterizations/linear models store for the current data set. This is initialized to 0. Most analyses would require only one parameterization, but the Weaver example in the limma userguide demonstrates why it might be of interest to try two different design matrices for the same set of arrays. For another application, two different parameterizations may have the same design matrix but a different subset of spots (e.g. gene only vs gene and control). |
| **ParameterizationNamesVec** | A vector containing the names of the parameterization(s) as strings. The parameterization name(s) are displayed in the right status window (as tree roots) and also in the left status window (as branches of the node Parameterizations). |
| **ParameterizationTreeIndexVec** | If three parameterizations are created and then the second one is deleted, the remaining two parameterizations will be stored in ParameterizationList as ParameterizationList[[1]] and ParameterizationList[[2]], but unfortunately, the author has not yet learnt a way to modify the names of the nodes in the corresponding Tcl/Tk tree widget, so they will still effectively be numbered 1 and 3 after 2 has been deleted. ParameterizationTreeIndexVec is used to map from a parameterizationIndex (e.g. 2) to a parameterizationTreeIndex (e.g. 3). The ParameterizationList can be indexed with a number, e.g. [[1]] or [[2]], but it can also be indexed with a string containing the (unique) name of the corresponding node of the Tcl/Tk tree widget which will depend on parameterizationTreeIndex rather than parameterizationIndex. Note that a Tcl/Tk tree node has a unique name created internally e.g. "Node.1", which is designed to avoid "special Tcl characters", and also a text string which is displayed for the user. |
| **NumParameters** | The number of parameters to be initially estimated in the linear model. Currently global, i.e. for all parameterizations, users are expected to estimate the number of parameters suggested by limmaGUI (one less than the number of RNA types for a connected design), then users may estimate additional contrasts later on. |
| **LinearModelComputed[NumParameterizations]** | A vector, initialized to c(FALSE,FALSE,FALSE,...). Only the first NumParameterizations components have meaning. For each parameterization, the corresponding component of this vector is set to TRUE, once a linear model fit has been computed. |