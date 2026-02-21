GOsummaries basics

Raivo Kolde raivo.kolde@eesti.ee

October 30, 2018

Contents

1

2

3

Introduction .

.

.

.

.

.

.

.

.

.

.

.

.

Elements of a GOsummaries plot

Usage of GOsummaries .

.

.

.

.

3.1

3.2

3.3

Conﬁguring the GO analysis .

Adding expression data .

.

.

.

Conﬁguring the plot appearance .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

4

Using other annotation sources for word clouds .

4.1

4.2

Attributes.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

Displaying gene names instead of GO categories .
.
4.2.1

Example: metagenomics .

.

.

.

.

.

.

.

.

5

Session info .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

1

Introduction

.

.

.

.

.

.

.

.

.
.

.

.

.

.

.

.

.

.

.

.
.

.

.

.

.

.

.

.

.

.

.
.

.

.

.

.

.

.

.

.

.

.
.

.

.

.

.

.

.

.

.

.

.
.

.

.

.

.

.

.

.

.

.

.
.

.

.

.

.

.

.

.

.

.

.
.

.

.

.

.

.

.

.

.

.

.
.

.

1

1

2

3

4

6

7

8

8
9

10

GOsummaries is a package to visualise Gene Ontology (GO) enrichment analysis results on
gene lists arising from diﬀerent analyses such clustering or PCA. The signiﬁcant GO categories
are visualised as word clouds that can be combined with diﬀerent plots summarising the
underlying data.

2

Elements of a GOsummaries plot

Figure 1 shows an example of plot generated with GOsummaries package. All the GOsum-
maries plots have more or less the same layout, however, the elements are adjusted corre-
sponding to the underlying analysis. The plot is built of components (Fig 1A) that represent
a gene list or a pair of gene lists as in Fig 1. Each component is composed of two parts the
word cloud(s) (Fig 1E), representing the GO annotations of the gene lists, and a panel (Fig

GOsummaries basics

1C) that displays the underlying data experimental data.
In this case the panel shows the
expression values of the corresponding genes. There are also slots for the component title
(Fig 1B) and some additional information about the gene lists (Fig 1D).

In the word clouds the sizes of the GO categories indicate the strength of enrichment, relative
to the other results of the same query. To make global comparison of the strength of
enrichment possible we use diﬀerent shades of grey.

Figure 1: Elements of a GO summaries ﬁgure

3

Usage of GOsummaries

In most cases the GOsummaries ﬁgures can be created using only two commands: gosum
maries to create the object that has all the necessary information for drawing the plot and
plot.gosummaries to actually draw the plot.

The gosummaries function requires a set of gene lists as an input. It applies GO enrichment
analysis to these gene lists using g:Proﬁler (http://biit.cs.ut.ee/gproﬁler/) web toolkit and
saves the results into a gosummaries object. Then one can add experimental data and
conﬁgure the slots for additional information.

However, this can be somewhat complicated. Therefore, we have provided several con-
venience functions to that generate the gosummaries objects based on the output of the
most common analyses. We have functions gosummaries.kmeans,gosummaries.prcomp and

2

cell.line VS brainG1 > G2: 2168G1 < G2: 2132cell cycle phasemitotic cell cyclecell cycle checkpointnuclear divisionCell Cycle, MitoticDNA replicationresponse to DNA damage stimuluscell divisionmRNA metabolic processtranslationCell cyclechromosome segregationanaphase−promoting complex−depen...RNA processingDNA ReplicationCell Cycle Checkpointscellular component biogenesis at...ncRNA metabolic processregulation of ubiquitin−protein ...spindle organizationpositive regulation of protein u...cellular macromolecular complex ...positive regulation of ligase ac...chromosome organizationRNA transportinterspecies interaction between...negative regulation of ubiquitin...DNA recombinationDNA damage response, signal tran...DNA conformation changeviral reproductionregulation of mitosisp53 signaling pathwayestablishment of organelle local...protein complex subunit organiza...regulation of cellular amino aci...protein N−linked glycosylationintracellular protein transportprotein N−linked glycosylation v...DNA−dependent transcription, ter...multicellular organismal signalingneuron developmentneuron projection developmentneuron projection morphogenesisregulation of synaptic transmissioncentral nervous system developmentregulation of membrane potentialbehavioraxon guidanceregulation of nervous system dev...regulation of neuron differentia...ion transportneurotransmitter transportGlutamatergic synapsetransmembrane receptor protein t...cytoskeleton organizationGABAergic synapsesynapse organizationgeneration of a signal involved ...Retrograde endocannabinoid signa...cognitionDopaminergic synapseion transmembrane transportpurine nucleoside triphosphate m...secretion by cellOpioid SignallingLong−term potentiationvesicle−mediated transportGTP catabolic processregulation of transporter activityGastric acid secretionMorphine addictionpositive regulation of cellular ...Calcium signaling pathwaynegative regulation of cellular ...regulation of small GTPase media...actin filament−based processregulation of cellular localizationSalivary secretionregulation of cell morphogenesis...muscle VS hematopoietic.systemG1 > G2: 1527G1 < G2: 1159cardiovascular system developmentmuscle structure developmentmuscle system processcell adhesiongeneration of precursor metaboli...energy derivation by oxidation o...muscle tissue developmentGlucose Regulation of Insulin Se...anatomical structure formation i...circulatory system processcell migrationactin filament−based processorgan morphogenesiscell morphogenesis involved in d...response to endogenous stimulusregulation of cell migrationParkinson's diseaseenzyme linked receptor protein s...Dilated cardiomyopathyneuron projection morphogenesisregulation of system processFocal adhesionCardiac muscle contractiontaxisacetyl−CoA metabolic processwound healingglucose metabolic processOxidative phosphorylationregulation of anatomical structu...Hypertrophic cardiomyopathy (HCM)tissue morphogenesisAlzheimer's diseaseECM−receptor interactionHuntington's diseaseextracellular matrix organizationresponse to inorganic substancecell junction assemblyArrhythmogenic right ventricular...epithelium developmentGlucose metabolismcell activationpositive regulation of immune sy...regulation of immune responsehemopoiesisimmune effector processresponse to other organismleukocyte migrationinnate immune responsecytokine productioncell chemotaxishemostasislymphocyte proliferationblood coagulationinflammatory responseadaptive immune responseresponse to cytokine stimulusinterspecies interaction between...positive regulation of catalytic...regulation of defense responsepositive regulation of protein m...integrin−mediated signaling pathwayregulation of hydrolase activityvesicle−mediated transportpeptidyl−tyrosine phosphorylationregulation of protein phosphoryl...positive regulation of cytokine ...positive regulation of cytokine ...actin polymerization or depolyme...positive regulation of lymphocyt...cell adhesionregulation of protein kinase act...induction of apoptosisnegative regulation of programme...Hematopoietic cell lineageprotein complex subunit organiza...intracellular protein kinase cas...Chemokine signaling pathwayNatural killer cell mediated cyt...positive regulation of leukocyte...Leukocyte transendothelial migra...hematopoietic.system VS cell.lineG1 > G2: 1221G1 < G2: 1289cell activationinnate immune responseregulation of immune responsepositive regulation of immune sy...response to other organismimmune effector processcytokine productionleukocyte differentiationleukocyte migrationresponse to cytokine stimulusinflammatory responseregulation of defense responsecell chemotaxisSignaling in Immune systemlymphocyte proliferationadaptive immune responsepositive regulation of cytokine ...hemostasisblood coagulationMeaslesintracellular protein kinase cas...interspecies interaction between...Osteoclast differentiationintegrin−mediated signaling pathwaypeptidyl−tyrosine modificationB cell receptor signaling pathwaypositive regulation of cell deathNatural killer cell mediated cyt...Chemokine signaling pathwayHemostasisnegative regulation of immune sy...Hematopoietic cell lineageregulation of cytokine biosynthe...cell adhesionpositive regulation of cytokine ...negative regulation of programme...regulation of response to extern...regulation of phosphorylationpositive regulation of lymphocyt...nucleotide−binding domain, leuci...cell cycle phasemitotic cell cycleregulation of cell cycle processCell Cycle, Mitoticnuclear divisioncell divisionanaphase−promoting complex−depen...regulation of ubiquitin−protein ...chromosome segregationpositive regulation of ubiquitin...Cell Cycle CheckpointsDNA ReplicationCell cycleresponse to DNA damage stimulusnegative regulation of ubiquitin...negative regulation of ligase ac...cytoskeleton organizationDNA replicationspindle organizationprotein complex assemblyregulation of cellular amine met...DNA damage response, signal tran...cellular amino acid metabolic pr...sister chromatid segregationProteasomeDegradation multiubiquitinated C...Ornithine metabolismDegradation of beta−catenin by t...Degradation of ubiquitinated CD4APC/C:Cdh1−mediated degradation ...regulation of mitosisRegulation of activated PAK−2p34...Proteasome mediated degradation ...cell morphogenesis involved in d...regulation of cyclin−dependent p...p53 signaling pathwaygland morphogenesisinterspecies interaction between...cell migrationtissue morphogenesisTissuebraincell linehematopoietic systemmuscleEnrichment P−value10−7010−351ABCDEGOsummaries basics

gosummaries.MArrayLM, for k-means clustering, principal component analysis (PCA) and lin-
ear models with limma. These functions extract the gene lists right from the corresponding
objects, run the GO enrichment and optionally add the experimental data in the right format.

The gosummaries can be plotted using the plot function. The ﬁgures might not ﬁt into the
plotting window, since the plot has to have rather strict layout to be readable. Therefore, it
is advisable to write it into a ﬁle (ﬁle name can be given as a parameter).

Creating a simplest GOsummaries plot, starting from the gene lists goes as follows (example
taken from ?GOsummaries):

+

+

> # Define gene lists
> genes1 = c("203485_at", "209469_at", "209470_s_at", "203999_at",
+

"205358_at", "203130_s_at", "210222_s_at", "202508_s_at", "203001_s_at",
"207957_s_at", "203540_at", "203000_at", "219619_at","221805_at",
"214046_at", "213135_at", "203889_at", "209990_s_at", "210016_at",
"202507_s_at","209839_at", "204953_at", "209167_at", "209685_s_at",
"211276_at", "202391_at", "205591_at","201313_at")
+
> genes2 = c("201890_at", "202503_s_at", "204170_s_at", "201291_s_at",
+

"202589_at", "218499_at", "209773_s_at", "204026_s_at", "216237_s_at",
"202546_at", "218883_s_at", "204285_s_at", "208659_at", "201292_at",
"201664_at")

+

+

+

> gl = list(List = list(genes1, genes2)) # Two lists per component

> # Construct gosummaries objects

> gs = gosummaries(gl)

> plot(gs, fontsize = 8, filename = "figure2.pdf")

Figure 2: Simplest GO summaries ﬁgure

In this example we had only the gene lists and no additional data to display in panel. In these
situations GOsummaries displays by default just the number of genes.

These gene lists can be also displayed as separate components if the input gene list would
have been constructed a bit diﬀerently.

> gl = list(List1 = genes1, List2 = genes2)

3.1

Conﬁguring the GO analysis

Main task for the gosummaries function is to perform the GO enrichment analysis. To be able
to ﬁt the GO enrichment results into the word cloud, we have to reduce their number quite a
bit. We have deﬁned some default parameters for this. Still, there might be a need to adjust
those parameters. These parameters apply to all versions of the gosummaries function.

3

ListG1: 28G2: 15Transmission across Chemical Syn...regulation of plasma membrane bo...regulation of neuron projection ...Dopaminergic synapseSynaptic vesicle cycleneuron projection morphogenesismitotic cell cycleCell Cycle, MitoticEnrichment p−value10-510-2.51GOsummaries basics

In the ﬁrst step we throw out results from less interesting GO branches. For example,
by default we throw out results from Molecular Function and Cellular Component branch,
since the results are often not as interesting. But this behaviour can be changed using the
go_branches parameter.

Then we throw out categories that are either too big or too small, since very small categories
might not describe the gene list as a whole and very large categories on contrary can be too
generic. The exact values for these parameters can be controlled by parameters min_set_size
and max_set_size

Finally we have set an upper limit for the number of categories to display, this can be
changed using max_signif parameter. Of course, one can change also the p-value threshold
with max_p_value.

It is also important to note that we assume, that the gene lists are ordered. If they are not
then the option ordered_query should be set to FALSE.

3.2

Adding expression data

In case of clustering and diﬀerential expression there is an option to display expression data
alongside the word clouds (see Figure 1). In there, each boxplot represents the distribution
of expression values of the genes in the current list in one particular sample.
If samples
correspond to diﬀerent classes, tissues or treatments then it can be shown with diﬀerent
colours.

In gosummaries.kmeans and gosummaries.MArrayLM we have special parameters to add the
expression data and its annotations: exp and annotation. The exp variable takes in an
expression matrix, where rows correspond to genes and columns to samples. The correct
expression values are extracted, based on the row names. Therefore, gene names in the
gene list have to be present in the expression matrix. The annotation parameter accepts a
data.frame where each row describes one sample. Therefore, the column names of exp have
to be present in the row names of annotation.

Here is an example of adding the expression data:

> data(tissue_example)
> # Filter genes and perform k-means
> sd = apply(tissue_example$exp, 1, sd)
> exp2 = tissue_example$exp[sd > 0.75,]
> exp2 = exp2 - apply(exp2, 1, mean)

> kmr = kmeans(exp2, centers = 6, iter.max = 100)

> # Create gosummaries object

> exp2[1:6, 1:5]

GSM123197.CEL 356362160.CEL GSM123234.CEL 356360072.CEL

1294_at
1405_i_at
200002_at
200003_s_at
200005_at
200008_s_at

-0.4670833

-0.7170833

-0.9470833

-0.5270833

-0.8975000

-1.1775000

-0.5875000

-0.9275000

-0.3045833

-0.8645833

-0.6345833

-0.7145833

-0.5841667

-1.0541667

-0.8141667

-0.8741667

-1.0491667

-0.3991667

-0.7791667

-1.0291667

-0.5475000

-0.5275000

-0.8775000

-0.1675000

1294_at

356362624.CEL

-0.6870833

4

GOsummaries basics

1405_i_at
200002_at
200003_s_at
200005_at
200008_s_at

-1.4975000

-0.9745833

-0.8241667

-0.6591667

-0.5675000

> head(tissue_example$annot)

Tissue

Meta15

Meta4

GSM123197.CEL brain solid tissue non neoplastic disease disease

356362160.CEL brain solid tissue non neoplastic disease disease

GSM123234.CEL brain

normal solid tissue

normal

356360072.CEL brain solid tissue non neoplastic disease disease

356362624.CEL brain

356367950.CEL brain

normal solid tissue

normal

normal solid tissue

normal

> gs_kmeans = gosummaries(kmr, components = 1:2, exp = exp2, annotation = tissue_example$annot)
> plot(gs_kmeans, fontsize = 8, classes = "Tissue", filename = "figure3.pdf")

Figure 3: K-means plot with added expression data

If one wants to add expression data to a custom gosummaries object then it is possible to
use a function add_expression.gosummaries that adds the expression data to an existing
gosummaries object. The other parameters exp and annotation work as described above.
For example, if we want to add expression data to the gosummaries object from the ﬁrst
example, we can write.

> data(tissue_example)
> gs_exp = add_expression.gosummaries(gs, exp = tissue_example$exp,
annotation = tissue_example$annot)
Using

as id variables

Using

as id variables

5

Cluster 1n: 1646mitotic cell cycle processCell Cyclecell divisioncell cycle phase transitionsymbiont processMetabolism of RNADNA ReplicationDNA metabolic processmitotic sister chromatid segrega...amide biosynthetic processCell cycleregulation of cell cycle processribonucleoprotein complex biogen...translationDNA conformation changeRNA localizationnegative regulation of cell cyclenuclear transportRNA processingTranslationCellular responses to stressHost Interactions of HIV factorsmicrotubule cytoskeleton organiz...Protein processing in endoplasmi...protein localization to organellemRNA metabolic processRegulation of ornithine decarbox...positive regulation of cell cyclecellular response to DNA damage ...protein foldingresponse to inorganic substancenegative regulation of cell deathAsymmetric localization of PCP p...ribonucleoprotein complex subuni...RHO GTPases Activate Forminsresponse to drugregulation of protein localizationnucleobase−containing compound t...nucleobase−containing compound c...regulation of cellular protein l...Cluster 2n: 451myeloid leukocyte activationinnate immune responseleukocyte degranulationleukocyte activation involved in...leukocyte mediated immunityregulation of immune responsecytokine−mediated signaling pathwayresponse to other organismNeutrophil degranulationcytokine productionCytokine Signaling in Immune systemleukocyte migrationlymphocyte activationinflammatory responseleukocyte cell−cell adhesionregulation of defense responseleukocyte chemotaxisleukocyte differentiationregulation of leukocyte activationinterspecies interaction between...negative regulation of immune sy...leukocyte proliferationAdaptive Immune Systemregulation of leukocyte migrationregulation of leukocyte cell−cel...positive regulation of response ...response to lipopolysaccharideLeishmaniasisStaphylococcus aureus infectionHerpes simplex infectionCell adhesion molecules (CAMs)antigen processing and presentationcellular defense responsephagocytosisViral myocarditisTuberculosisPhagosomenegative regulation of multi−org...Antigen processing−Cross present...Hematopoietic cell lineageTissuebraincell linehematopoietic systemmuscleEnrichment p−value10-5010-251GOsummaries basics

3.3

Conﬁguring the plot appearance

The layout of the plot is ﬁxed. However, it is still possible to conﬁgure some parameters. For
example, the proportions of the panel area with parameters panel_height and panel_width.
The unit for these measures is lines of text. Using these units keeps the proportions of the
plot similar even if we change the fontsize. The panel height parameter is most useful if
one wants to omit the panel area completely. Then one can set the panel_height to 0.

The content of the panels is drawn by the function that is speciﬁed in the panel_plot param-
eter. If one uses the built-in functions, such as gosummaries.prcomp, gosummaries.kmeans,
etc. then the most suitable panel drawing function is selected automatically. Without any
expression data, only the number of genes is displayed in there. In case of PCA, we display
projection of the values to the principal component as histogram. For clustering and dif-
ferential expression we show the boxplots of the expression in diﬀerent samples.
Instead of
boxplot, one can use also the violin plot (panel_violin) or combination of boxplot and violin
plot (panel_violin_box).

All the panel drawing functions basically generate a ggplot2 plot based on the Data slot in a
component of gosummaires object. From there we extract the plot area to display in panel
In principle it is possible to deﬁne your own functions, as long as its
and also the legend.
input and output are match our functions and it conforms to the data in the Data slot in the
components of gosummaires object. See the help of panel_boxplot and the source of these
functions for more information.

If one wants to make smaller changes to the panels, such as, change the colour scheme,
then for this we have easier means than deﬁning new panel function. With the param-
eter panel_customize one can specify a function that modiﬁes the plot created with the
panel_plot function. For example the default function customize looks like this.

function(p, par){
p = p + ggplot2::scale_fill_discrete(par$classes)
return(p)

}

To select a diﬀerent colour scheme one can modify that function and and give it to the
plot.gosummaires function.

> cust = function(p, par){

+

+

p = p + scale_fill_brewer(par$classes, type = "qual", palette = 2)
return(p)

+ }
> plot(gs_kmeans, panel_plot = panel_violin, panel_customize = cust,
+ classes = "Tissue", components = 1:2, filename = "ex3.pdf")

6

GOsummaries basics

Figure 4: K-means plot with modiﬁed color scheme and violin plots instead of boxplots

4

Using other annotation sources for word clouds

Right now the default pipeline always runs a g:Proﬁler query on the given genes and displays
the results as word clouds. However, there are several situations where it would be reasonable
to use data from some other source in the word clouds. For example, other GO enrichment
tools might give more reasonable results.

For such cases there is a parameter wc_data in gosummaries.default where one can enter
arbitrary data that will be shown on word clouds. The input structure is similar to the gene
list input , only instead of vectors with gene names it requires data frames with two columns:
"Term" and "Score". Where Term is the text that is being drawn and Score determines its
size.

> wcd1 = data.frame(Term = c("KLF1", "KLF2", "POU5F1"), Score = c(0.05, 0.001, 0.0001))

> wcd2 = data.frame(Term = c("CD8", "CD248", "CCL5"), Score = c(0.02, 0.005, 0.00001))

To get one word cloud per block use ﬂat list.

> gs = gosummaries(wc_data = list(Results1 = wcd1, Results2 = wcd2))
> plot(gs, filename = "figure5.pdf")

To get two word clouds per block use neted lists.

> # To get two word clouds per block use neted lists
> gs = gosummaries(wc_data = list(Results = list(wcd1, wcd2)))
> plot(gs, filename = "figure6.pdf")

7

Cluster 1n: 1646mitotic cell cycle processCell Cyclecell divisioncell cycle phase transitionsymbiont processMetabolism of RNADNA ReplicationDNA metabolic processmitotic sister chromatid segrega...amide biosynthetic processCell cycleregulation of cell cycle processribonucleoprotein complex biogen...translationDNA conformation changeRNA localizationnegative regulation of cell cyclenuclear transportRNA processingTranslationCellular responses to stressHost Interactions of HIV factorsmicrotubule cytoskeleton organiz...Protein processing in endoplasmi...protein localization to organellemRNA metabolic processRegulation of ornithine decarbox...positive regulation of cell cyclecellular response to DNA damage ...protein foldingresponse to inorganic substancenegative regulation of cell deathAsymmetric localization of PCP p...ribonucleoprotein complex subuni...RHO GTPases Activate Forminsresponse to drugregulation of protein localizationnucleobase−containing compound t...nucleobase−containing compound c...regulation of cellular protein l...Cluster 2n: 451myeloid leukocyte activationinnate immune responseleukocyte degranulationleukocyte activation involved in...leukocyte mediated immunityregulation of immune responsecytokine−mediated signaling pathwayresponse to other organismNeutrophil degranulationcytokine productionCytokine Signaling in Immune systemleukocyte migrationlymphocyte activationinflammatory responseleukocyte cell−cell adhesionregulation of defense responseleukocyte chemotaxisleukocyte differentiationregulation of leukocyte activationinterspecies interaction between...negative regulation of immune sy...leukocyte proliferationAdaptive Immune Systemregulation of leukocyte migrationregulation of leukocyte cell−cel...positive regulation of response ...response to lipopolysaccharideLeishmaniasisStaphylococcus aureus infectionHerpes simplex infectionCell adhesion molecules (CAMs)antigen processing and presentationcellular defense responsephagocytosisViral myocarditisTuberculosisPhagosomenegative regulation of multi−org...Antigen processing−Cross present...Hematopoietic cell lineageTissuebraincell linehematopoietic systemmuscleEnrichment p−value10-5010-251GOsummaries basics

Figure 5: User supplied wordcloud data as two components

Figure 6: User supplied wordcloud data as one components

One can also add the gene lists when specifying wc_data, but they can be in many cases
omitted. This option makes it easy to incorporate the GO enrichment results from other
tools.

4.1

Attributes

Several general properties of the plot are stored in the attributes of gosummaries object. If
needed, these can be changed using the attr function.

• score_type: Speciﬁes how to handle the scores associated to words in word clouds.
In case of "count", the score is expected to be positive and the word sizes are directly
proportional to the scores.
In case of "p-value", the word sizes are proportional to
of the score.
− log10

• wc_algorithm Speciﬁes the word cloud layout algorithm.

In case of "top", the word
placement starts from the top corner, in case of "middle" from the centre of left or
right side of the box.

• wordcloud_legend_title Gives the title of the word cloud.

4.2

Displaying gene names instead of GO categories

If the gene lists or the whole dataset is very small then the GO analysis might not give many
In these cases it would be more reasonable to show the names of genes
signiﬁcant results.
instead. It is possible to add the gene lists as described above with wc_data. However, more
convenient means are implemented for PCA, limma and MDS results in gosummaries.prcomp,
gosummaries.MArrayLM and gosummaries.matrix respectively.

8

Results1 POU5F1KLF2KLF1Results2 CCL5CD248CD8P−value10-510-2.51Results POU5F1KLF2KLF1CCL5CD248CD8P−value10-510-2.51GOsummaries basics

In each case there is a parameter show_genes that toggles if gene names or GO categories
are shown. The parameters to decide the importance for diﬀerent genes vary between these
functions. For PCA we use the size of the component loadings, for limma we use the adjusted
p-value and for MDS we use the p-values of Spearman rank correlation with the components.

As gene identiﬁers in expression matrices can be unintelligible then by default these functions
convert the identiﬁers into gene names using gconvert function from gProﬁleR package. It
is possible to turn this function oﬀ as well by setting parameter gconvert_target to NULL.

These options are especially important when use GOsummaries on data that is not describing
genes. For example, PCA analysis is often used for other high throughput experiments, such
as metabolomics and metagenomics. Using the GOsummaries approach on these datasets
can be very revealing.

4.2.1 Example: metagenomics

Principal Coordinate Analysis is very common on metagenomics data. To conveniently vi-
sualise these results with GOsummaries, there is a function gosummaries.matrix. Since the
rows represent taxa instead of genes we cannot use GO enrichment analysis, but we can show
the names of taxons.

> data(metagenomic_example)
> # Run Principal Coordinate Analysis on Bray-Curtis dissimilarity matrix
> pcoa = cmdscale(vegdist(t(metagenomic_example$otu), "bray"), k = 3)
> # By turning off the GO analysis we can show the names of taxa
> gs = gosummaries(pcoa, metagenomic_example$otu, metagenomic_example$annot,
+

show_genes = T, gconvert_target = NULL, n_genes = 30)

> plot(gs, class = "BodySite", fontsize = 8, file = "figure7.pdf")

9

GOsummaries basics

Figure 7: Visualisation of PCoA results on metagenomic data

5

Session info

> sessionInfo()

R version 3.5.1 Patched (2018-07-12 r74967)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 16.04.5 LTS

Matrix products: default

BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so

LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so

locale:
[1] LC_CTYPE=en_US.UTF-8

LC_NUMERIC=C

10

Component 1   BacteroidalesBacteroidetesClostridialesClostridiaPorphyromonadaceaeLachnospiraceaeFirmicutesVeillonellaceaeAlcaligenaceaeErysipelotrichaceaeXIVRoseburiaCoprococcusBlautiaDialisterSubdoligranulumOscillibacterCoprobacillusPrevotellaceaeAnaerotruncusFaecalibacteriumBacteroidesRuminococcaceaeXIIIButyricicoccusParabacteroidesDoreaBurkholderialesRuminococcusAnaerostipesActinobacteriaActinomycetalesPropionibacteriaceaePropionibacteriumStaphylococcusBacillalesStaphylococcaceaePseudomonadalesAnaerococcusCorynebacteriaceaeCorynebacteriumPseudomonadaceaePseudomonasXIStreptophytaChloroplastCyanobacteriaBurkholderiaceaeRhizobialesComamonadaceaeRalstoniaCaulobacteraceaePeptoniphilusEnterobacterPelomonasXanthomonadaceaeMitsuokellaXanthomonadalesMycobacteriumDolosigranulumComponent 2   RuminococcaceaeParabacteroidesFaecalibacteriumOscillibacterAnaerotruncusBacteroidesRoseburiaButyricicoccusSubdoligranulumErysipelotrichaceaeCoprobacillusBlautiaRuminococcusCoprococcusXIVAlcaligenaceaePorphyromonadaceaeDoreaAlistipesRikenellaceaePhascolarctobacteriumDesulfovibrionalesLachnospiraceaeSporobacterBacteroidetesBacteroidalesParasutterellaAnaerostipesAcetivibrioAnaerovoraxBacilliLactobacillalesFirmicutesCarnobacteriaceaeStreptococcaceaeStreptococcusFusobacterialesFusobacteriumFusobacteriaceaeEpsilonproteobacteriaCampylobacteralesActinomycetaceaeCampylobacterCampylobacteraceaeCorynebacteriaceaeCorynebacteriumActinomycesLactobacillaceaeLactobacillusGranulicatellaNeisseriaGammaproteobacteriaMicrococcaceaeLeptotrichiaNeisseriaceaeLeptotrichiaceaeRothiaVeillonellaKingellaGemellaComponent 3   BacteriaBacteroidesParabacteroidesRuminococcaceaeRuminococcusXIVFaecalibacteriumBlautiaOscillibacterCoprococcusAlcaligenaceaeAnaerotruncusSubdoligranulumRoseburiaDoreaAlistipesCoprobacillusRikenellaceaeButyricicoccusLactobacillusFusobacterialesFusobacteriaceaeNeisseriaceaeFusobacteriumPorphyromonasKingellaCarnobacteriaceaeGranulicatellaVeillonellaEpsilonproteobacteriaCampylobacteralesCampylobacteraceaeCampylobacterLeptotrichiaceaeActinomycetaceaeProteobacteriaActinomycesGammaproteobacteriaLeptotrichiaPasteurellaceaeHaemophilusNeisseriaAerococcaceaeMoryellaActinobacillusMicrococcaceaeAbiotrophiaStreptococcaceaeCentipedaSpirochaetaceaeBodySiteeargutnasaloralskinvaginaSpearman p−value10-2510-12.51GOsummaries basics

[3] LC_TIME=en_US.UTF-8
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C
[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

attached base packages:

[1] stats

graphics grDevices utils

datasets

methods

base

other attached packages:
[1] ggplot2_3.1.0
vegan_2.5-3
[5] GOsummaries_2.18.0 Rcpp_0.12.19

loaded via a namespace (and not attached):
[1] RColorBrewer_1.1-2 compiler_3.5.1
gProfileR_0.6.7
[5] plyr_1.8.4
digest_0.6.18
[9] tools_3.5.1
gtable_0.2.0
[13] tibble_1.4.2
Matrix_1.2-14
[17] rlang_0.3.0.1
withr_2.1.2
[21] bindrcpp_0.2.2
knitr_1.20
[25] dplyr_0.7.7
glue_1.3.0
[29] tidyselect_0.2.5
reshape2_1.4.3
[33] limma_3.38.0
backports_1.1.2
[37] MASS_7.3-51
BiocStyle_2.10.0
[41] assertthat_0.2.0
[45] stringi_1.2.4
RCurl_1.95-4.11
[49] crayon_1.3.4

lattice_0.20-35

permute_0.9-4

pillar_1.3.0
bindr_0.1.1
nlme_3.1-137
mgcv_1.8-25
parallel_3.5.1
cluster_2.0.7-1
rprojroot_1.3-2
R6_2.3.0
purrr_0.2.5
scales_1.0.0
colorspace_1.3-2
lazyeval_0.2.1

BiocManager_1.30.3
bitops_1.0-6
evaluate_0.12
pkgconfig_2.0.2
yaml_2.2.0
stringr_1.3.1
grid_3.5.1
rmarkdown_1.10
magrittr_1.5
htmltools_0.3.6
labeling_0.3
munsell_0.5.0

11

