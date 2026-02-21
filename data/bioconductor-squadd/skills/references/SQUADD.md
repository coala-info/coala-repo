SQUAD simulation results analysis using the
SQUADD package

Martial Sankar

April 24, 2017

1 SQUADD: the SQUAD add-on

Logical modeling is increasingly popular method in system biology to explain
and predict the behavior of a complex process (diﬀerentiation, cell growth, divi-
sion etc. . . ) through their regulatory and signalling mechanisms. The SQUAD
software (Standardized Qualitative Dynamical Systems) is dedicated to the anal-
ysis of Boolean logical models [1]. It was the ﬁrst tool to combine the traditional
Boolean approach and a continuous system. This novel feature permits the dy-
namical analysis of regulatory network in the absence of kinetic data [5], [4],
[1]. In order to improve this approach, we provide the R package SQUADD, the
SQUAD add-on. This extension permits: (i) to simplify the visualization of the
initial SQUAD simulation output, (ii) to generate qualitative predictions of the
component change between two conditions and (iii) to assess the coherence of a
network model using PCA analysis.

2 Example of SQUAD Simulation

1. SQUAD software can be downloaded at http://www.enfin.org/wiki/

doku.php?id=enfin:squad:start.

2. Install and open it.

3. Create a network model or use the xml ﬁle, containing a sample model
complete model 511.xml for the following steps. Load it in SQUAD.

4. To visualize the network, click on the View tab.

5. Then Advance, then Perturbator.

6. Click on Edit Perturbator to set the pertubation on your model or load the
provided pertubation ﬁle, pert samples m511.prt if you use the sample
model.

7. Click Initialize, then click run to run simulations with perturbations.

8. When the simulation window appears, press Ctrl+T to open the result
table and save it (Ctrl+S) into a folder. When naming ﬁles, add an index
number in the ﬁle name (i.e. 1 lof.txt, 2 rescue.txt etc. . . ). This folder

1

should contain six ﬁles, one for each perturbated model simulation (for the
sample network, folder and ﬁles can be found in the zip ﬁle, simRes.zip,
or in the data folder of the SQUADD package).

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
> folder <- file.path(fpath,"data_IAA")
> sim <- simResService (folder=folder,
+
+
+
+
+

time= 45,
ncolor=5,

method="lowess")

legend= c("ARF(a)", "ARF(i)", "AR_Genes", "Aux/IAA",
"BES1/BZR1","BIN2","BR","BRI1BAK1","BRR_Genes","BRX","BR_Biosynthesis","BZR1","DO","IAA","IAA_Biosynthesis","NGA1", "PIN", "SCFTir1","StimAux", "StimBR"), indexDeno=1,

3.1 Display the simulation matrix

The plotSimMatrix method permits to analyse the individual node’s behavior
during each perturbated condition. The shape of the response curve reﬂects the
network topologies and the initial SQUAD parameters (Figure 1). The user can
select the node to analyse by ﬁlling the selectNode attribute of the object.

2

> sim["selectNode"] <-c("DO","IAA_Biosynthesis","BR_Biosynthesis", "IAA", "BR")
> plotSimMatrix(sim)

/tmp/RtmpbaAlon/Rinst422771c0f41/SQUADD/extdata/data_IAA/brx_1_normal.txt
/tmp/RtmpbaAlon/Rinst422771c0f41/SQUADD/extdata/data_IAA/brx_2_brxlof.txt
/tmp/RtmpbaAlon/Rinst422771c0f41/SQUADD/extdata/data_IAA/brx_3_brrescue.txt
/tmp/RtmpbaAlon/Rinst422771c0f41/SQUADD/extdata/data_IAA/brx_4_brxarfi.txt
/tmp/RtmpbaAlon/Rinst422771c0f41/SQUADD/extdata/data_IAA/brx_5_brxarfiRescue.txt
/tmp/RtmpbaAlon/Rinst422771c0f41/SQUADD/extdata/data_IAA/brx_6_gain.txt

Figure 1: Simulation matrix for the selected ﬁve nodes, DO, IAA Biosynthesis, BR
Biosynthesis, IAA and BR (respectively in black, red, green, blue, cyan). The columns
represent the nodes, the rows represent the conditions. Each cell shows the speciﬁc
response curve for the corresponding conditions. The red line is the least-square ﬁtted
line. It indicates the tendancy of the response.

3

lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllxyy= 0.002 x + 0.8260.00.40.802040lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllxyy= 0.004 x + 0.4640103050lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllxyy= 0.001 x + 0.4050103050lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllxyy= −0.001 x + 0.2350103050lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllxyy= 0.002 x + 0.3390103050lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllxyy= −0.007 x + 0.8670.00.40.802040lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllxyy= −0.017 x + 0.6950103050lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllxyy= −0.01 x + 0.3740103050lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllxyy= −0.005 x + 0.2910103050lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllxyy= −0.009 x + 0.3340103050lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllxyy= 0.004 x + 0.7240.00.40.802040lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllxyy= −0.012 x + 0.4550103050lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllxyy= −0.01 x + 0.3720103050lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllxyy= −0.002 x + 0.2270103050lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllxyy= 0.001 x + 0.2490103050lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllxyy= −0.008 x + 0.8740.00.40.802040lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllxyy= −0.011 x + 0.4510103050lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllxyy= −0.01 x + 0.3680103050lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllxyy= −0.003 x + 0.2390103050lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllxyy= −0.008 x + 0.3290103050lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllxyy= 0.001 x + 0.7310.00.40.802040lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllxyy= −0.011 x + 0.4430103050lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllxyy= −0.009 x + 0.3620103050lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllxyy= −0.002 x + 0.2270103050lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllxyy= 0 x + 0.2160103050llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllyy= 0.003 x + 0.8290.00.40.802040llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllyy= 0.001 x + 0.6150103050llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllyy= −0.002 x + 0.4670103050llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllyy= 0 x + 0.2380103050llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllyy= −0.001 x + 0.40301030503.2 Obtain the matrix of ﬁtted values

The getFittedTable method permits to obtain a matrix of the interpolated value
of the response curve at a user-deﬁned time point. The interpolation can be done
either linearly or locally (lowess). Users can choose one of them by ﬁlling the
method attribut of an object of Class SquadSimResServiceImpl. In this example,
the values were interpolated using the lowess method at t=45 (see section 3).

> tab <- getFittedTable(sim)

3.3 Display the prediction heatmap

Biological experiments generate more and more quantitative data. However,
classical logical models are prone to reﬂect the qualitative nature of a system,
but fail to predict the outcome of biological experiments that yield quantitative
data. SQUAD was the ﬁrst software to assess this issue. It was built around a
standardized method [3] that translate a Boolean model into a continuous one.
The SQUADD package through the plotPredMap method takes full advantage
of this novel feature. It generates a heatmap of predictions of the component’s
activation state change between two experiments. A ratio is therefore calcu-
lated between the interpolated values of the current condition (numerator) and
a reference condition (denominator). The latter is chosen by setting the index-
Deno attribut. In this example we chose indexDeno=1 (see section 3), which
corresponds to the index of the ﬁrst result ﬁle brx 1 normal.txt (Figure 2).

> plotPredMap(sim)

4

Figure 2: Prediction heatmap. The rows represent the ratios between conditions,
the columns represent the network components. The blue intensities (from white to
dark blue) show the activation patterns (respectively, from under-activated to over-
activated).

5

ARF(a)ARF(i)AR_GenesAux/IAABES1/BZR1BIN2BRBRI1BAK1BRR_GenesBRXBR_BiosynthesisBZR1DOIAAIAA_BiosynthesisNGA1PINSCFTir1StimAuxStimBRbrx_2_brxlof.txt vs brx_1_normal.txtbrx_3_brrescue.txt vs brx_1_normal.txtbrx_4_brxarfi.txt vs brx_1_normal.txtbrx_5_brxarfiRescue.txt vs brx_1_normal.txtbrx_6_gain.txt vs brx_1_normal.txt3.4 Display the correlation circle

We suggest to use a principal component analysis (PCA) to assess the coherance
of the prediction supplied by one model. PCA can be visualized as a correla-
tion circle, which can be displayed by applying the plotCC method of the Class
SquadSimResServiceImpl (Figure 3).

> # Fill the field conditionList of the object sim
> sim["conditionList"] <- c("Normal", "brxlof", "BRrescue","brxarfilof","brxarfiBRrescue", "brxgof")
> plotCC(sim)

6

Figure 3: Correlation circle. The vectors represent the variables. The variables
correspond to the perturbated conditions (Normal (wildtype), brxlof (brx loss of func-
tion), BRrescue (BR rescue the brx loss of function phenotype ), brxarﬁlof (double loss
of function mutant brx arﬁ), brxarﬁRescue (BR rescue the double mutant phenotype),
brxgain (BRX gain of function)). The ﬁrst two PCs explained 80.3% of the varia-
tion. The angle between the vectors indicate the correlation between the variables.
The closer two vectors are, the better the correlation is. In this ﬁgure, the angle be-
tween the wild type condition and the the BRX loss of function conditions (brxlof and
brxarﬁlof) are very close meaning that the correlation exists between the two variables.
This is contradictory with biological ﬁndings , where loss of function mutants display
shorter root [2]. Moreover, the angle between the normal and the rescue conditions
is more than 90 degrees, meaning no correlation. These results demonstrate that the
model coherence is weak, meaning that the model still needs to be reﬁned (change
interaction sign, remove or add nodes etc. . . ).

7

−1.0−0.50.00.51.0−1.0−0.50.00.51.0data_IAAcomp 1 (56.8%)comp 2 (23.5%)NormalbrxlofBRrescuebrxarfilofbrxarfiBRrescuebrxgof4 Session info

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

8

6 Reference

References

[1] Di Cara A, Garg A, De Micheli G, Xenarios I, and Mendoza L. Dynamic
simulation of regulatory networks using squad. BMC Bioinformatics, 2007.

[2] Scacchi E, Osmont KS, Beuchat J, Salinas P, Navarrete-Gomez M, Trigueros
Mand Ferrandiz C, and Hardtke CS. Dynamic, auxin-responsive plasma
membrane-to-nucleus movement of arabidopsis brx. Development, 2009.

[3] Mendoza L and Xenarios I. A method for the generation of standard-
ized qualitative dynamical systems of regulatory networks. Theor Biol Med
Model, 2006.

[4] Philippi N, Walter D, Schlatter R, Ferreira K, Ederer M, Sawodny O, Tim-
mer J, Borner C, and Dandekar T. Modeling system states in liver cells:
survival, apoptosis and their modiﬁcations in response to viral infection.
BMC Syst Biol., 2009.

[5] Yara-Elena Sanchez-Corrales, Elena R. Alvarez-Buylla, and Luis Mendoza.
The arabidopsis thaliana ﬂower organ speciﬁcation gene regulatory network
determines a robust diﬀerentiation process. Journal of Therapeutic Biotech-
nology, 2010.

9

