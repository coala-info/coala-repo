cobindR package vignette

October 30, 2018

Many transcription factors (TFs) regulate gene expression by binding to
speciﬁc DNA motifs near genes. Often the regulation of gene expression is
not only controlled by one TF, but by many TFs together, that can either
interact in a cooperative manner or interfere with each other. In recent years
high thoughput methods, like ChIP-Seq, have become available to produce large
amounts of data, that contain potential regulatory regions. In silico analysis of
trancription factor binding sites can help to interpret these enormous datasets
in a convenient and fast way or narrow down the results to the most signiﬁcant
regions for further experimental studies.

cobindR provides a complete set of methods to analyse and detect pairs of
TFs, including support of diverse input formats and diﬀerent background models
for statistical testing. Several visualization tools are implemented to ease the
interpretation of the results. Here we will use a case study to demonstrate how
to use cobindR and its various methods properly to detect the TF pair Sox2
and Oct4.

cobindR needs to be loaded together with the package Biostring, which pro-

vides methods for sequence manipulation.

> library(cobindR)
> library(Biostrings)

1 Conﬁguration

Before starting the analysis, it is recommended to create a conﬁguration ﬁle in
YAML format, that contain all the parameters of the in silico experiment. The
initial step in cobindR is to create a conﬁguration instance.

> #run cobindR
> cfg <- cobindRConfiguration( fname =
+
+

system.file(
package=

cobindR

))

’

’

’

extdata/config_default.yml

,

’

Reading the configuration file: /tmp/RtmpgjRGlJ/Rinst58f733900c95/cobindR/extdata/config_default.yml

1

Parameter settings

When creating a conﬁguration instance without a conﬁguration ﬁle, a warning
is issued. The conﬁguration instance will then contain the default settings, that
usually needs subsequent adjustment.

> #run cobindR
> cfg <- cobindRConfiguration()

The folder containing the binding motifs in PFM ﬁles has to be provided.
All valid PFM ﬁles in the speciﬁed folder are loaded. Files ending with ”*.pfm”
or ”*.cm” should be in the jaspar database format. Files ending with ”*.tfpfm”
need to have the Transfac database format.

> pfm_path(cfg) <-
+

system.file(

’

extdata/pfms

’

,package=

’

cobindR

’

)

The set of pairs for the co-binding analysis should be given as a list. Each
pair should contain the motif names as provided in the PFM ﬁles. The order of
the motif names in the pair is irrelevant.

> pairs(cfg) <- c(

’

ES_Sox2_1_c1058 ES_Oct4_1_c570

’

)

Alternatively, the package MotifDb can be used to retrieve the PWMs.
To use MotifDb the parameter pfm_path should be set to ’MotifDb’. The
pairs should then be given in the following format: source:name. E.g. JAS-
PAR CORE:KLF4, where JASPAR CORE is the source and KLF4 is the tran-
scription factor name.

> pfm_path(cfg) <-
> pairs(cfg) <- c(
+

’
’

JASPAR_CORE:CREB1 JASPAR_CORE:KLF4
JASPAR_CORE:CREB1 JASPAR_CORE:KLF4

’
’

,
)

’

MotifDb

’

The parameters sequence_type, sequence_source and sequence_origin
are used to conﬁgure the sequence input of the experiment.
In this example
sequence_type is set to ’fasta’ to use sequences saved in fasta format. Other
In this case, where
possibilites for sequence_type are ”geneid” or ”chipseq”.
fasta is the input source, sequence_source should contain the path of the fasta
ﬁle. Comments regarding the sequence can be written to sequence_origin.

’

’

fasta

> sequence_type(cfg) <-
> sequence_source(cfg) <- system.file(
+
> sequence_origin(cfg) <-
> species(cfg) <-

Mus musculus

’

’

’

’

extdata/sox_oct_example_vignette_seqs.fasta

,

’

’

cobindR
Mouse Embryonic Stem Cell Example ChIP-Seq Oct4 Peak Sequences

package=

)

’

’

When the sequence_type is set to ”geneid” then sequence_source should
contain the path of a ﬁle that contains a plain list of ENSEMBL gene identi-
ﬁers. The parameters downstream and upstream deﬁne the downstream and

2

upstream region of the TSS that should be extracted. In this case mouse genes
are analysed, so it is important to set the parameter species to ”Mus muscu-
lus”. If human sequences are used species should be set to ”Homo sapiens”.
For other species see http://www.ensembl.org/info/about/species.html.

’

’

ENSMUSG00000042596

#cobindR Example Mouse Genes
,

tmpdir = tempdir(), fileext = ".txt")
’
ENSMUSG00000038518

> tmp.geneid.file <- tempfile(pattern = "cobindR_sample_seq",
+
> write(c(
+
+
> species(cfg) <-
> sequence_type(cfg) <-
> sequence_source(cfg) <- tmp.geneid.file
’
> sequence_origin(cfg) <-
> upstream(cfg) <- downstream(cfg) <- 500

,
ENSMUSG00000025927

file = tmp.geneid.file)
’

Mus musculus
’
geneid

ENSEMBL genes

’
’

’
’

),

’

’

’

’

,

When the sequence_type is set to ”chipseq” then sequence_source should
contain the path of a ﬁle in bed format. Since the sequences are obtained from
the BSgenome package, the BSgenome species name together with its assembly
number must be speciﬁed in the conﬁguration value species.

’

chipseq

’

system.file(

> sequence_type(cfg) <-
> sequence_source(cfg) <-
+
+
> sequence_origin(cfg) <-
> species(cfg) <-

’

’

’

extdata/ucsc_example_ItemRGBDemo.bed

,

package=

cobindR

)

’

’

’

’

UCSC bedfile example
’

BSgenome.Mmusculus.UCSC.mm9

Background sequences can either be provided by the user by setting the
option bg_sequence_type to ”geneid” or ”chipseq”; or artiﬁcial sequences can
be generated automatically using a Markov model (”markov”), via local shuﬄing
of the input sequences (”local”) or via the program ushuﬄe (”ushuﬄe”).

In the case of ”local” shuﬄing each input sequence is divided into small
windows (e.g. window of 10bp length). The shuﬄing is then only done within
each window. That way the nucleotide composition of the foreground is locally
conserved.

In order to use ushuﬄe (http://digital.cs.usu.edu/˜mjiang/ushuﬄe/) it must
be installed separately on your machine and be callable from the command line
using ”ushuﬄe”. For this purpose download ushuﬄe and compile it as it is
described on its website. Then rename ”main.exe” to ”ushuﬄe” and move it to
your bin folder.

The options for the background generation are given in the following format:
model.k.n, whereas model is either ”markov”, ”local” or ”ushuﬄe”. In case of
”markov” k determines the length of the markov chain, in case of ”local” k
determines the window length and for ”ushuﬄe” k determines the k-let counts
that should be preserved from the input sequences (see ushuﬄe website for
more details). n determines the number of background sequences that should
be created.

3

> bg_sequence_type(cfg) <-

’

markov.3.200

’

’

# or

ushuffle.3.3000

’

’

or

local.10.1000

’

2 Finding pairs of transcription factors

After creating a valid conﬁguration object, a cobindr object has to be created
to start the analysis of transcription factor pairs. In this example, the PWM
matching functionality of the Biostrings package is applied via the function
search.pwm. The ”min.score” option is the threshold for the binding site detec-
tion (see Biostrings manual for more detail). Here the threshold is set to 80%
of the highest possible score for a given PWM. find.pairs is then used to ﬁnd
pairs of binding sites.

> cobindR.bs <- cobindr( cfg,
+
> cobindR.bs <- search.pwm(cobindR.bs, min.score =
> cobindR.bs <- find.pairs(cobindR.bs, n.cpu = 3)

name=

cobind test using sampled sequences

80

)

’

’

’

’

)

Alternatively, the RTFBS package (http://compgen.bscb.cornell.edu/rtfbs/)
can be used via the function rtfbs.
If the option ”fdrThreshold” is set to a
value greater than 0 (”fdrThreshold” should be between 0 and 1), the FDR
thresholding approach of RTFBS is used.

> cobindR.bs = rtfbs(cobindR.bs)

Complementary to the two motif-based prediction methods, de-novo motif
prediction can be performed using rGADEM. An optional p-value threshold can
be provided via the conﬁguration value ”pValue”.

> cobindR.bs = search.gadem(cobindR.bs, deNovo=TRUE)

In order to apply the detrending method to detect signiﬁcant pairs, the back-
ground sequences need to be generated. Afterwards the binding site prediction
and the pair ﬁnding also have to be performed on the background.

> cobindR.bs <- generate.background(cobindR.bs)

[1] "creating background sequence..."
simulating 210 background sequences using markov models with degree 3

> cobindR.bs <- search.pwm(cobindR.bs, min.score=
background_scan = TRUE)
+

’

’

80

,

finding binding sites for 4 PWMs...
finding hits for PWM ES_Sox2_1_c1058 ...
finding hits for PWM ES_Klf4_3_c1373 ...
finding hits for PWM ES_Oct4_1_c570 ...
finding hits for PWM ES_Sox2_1_c1058 ...

4

found 17 hits for PWM ES_Klf4_3_c1373 ...
found 47 hits for PWM ES_Oct4_1_c570 ...
found 268 hits for PWM ES_Sox2_1_c1058 ...
found 268 hits for PWM ES_Sox2_1_c1058 ...
found 600 hits in total.

> cobindR.bs <- find.pairs(cobindR.bs, background_scan = TRUE,
n.cpu = 3)
+

Searching for pairs...
Searching for pair ES_Oct4_1_c570 ES_Sox2_1_c1058 .
Found 48 pairs.
Time difference of 0.250325 secs

3 Results: Statistics and Visualizations

Several visualization methods are available in cobindR. For instance the input
sequences can be analysed if subgroups exist that have diﬀerent nucleotide com-
positions. A two-dimensional plot is created where each sequence’s GC-content
is scattered against its CpG-content (Fig. 1). A model-based clustering analysis
is performed and if subgroups are detected in the plot, it is suggested to analyse
them seperately.

> tmp <- testCpG(cobindR.bs, do.plot=T)

Furthermore, the GC or CpG content can be spatially analysed for each
sequence. Since the calculation is slow, the resulting ﬁgure is not included here.

> plot.gc(cobindR.bs, wind.size=200, frac = 2)

The sequence logo of the predicted binding sites can be easily obtained. After
normalizing the column sums, the matrices can be visualized via the seqLogo
package (Fig. 2).

> pred.motifs <- predicted2pwm(cobindR.bs, as.pfm=TRUE)
> # normalized column sums as required by seqLogo
> pred.norm.motifs <- lapply(pred.motifs, function(x) x / colSums(x)[1])
> # load sequence logo plot function
> plot.tfbslogo(x=cobindR.bs,c(

ES_Sox2_1_c1058

ES_Oct4_1_c570

))

,

’

’

’

’

To obtain a quick overview of the spatial distribution of the predicted binding
sites for all input sequences, plot.positionprofile can be used to get a plot
of the average number of binding sites relative to the position (Fig. 3).

> plot.positionprofile(cobindR.bs)

plot.positions.simple provides an overview for all binding sites and all
input sequences. Binding sites are visualized as dots at their position along the
x-axis for the corresponding input sequence along the y-axis (Fig. 4).

5

Figure 1: GC-CpG plot for all input sequences.

> plot.positions.simple(cobindR.bs)

The observed frequencies of two motifs occurring in the same sequence is
visualized as a heatmap using the function plot.tfbs.heatmap (Fig. 5). A p-
value is assigned to each of the motif combinations using a hypergeometric test.
Overlaps with p < 0.05 and p < 0.01 are marked with ’*’ and ’**’, respectively.

> plot.tfbs.heatmap(cobindR.bs, include.empty.seqs=FALSE)

Using the function plot.tfbs.venndiagram a Venn diagram is created that
visualizes the relationship between multiple motifs. As there are only two motifs
used in this example, it does not yield additional information (Fig. 6).

> plot.tfbs.venndiagram(cobindR.bs, pwms = c(

’

ES_Sox2_1_c1058

’

’

,

ES_Oct4_1_c570

’

), include.empty.seqs=FALSE)

The distribution of observed distances between two motifs over all input

sequences is available via plot.pairdistance (Fig. 7).

> plot.pairdistance(cobindR.bs, pwm1=
+

ES_Oct4_1_c570

pwm2=

’

’

)

’

ES_Sox2_1_c1058

,

’

Using the function plot.pairdistribution one can visually check whether
the pair of two motifs are found in all input sequences or whether there is a
subpopulation of pair-rich or -poor sequences (Fig. 8).

6

0.000.010.020.030.040.050.060.070.350.400.450.500.550.60CpGGCClassificationFigure 2: Sequence Logo.

7

1234567Position00.511.52Information content1Figure 3: Position proﬁle for each PWM.

Figure 4: Position of all binding sites for all input sequences.

8

05001000150020000123456position (bp)average number of predicted TFBSES_Sox2_1_c1058ES_Klf4_3_c1373ES_Oct4_1_c5700500100015002000050100150200Position [bp]Input SequenceES_Sox2_1_c1058ES_Klf4_3_c1373ES_Oct4_1_c570Figure 5: Heatmap of pairwise co-occurring motifs in same sequences.

9

ES_Sox2_1_c1058ES_Klf4_3_c1373ES_Oct4_1_c570ES_Oct4_1_c570ES_Klf4_3_c1373ES_Sox2_1_c105850100200Value024Color Keyand HistogramCountFigure 6: Venn diagram of multiple co-occurring motifs in same se-
quences.

10

210210(Coincidental)ES_Sox2_1_c1058ES_Oct4_1_c570ES_Sox2_1_c1058 : ES_Oct4_1_c570Figure 7: Distribution of observed distances for one motif pair.

11

Pair distance distribution for  PWM ES_Sox2_1_c1058 and ES_Oct4_1_c570distance btw. binding sites [bp]# pairs with specific distance0501001502000100200300400Figure 8: Distribution of found pairs per sequence.

> plot.pairdistribution(cobindR.bs, pwm1=
+

ES_Oct4_1_c570

pwm2=

’

’

)

’

ES_Sox2_1_c1058

,

’

Detecting signiﬁcant TF pairs with a certain distance

The distribution of distances between two motifs (Fig. 9 top left) in combination
with the results from the similar procedure applied to the background sequences
(top right) is available via plot.detrending. Furthermore, the foreground and
background distance distributions are combined via the detrending procedure
(bottom left) and the resulting distance proﬁle is shown with the corresponding
signiﬁcance level (bottom right).

> plot.detrending(cobindR.bs, pwm1=
+

’

’

ES_Sox2_1_c1058

,

’

’

pwm2=

ES_Oct4_1_c570

, bin_length=10, abs.distance=FALSE, overlap=4)

The locations and sequences of the overrepresented pairs can be exported

into a plain text ﬁle,

> tmp.sig.pairs = get.significant.pairs(x = cobindR.bs, pwm1=

’

ES_Sox2_1_c1058

’

’

,pwm2=

ES_Oct4_1_c570

, bin_length=10, abs.distance=FALSE,overlap=4)

’

Found candidate pair in FOREGROUND ES_Sox2_1_c1058 ES_Oct4_1_c570 in distance -1 - -10 bp. Z-value is 6.104187

12

2468Pair distribution for  PWM ES_Sox2_1_c1058 and ES_Oct4_1_c570#pairs per sequence#sequences020406080100120140Figure 9: Using the detrending approach a signiﬁcant distance is de-
tected for the Sox2-Oct4 pair (bottom right).

13

−200−10001002000100200300400Foregrounddistance in bp# of pairs−200−100010020001234Backgrounddistance in bp# of pairs−200−10001002000100200300400Foreground with normalized backgrounddistance in bp# of pairs−200−1000100200−200−1000100200300400Detrended distance distributiondistance in bpnormalized # of pairsPair (ES_Sox2_1_c1058, ES_Oct4_1_c570)> tmp.resultbs.file <- tempfile(pattern = "cobindR_detrening_result_bindingsites", tmpdir = tempdir(), fileext = ".tsv")
> write.table(tmp.sig.pairs[[1]], file=tmp.resultbs.file, sep="\t", quote=F)
> system(paste(
> tmp.resultcp.file = gsub("bindingsites","candidates_pairs", tmp.resultbs.file)
> write.table(tmp.sig.pairs[[2]], file=tmp.resultcp.file, sep="\t", quote=F)
> system(paste(

,tmp.resultbs.file))

,tmp.resultcp.file))

head

head

’

’

’

’

as well as the complete set of predicted binding sites.

> tmp.result.bs.file <- tempfile(pattern = "cobindR_bindingsite_pred",
+
> write.bindingsites(cobindR.bs, file=tmp.result.bs.file, background=FALSE)

tmpdir = tempdir(), fileext = ".txt")

[1] "wrote binding sites to: /tmp/RtmpIRbQiG/cobindR_bindingsite_pred615345647532.txt"

> system(paste(

’

’

head

,tmp.result.bs.file))

The foreground and background sequences can be obtained from the cobindR

object for further analysis.

> tmp.inseq.file <- tempfile(pattern = "cobindR_input_sequences",
+
> # slotname =
> write.sequences(cobindR.bs, file=tmp.inseq.file,
+
> #system(paste(

slotname= "sequences")
))

tmpdir = tempdir(), fileext = ".fasta")

to obtain the background sequences

,tmp.inseq.file,

bg_sequences

head

n=10

’

’

’

’

’

’

Clean up the input sequence ﬁles.

> try(unlink(tmp.result.file))
> try(unlink(tmp.result.bs.file))
> try(unlink(tmp.inseq.file))

14

