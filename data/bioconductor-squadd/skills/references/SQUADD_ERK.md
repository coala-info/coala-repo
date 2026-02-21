Analysis of ERK dynamics using SQUAD and its
add-on SQUADD

Martial Sankar

April 24, 2017

1 SQUADD: the SQUAD add-on

Logical modeling is increasingly popular method in system biology to explain
and predict the behavior of a complex process (diﬀerentiation, cell growth, divi-
sion etc. . . ) through their regulatory and signalling mechanisms. The SQUAD
software (Standardized Qualitative Dynamical Systems) is dedicated to the anal-
ysis of Boolean logical models [1]. It was the ﬁrst tool to combine the traditional
Boolean approach and a continuous system. This novel feature permits the dy-
namical analysis of regulatory network in the absence of kinetic data ([6], [5],
[1]). In order to improve this approach, we provide the R package SQUADD,
the SQUAD add-on. It is built in respect to S4 classes and the methods con-
vention. This extension permits: (i) to simplify the visualization of the initial
SQUAD simulation output, (ii) to generate qualitative predictions of the com-
ponent change between two conditions and (iii) to assess the coherence of a
network model using PCA analysis.

The SQUADD uses are illustrated on the simpliﬁed model of the ERK sig-
naling in mammalian cells. The ERK cascade is composed of three major kinase
components, RAF MEK and ERK.

2 SQUAD Simulation of the ERK cascade

1. SQUAD software can be downloaded at http://www.enfin.org/wiki/

doku.php?id=enfin:squad:start.

2. Install and open it.

3. Load the network model in SQUAD. You can use the .net ﬁle, containing a
sample model sample model.net for the following steps. the ﬁle is located
in the extdata/data ERK directory of the SQUADD package.

4. To visualize the network, click on the View tab.

5. Then Advance, then Perturbator.

6. load the provided pertubation ﬁle, sample.prt.

7. Click Initialize, then click run to run simulations with perturbations.

1

8. When the simulation window appears, press Ctrl+T to open the result
table and save them (Ctrl+S) into a folder. When naming ﬁles, add an in-
dex number in the ﬁle name (i.e. 1 ERK sustained.txt, 2 mERK sustained.txt
etc. . . ). So, this folder should contain two *.txt ﬁles, one for each pertur-
bated model simulation.

3 Example of SQUADD analysis

> library(SQUADD)

The package was built using S4 classes and methods. Before launching a func-
tion, the user should call the constructor to construct an instance of the Class
SquadSimResServiceImpl.

The constructor is: simResService(). Do not forget to use the help() function

to obtain R help.

To obtain a table of ﬁtted values, construct the object of Class SquadSim-

ResServiceImpl:

> # construct instance of SquadSimResServiceImpl
> fpath <- system.file("extdata", package="SQUADD")
> folder <- file.path(fpath,"data_ERK")
> sim <- simResService (folder=folder,
+
+
+
+
+

indexDeno=1,
method="lowess")

time= 20,
ncolor=5,

legend= c("EGF", "ERK", "MEK", "RAF"),

3.1 Display the simulation matrix

The plotSimMatrix method permits to analyse the individual node’s behavior
during each perturbated condition. The shape of the response curve reﬂects the
network topologies and the initial SQUAD parameters (Figure 1). The user can
select the node to analyse by ﬁlling the selectNode attribute of the object.

The Figure 1 explains the dynamic of the ERK system components in two
conditions. In the ﬁrst condition (ﬁrst row), the system undergo a constant EGF
stimulation. The whole system, ERK, MEK and RAF, enter in an oscillatory
steady states as showing by the sustained oscillation of their response curve.
In the second condition (second row), the system is perturbated by a steady
inactivation of ERK (t=8) simulated an ERK loss of function mutant (black
curve). From t=8, MEK (red) and RAF (green) show a monotone response
curve. This two example of the dynamic of ERK signalling. The reality of
the ERK response is much more complex due to the topology of the feedback
interactions and due to kinetic parameters impossible to render using the simple
Logical formalism. For example, the oscillations can be sustained as shown in
Figure 1 or damped. More details can be found in [4] and [2]. User can take
full advantage of the plotSimMatrix method when having to deal with complex
network (cf SQUAD.pdf vignette).

2

> sim["selectNode"] <-c("ERK", "MEK", "RAF")
> plotSimMatrix(sim)

/tmp/RtmpbaAlon/Rinst422771c0f41/SQUADD/extdata/data_ERK/1_ERK-sustained.txt
/tmp/RtmpbaAlon/Rinst422771c0f41/SQUADD/extdata/data_ERK/2_mERK-sustained.txt
/tmp/RtmpbaAlon/Rinst422771c0f41/SQUADD/extdata/data_ERK/3_gERK-sustained.txt

Figure 1: Simulation matrix for the selected three nodes, ERK, MEK RAF, (respec-
tively in black, red, green). The columns represent the nodes, the rows indicate the
conditions. Each cell shows the speciﬁc response curve for each perturbated condition.
The red line is the least-square ﬁtted line. It indicates the tendancy of the response.

3

llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllxyy= 0.004 x + 0.4680.00.40.805101520llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllxyy= 0.001 x + 0.40405101520llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllxyy= 0 x + 0.34105101520llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllxyy= −0.028 x + 0.4920.00.40.805101520llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllxyy= 0.038 x + 0.32905101520llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllxyy= 0.041 x + 0.27805101520lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllyy= 0.029 x + 0.4680.00.40.80510152025lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllyy= −0.024 x + 0.460510152025lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllyy= −0.02 x + 0.37605101520253.2 Obtain the matrix of ﬁtted values

The getFittedTable method permits to obtain a matrix of the interpolated value
of the response curve at a user-deﬁned time point. The interpolation can be done
either linearly or locally (lowess). Users can choose one of them by ﬁlling the
method attribut of an object of Class SquadSimResServiceImpl. In this example,
the values were interpolated using the lowess method at t=45 (see section 3).

> tab <- getFittedTable(sim)

3.3 Display the prediction heatmap

Biological experiments generate more and more quantitative data. However,
classical logical models are prone to reﬂect the qualitative nature of a system, but
fail to predict the outcome of biological experiments that yield to quantitative
data. SQUAD was the ﬁrst software to assess this issue. It was built around a
standardized method [3] that translates a Boolean model into a continuous one.
The SQUADD package, through the plotPredMap method, takes advantage of
this novel feature.
It generates a heatmap of predictions of the component’s
activation level changes between two experiments. A ratio is therefore calculated
between the interpolated values of the current condition (numerator) and a
reference condition (denominator). The latter is chosen by setting the indexDeno
attribute. In this example we chose indexDeno=1 (see section 3).

> plotPredMap(sim)

The level of activation of the species can be cross either with the protein
expression level or with the gene expression level when studying gene regulatory
network. User can easily cross these values whith public available data or he can
target the most suitable experiments to conﬁrme or refute the tested hypothesis
(qPCR, FRET...).

4

Figure 2: Prediction heatmap. The rows represent the ratios between conditions
and the columns represent the network components. The blue intensities (from white
to dark blue) show the activation patterns (respectively, from under-activated to over-
activated).

5

EGFERKMEKRAF2_mERK−sustained.txt vs 1_ERK−sustained.txt3_gERK−sustained.txt vs 1_ERK−sustained.txt4 Session info

> sessionInfo()

R version 3.4.0 (2017-04-21)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 16.04.2 LTS

Matrix products: default
BLAS: /home/biocbuild/bbs-3.5-bioc/R/lib/libRblas.so
LAPACK: /home/biocbuild/bbs-3.5-bioc/R/lib/libRlapack.so

locale:

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_US.UTF-8
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

attached base packages:
[1] stats

graphics grDevices utils

datasets methods

base

other attached packages:
[1] SQUADD_1.26.0

loaded via a namespace (and not attached):
[1] compiler_3.4.0

tools_3.4.0

RColorBrewer_1.1-2

5 Perspectives

* better access to the plot function parameters

* Improve plotCC: Title to deﬁne, label of vector to localize

* Improve the simulation matrix: set row names (conditions) and column

names (selected nodes).

6

6 Reference

References

[1] Di Cara A, Garg A, De Micheli G, Xenarios I, and Mendoza L. Dynamic
simulation of regulatory networks using squad. BMC Bioinformatics, 2007.

[2] Nakayama K, Satoh T, Igari A, Kageyama R, and Nishida E. Fgf induces
oscillations of hes1 expression and ras/erk activation. Curr Biol., 2008.

[3] Mendoza L and Xenarios I. A method for the generation of standard-
ized qualitative dynamical systems of regulatory networks. Theor Biol Med
Model, 2006.

[4] Birtwistle MR, Hatakeyama M, Yumoto N, Ogunnaike BA, Hoek JB, and
Kholodenko BN. Ligand-dependent responses of the erbb signaling network:
experimental and modeling analyses. Mol Syst Biol, 2007.

[5] Philippi N, Walter D, Schlatter R, Ferreira K, Ederer M, Sawodny O, Tim-
mer J, Borner C, and Dandekar T. Modeling system states in liver cells:
survival, apoptosis and their modiﬁcations in response to viral infection.
BMC Syst Biol., 2009.

[6] Yara-Elena Sanchez-Corrales, Elena R. Alvarez-Buylla, and Luis Mendoza.
The arabidopsis thaliana ﬂower organ speciﬁcation gene regulatory network
determines a robust diﬀerentiation process. Journal of Therapeutic Biotech-
nology, 2010.

7

