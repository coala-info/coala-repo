DMRforPairs vignette

Martin A. Rijlaarsdam

October 30, 2018

1 Overview

Figure 1: Flowchart of the DMRforPairs algorithm. The user progresses verti-
cally through the pipeline while the algorithm uses the subsequent functions as
indicated by horizontal connectors. The tuning function for the DMRforPairs
parameters (min n and min distance) is not depicted, but can be used to explore
the number of regions identiﬁed/probes included for various pairs of settings.

This is a demo illustrating the usage of DMRforPairs (Figure 1). DMRfor-
Pairs is designed to identify Diﬀerentially Methylated Regions between unique
samples using array based methylation proﬁles. Regions are identiﬁed as ge-
nomic ranges with suﬃcient probes located in close proximity to each other and
which are optionally annotated to the same functional class (see reference man-
ual, merge classes() function). Diﬀerential methylation is evaluated by compar-
ing the methylation values within each region between individual samples and

1

(if the diﬀerence is suﬃciently large), testing this diﬀerence formally for statis-
tical signiﬁcance.

The following remarks apply to the vignette:

1. the ”annotate.signiﬁcant” and ”annotate” parameters have been set to
FALSE to facilitate the speed of building the package/vignette and to
allow running the vignette on computers that are not connected to the
internet. The power of DMRforPairs is however greatly enhanced by the
Gviz based visualizations that include annotation information from En-
sembl. Therefore, it is advised to change these parameters to TRUE if in-
ternet is avaliable. We recommend annotate.relevant to be set to FALSE
al all times unless very small sections of the genome are analyzed (see
documentation)

2. the vignette requires writing permissions in the working directory.

3. parallelization has been disabled in all examples as well as in this vignette.
This is done to provide polite code for people sharing compute cycles.

2 Setting up the data and settings

2.1 The Data

Load the data. This dataset provides the average methylation values on chro-
mosome 7 of two commercially available EBV transfected lymphoblastoid cell
lines from healthy individuals (NA17105 (African American male) and NA17018
(Chinese female)). The dataset also contains this data for the breast cancer cell
line MCF7 (Soule et al. 1973) and the HPV negative squamous-cell vulva car-
cinoma cell line A431 (Giard et al. 1973 and Hietanen et al. 1995). For a full
description of the dataset (+references) and its format, please see the reference
manual.

> library(DMRforPairs)
> data(DMRforPairs_data)

Columns 1 - 6 of the data indicate information about individual probes (n=29,974)
and their annotation. Columns 7 - 10 indicate M-values for all samples and
columns 11 - 14 represent the associated beta values.

2

> head(CL.methy,2)

cg00081087 cg00081087
cg00087298 cg00087298

targetID chromosome position class.gene.related
Body;Body;Body
7 34873912
TSS200
7 33149137

cg00081087
cg00087298

class.island.related

Island
NA17105.M NA17018.M

gene.symbol

MCF7.M
AAA1;NPSR1;NPSR1 -4.027028 -0.4932408
RP9 -13.872031 -12.2916392

A431.M

MCF7.beta NA17105.beta
cg00081087 -6.300535 -2.475343 5.782836e-02 0.4153514568 0.012827340
cg00087298 -8.549864 -12.007505 6.669415e-05 0.0003185493 0.003003211

A431.beta

NA17018.beta
cg00081087 0.1524629099
cg00087298 0.0004419503

2.2 The Settings

First, a number of possible settings for the min distance (the maximal distance
accepted between probes in a region) and min n (the minimal number of probes
in a region) are evaluated.

> parameters=expand.grid(min_distance = c(200,300), min_n = c(4,5))
> recode=1
> results.parameters = tune_parameters(parameters,
+ classes_gene=CL.methy$class.gene.related,
+ classes_island=CL.methy$class.island.related,
+ targetID=CL.methy$targetID,
+ chr=CL.methy$chromosome,
+ position=CL.methy$position,
+ m.v=CL.methy[,c(7:8)],
+ beta.v=CL.methy[,c(11:12)],
+ recode=recode,
+ gs=CL.methy$gene.symbol,
+ do.parallel=0)
> results.parameters

min_distance min_n n.regions n.valid.probes n.probes.included
178
228
154
216

589
589
589
589

200
300
200
300

40
50
32
43

4
4
5
5

[1,]
[2,]
[3,]
[4,]

In the rest of this vignette, the default setting of minimally 4 probes per region
is used. These have to be in < 200 bp distance of each other. The threshold
for a relevant median diﬀerence in M value between the samples is set to 1.4.
Benjamini Hochberg corrected p-values <0.05 are deemed signiﬁcant. The pa-
rameter experiment sets name of the experiment which is reﬂected in the name

3

of the folder with results that will be created in the working directory.

> min_n=4
> d=200
> dM=1.4
> pval_th=0.05
> experiment="results_DMRforPairs_vignette"
> method="fdr"
> clr=c("red","blue","green")

3 Run DMRforPairs

The algorithm is most conveniently executed by calling the wrapper for the anal-
ysis part (DMRforPairs()) which returns the results of all the separate steps.
DMRforPairs runs automatically, showing regular status updates. Analysis can
take quite long, especially on a genome wide scale (several hours). The demo
data should generally ﬁnish within a few minutes. The wrapper subsequently
performs:

1. Recoding of the probe classes according to a custom or build in scheme.

2. Identiﬁcation of regions with suﬃcient probe density (i.e. number of
probes and proximity) over all genomic regions at which probes are anno-
tated in the dataset .

3. Calculation of relevant statistics (e.g. median diﬀerence in M and beta
values) and performing of formal tests to see if the diﬀerence is signiﬁcant.

These steps are extensively described in the reference manual.

> output=DMRforPairs(
+ classes_gene=CL.methy$class.gene.related,
+ classes_island=CL.methy$class.island.related,
+ targetID=CL.methy$targetID,
+ chr=CL.methy$chromosome,
+ position=CL.methy$position,
+ m.v=CL.methy[,c(8:10)],
+ beta.v=CL.methy[,c(12:14)],
+ min_n=min_n,min_distance=d,min_dM=dM,
+ recode=recode,
+ sep=";",
+ method=method,
+ debug.v=FALSE,gs=CL.methy$gene.symbol,
+ do.parallel=0)

4

3.1 Examining the primary output of DMRforPairs

3.1.1 Recode probe classes (merge classes())

Orginal probe classes...

> head(output$classes$pclass,3)

[,1]

cg00081087 "Body;Body;Body;"
cg00087298 "TSS200;Island"
cg00139681 ";"

Recoded probe classes...

> head(output$classes$pclass_recoded,3)

[,1]

cg00081087 "gene;NA;NA"
cg00087298 "NA;tss;island"
cg00139681 "NA;NA;NA"

Row numbers of probes without a recoded class...

> head(output$classes$no.pclass,10)

[1] 3 6 13 15 17 33 38 41 46 50

Classes used for recoding...

> output$classes$u_pclass

[1] gene
Levels: gene island tss

island

tss

Merge classes returns a reduced set of probe data (annotation, M and beta
values) including only probes associated with at least one recoded class.
In
case of recode=2 this implicates all probes in the dataset. This reduced set of
probes is designated ”valid” in the remainder of this vignette and in the reference
manual.

3.1.2 Identify probe-dense regions (regionﬁnder())

Potential regions of interest...

> head(output$regions$boundaries,4)

chr start_bp

1
2
3
4

7 33080496 33080615
7 34118464 34118935
7 34873912 34874196
7 105172664 105173132

end_bp length_bp n_probes regionID regionIDall
1

4
5
4
5

1
2
3
4

ClassAll
gene
2;38 gene;island
gene
gene

3
4

120
472
285
469

5

Probes with associated class after recoding (valid probes)...

> head(output$regions$valid.probes,2)

cg00081087
cg00087298

rowID

probeID chr position
pClass
gene;NA;NA
7 34873912
7 33149137 NA;tss;island

1 cg00081087
2 cg00087298

Associated m and beta values for all samples for each valid probe...

> head(output$regions$valid.m,2)

MCF7.M NA17105.M NA17018.M
cg00081087 -0.4932408 -6.300535 -2.475343
cg00087298 -12.2916392 -8.549864 -12.007505

> head(output$regions$valid.beta,2)

MCF7.beta NA17105.beta NA17018.beta
cg00081087 0.4153514568 0.012827340 0.1524629099
cg00087298 0.0003185493 0.003003211 0.0004419503

Region to probe map: matrix of valid probes (rows) and recoded probe classes
(columns) with either NA if not included in any potential region of interest
or the ID of the region the probe is assigned to. By deﬁnition each probe
can only be associated to one region per class. Region IDs are speciﬁc to a
dataset and a set of DMRforPairs parameters. Region IDs are therefore not
interchangable between datasets/experiments and primarily serve as identiﬁers
during exploration of the dataset.

> head(output$regions$perprobe,4)

cg00081087
cg00087298
cg00156506
cg00280235

gene tss island
NA
35
NA
NA

3 NA
NA 14
NA NA
NA NA

6

3.1.3 Calculation of relevant statistics and testing (testregion())

This output is structured like output$regions$boundaries but is supplemented
with descriptive statistics and formal test results per region.

> head(output$tested,1)

chr start_bp

7 33080496 33080615

end_bp length_bp n_probes regionID regionIDall ClassAll
gene

120

4

1

1

beta.median.MCF7.beta beta.median.NA17105.beta beta.median.NA17018.beta
0.003629177

0.003448186

0.9848456

m.median.MCF7.M m.median.NA17105.M m.median.NA17018.M
-8.158476

-9.110979

6.094547

median.delta.beta.MCF7.M.minus.NA17105.M
0.9693837
median.delta.beta.MCF7.M.minus.NA17018.M
0.9685009

median.delta.beta.NA17105.M.minus.NA17018.M
-0.0001267329

median.delta.m.MCF7.M.minus.NA17105.M median.delta.m.MCF7.M.minus.NA17018.M
13.85861

14.6789

median.delta.m.NA17105.M.minus.NA17018.M pairwise.p.MCF7.M.vs.NA17105.M
0.02857143
-0.5443935

pairwise.p.MCF7.M.vs.NA17018.M pairwise.p.NA17105.M.vs.NA17018.M
0.1142857

0.02857143

max.abs.median.delta

14.6789 0.01246768

p.value p.value.adjusted
0.03562195

1

1

1

1

1

1

1

1

1

1

4 Export and visualization

The export data() function performs a complete export of all results to TSV,
pdf and png ﬁles for all (relevant) regions. These overviews are generated in
increasing detail for:

1. all regions

2. regions with a relevant diﬀerence (> dM) and

3. regions with a signiﬁcant diﬀerence.

HTML tables are used to access the results and describe the analysis (Figure
2). Thumbnails of the methation pattern of a region are presented in the tables
(2 and 3) as well as general statistics. Links to detailed statistics (tsv) and
(pairwise) visualizations (pdf) are provided. Regions with a relevant diﬀerence
can be looked up in the Ensembl database resulting in annotated ﬁgures of the
methylation pattern. Also, direct links to the regions in the Ensembl and UCSC

7

Figure 2: Example of the HTML output of DMRforPairs

genome browsers are presented.By default, DMRforPairs creates a folder (exper-
iment.name) within the current working directory for the output (export data()
function). This is done because a complete export generates a large number of
ﬁles. Visualization and export can take quite long depending on the status of
biomart (Ensembl).

> tested_inclannot=export_data(
+ tested=output$tested,
+ regions=output$regions,
+ th=pval_th,min_n=min_n,min_dM=dM,min_distance=d,
+ margin=10000,clr=clr,method=method,experiment.name=experiment,
+ annotate.relevant=FALSE,annotate.significant=FALSE,
+ FigsNotRelevant=FALSE,debug=FALSE)

Please see the ”results DMRforPairs vignette” folder in your working directory
for the output of the vignette.
PIK3CG was one of the genes strongly diﬀerentially methylated in 1 of the
samples relative to the other two. By clicking on the PDF link, the output
region can be further studied (Figure 3). Additional statistics are accessible via
the STATS link in the HTML table (signiﬁcant.html).

8

Figure 3: Diﬀerentially methylated region around the TSS of PIK3CG.
9

4.1 Examining the data further

There are also several functions to further explore the data based on the ﬁndings
after export. These will be discussed in this section. For example, region 16 was
highly relevant (median delta M=13.77). However, because of limited statistical
power (n=4) the region did not survive correction for multiple testing. We might
want to inquire this region further using the plot annotate region() function. By
default relevant, but non-signiﬁcant regions like 16 are not annotated. If we set
annotate to TRUE in the example below we can appreciate that even though
the number of probes is low (technical bias), the sudden consistent diﬀerence
between MCF7 occurs right around the transcription start site of BMPER and
the surrounding probes do not show this diﬀerential pattern (Figure 4). The
plot annotate region() function also reports back the complete set of statistics
and pairwise plots for the requested region.

10

> plot_annotate_region(output$tested,
+
+
+
+
+
+
+

output$regions,
margin=10000,
regionID=16,
clr=clr,
annotate=FALSE,
scores=TRUE,
path=experiment)

$symbols_exact
[1] ""

$symbols_margin
[1] ""

$scores

[,1]
0.9383
beta.median.MCF7.beta
0.0088
beta.median.NA17018.beta
0.0022
beta.median.NA17105.beta
4.0696
m.median.MCF7.M
-7.5344
m.median.NA17018.M
-9.4626
m.median.NA17105.M
0.9244
median.delta.beta.MCF7.M.minus.NA17018.M
median.delta.beta.MCF7.M.minus.NA17105.M
0.9272
median.delta.beta.NA17018.M.minus.NA17105.M 0.0016
11.8639
median.delta.m.MCF7.M.minus.NA17018.M
13.7677
median.delta.m.MCF7.M.minus.NA17105.M
1.3083
median.delta.m.NA17018.M.minus.NA17105.M
0.0286
pairwise.p.MCF7.M.vs.NA17018.M
0.0286
pairwise.p.MCF7.M.vs.NA17105.M
0.6857
pairwise.p.NA17018.M.vs.NA17105.M
13.7677
max.abs.median.delta.m
0.0231
p.value
4.0000
n.probes

11

Figure 4: Diﬀerentially methylated region 16 - relevant, but not signiﬁcant.
12

The DMRforPairs script also contains a wrapper to visualize the methylation
pattern in and around a speciﬁc gene (gene symbol) as long as the gene symbol
is annotated in the Illumina manifest. The plot annotate gene() function also
reports back the complete set of statistics and pairwise plots for that gene. We
will follow up on BMPER here (Figure 5).

> plot_annotate_gene(gs="BMPER",
+
+
+
+
+
+

regions=output$regions,
margin=10000,
ID="BMPER",
clr=clr,
annotate=FALSE,
path=experiment)

$symbols_exact
[1] ""

$symbols_margin
[1] ""

$scores

[,1]
beta.median.MCF7.beta
0.67506214
beta.median.NA17018.beta
0.27153857
beta.median.NA17105.beta
0.02429967
m.median.MCF7.M
1.05783234
m.median.NA17018.M
-1.44791040
m.median.NA17105.M
-5.35393171
median.delta.beta.MCF7.M.minus.NA17018.M
0.26227534
0.36175373
median.delta.beta.MCF7.M.minus.NA17105.M
median.delta.beta.NA17018.M.minus.NA17105.M 0.01144306
2.38364051
median.delta.m.MCF7.M.minus.NA17018.M
4.83587754
median.delta.m.MCF7.M.minus.NA17105.M
1.03137346
median.delta.m.NA17018.M.minus.NA17105.M
0.00006834
pairwise.p.MCF7.M.vs.NA17018.M
0.00000002
pairwise.p.MCF7.M.vs.NA17105.M
0.06660043
pairwise.p.NA17018.M.vs.NA17105.M
4.83587754
max.abs.median.delta.m
0.00000017
p.value
40.00000000
n.probes

13

Figure 5: Methylation througout the BMPER gene.
14

DMRforPairs can also visualize custom genomic regions. The example below
basically generates a zoomed in version of of the whole BMPER gene and shows
that only the promoter region (before TSS) is diﬀerentially methylated (Figure
6). This overlaps with the region selected by DMRforPairs (region 16). The
plot annotate custom region() function also reports back the complete set of
statistics for the requested custom genomic region.

> plot_annotate_custom_region(chr=7,
+
+
+
+
+
+
+

st=33943000,
ed=33945000,
output$regions,
margin=500,
ID="BMPER_TSS",
clr=clr,annotate=FALSE,
path=experiment)

$symbols_exact
[1] ""

$symbols_margin
[1] ""

$scores

[,1]
0.913892
beta.median.MCF7.beta
0.009059
beta.median.NA17018.beta
0.008536
beta.median.NA17105.beta
3.409922
m.median.MCF7.M
-7.167840
m.median.NA17018.M
-6.908633
m.median.NA17105.M
0.900301
median.delta.beta.MCF7.M.minus.NA17018.M
median.delta.beta.MCF7.M.minus.NA17105.M
0.912505
median.delta.beta.NA17018.M.minus.NA17105.M -0.000737
9.973318
median.delta.m.MCF7.M.minus.NA17018.M
10.288598
median.delta.m.MCF7.M.minus.NA17105.M
-0.429142
median.delta.m.NA17018.M.minus.NA17105.M
0.000041
pairwise.p.MCF7.M.vs.NA17018.M
0.000041
pairwise.p.MCF7.M.vs.NA17105.M
0.931427
pairwise.p.NA17018.M.vs.NA17105.M
10.288598
max.abs.median.delta.m
0.000170
p.value
9.000000
n.probes

15

Figure 6: Methylation around the TSS of BMPER.
16

