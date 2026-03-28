[![CADD logo](/static/icon.png)

# CADD - Combined Annotation Dependent Depletion](/)

* [News](/news "Recent updates")
* [Score](/score "Upload a vcf file for variant scoring")
* [SNV](#popover-snv)

  + [Single](/snv "Lookup for single SNV")
  + [Range](/snv-range "SNV range lookup")
* [Downloads](/download "Data downloads for offline scoring")
* [About](#popover-about)

  + [Information](/info "About CADD")
  + [API](/api "Information about the CADD API")
  + [Genome Browser](/genome-browser "Information about displaying CADD scores in UCSC Genome Browser")
  + [Links](/links "Links to CADD related resources")
  + [Contact](/contact "Contact")
* (Alt. site:
  [![Visit German site](/static/DE-flag.png)](https://cadd.bihealth.org/))

***Note:* Scoring of VCF files with CADD v1.7 is still rather slow if many new
variants need to be calculated from scratch (e.g., if many insertion/deletion or multi-nucleotide substitutions
are included). If possible use the pre-scored whole genome and pre-calculated indel files directly where possible.**

# Short method summary

Fixed or nearly fixed recent evolutionary changes were identified as
differences between 1000 Genomes and the Ensembl Compara inferred
human-chimpanzee ancestral genome (derived allele frequency (DAF) of at
least 95%, about 15 million SNVs and less than 2 million indels). To simulate an
equivalent number of mutations, we used an empirical model of sequence
evolution with CpG dinucleotide-specific rates and mutation rates
locally scaled in megabase windows. For annotation, we used the Ensembl
Variant Effect Predictor (VEP), data from the ENCODE project and
information from UCSC genome browser tracks. These annotations span a
wide range of data types including conservation metrics like GERP,
phastCons, and phyloP; functional genomic data like DNase
hypersensitivity and transcription factor binding; transcript
information like distance to exon-intron boundaries or expression levels
in commonly studied cell lines; and protein-level scores like Grantham,
SIFT, and PolyPhen.

In CADD v1.0 (major release), the resulting variant-by-annotation matrix
contained 29.4 million variants (half observed, half simulated) and 63 distinct
annotations. We trained a support vector machine (SVM) with a linear
kernel on features derived from these annotations, supplemented by a
limited number of interaction terms. The same 63 annotations were
obtained for all 8.6 billion possible substitutions in the human
reference genome (GRCh37), and, after training on observed and simulated
variants, the model was applied to score all possible substitutions.
As the scale of the combined SVM score ("C-scores") is effectively
arbitrary due to the annotations used, we defined phred-like scores
("scaled C-scores") ranging from 1 to 99, based on the rank of each
variant relative to all possible 8.6 billion substitutions in
the human reference genome.

In CADD v1.1 (developmental/minor release), we used a slightly extended
and updated annotation set and we trained a logistic regression model.
Please find further information in the
[release notes](/static/ReleaseNotes_CADD_v1.1.pdf).

In CADD v1.2 (developmental/minor release), we corrected some minor issues
identified in v1.1. Please find further information in the
[release notes](/static/ReleaseNotes_CADD_v1.2.pdf).

In CADD v1.3 (developmental/minor release), we corrected issues in v1.1 and
v1.2 relating to overlapping gene annotation. We also updated our training
data set using updated whole genome alignments. Please find further information
in the
[release notes](/static/ReleaseNotes_CADD_v1.3.pdf).

In CADD v1.4 (developmental/minor release), we started supporting the genome
build GRCh38/hg38 and its major chromosomes. This version also includes a new CADD model
for GRCh37/hg19. We fixed some minor issues identified in CADD v1.3 with respect to
how annotations were interpreted in the model and updated some of the underlying datasets.
We included a new splice score (dbscSNV) and measures of genome-wide variant density.
The GRCh38 and GRCh37 models of CADD v1.4 are based on the same (or, if these were
not available, very similar) annotations. Please find further information
in the [release notes](/static/ReleaseNotes_CADD_v1.4.pdf).

In CADD v1.5 (developmental/minor release), we fix problems in some annotations of the
GRCh38 model from CADD v1.4. We also update to Ensembl release 95. Please find further
information in the [release notes](/static/ReleaseNotes_CADD_v1.5.pdf).

In CADD v1.6 (CADD-splice/minor release), we adapt CADD especially for splicing variants by
integrating two deep learning models into the score. A major fix is implemented in the
GERP annotation for GRCh38. Please find further
information in the [release notes](/static/ReleaseNotes_CADD_v1.6.pdf).

In CADD v1.7 (minor release), model features are extended by annotations derived from a protein language model (ESM-1v),
regulatory sequence effect prediction using a custom CNN, sequence constraint measures from deeper
mammalian whole genome alignments created by the Zoonomia project, mutability scores from Roulette,
Aparent2 scores for UTR variants and an update to transcript model and other Ensembl VEP derived
annotations to the latest v110 release. Please find further information in the
[release notes](/static/ReleaseNotes_CADD_v1.7.pdf).

# Notes on using scaled vs. unscaled C-scores

We believe that CADD scores are useful in two distinct forms, namely "raw"
and "scaled", and we provide both in our output files. "Raw" CADD scores come
straight from the model, and are interpretable as the extent to which the
annotation profile for a given variant suggests that the variant is likely to
be "observed" (negative values) vs "simulated" (positive values). These values
have no absolute unit of meaning and are incomparable across distinct annotation
combinations, training sets, or model parameters. However, raw values do
have relative meaning, with higher values indicating that a variant is more
likely to be simulated (or "not observed") and therefore more likely to have
deleterious effects.

Since the raw scores do have relative meaning, one can take a specific group of
variants, define the rank for each variant within that group, and then use that
value as a "normalized" and now externally comparable unit of analysis. In our
case, we scored and ranked all ~8.6 billion SNVs of the GRCh37/hg19 reference
and then "PHRED-scaled" those values by expressing the rank in order of
magnitude terms rather than the precise rank itself. For example, reference
genome single nucleotide variants at the 10th-% of CADD scores are assigned to
CADD-10, top 1% to CADD-20, top 0.1% to CADD-30, etc. The results of this
transformation are the "scaled" CADD scores.

## The advantages and disadvantages of the score sets are summarized as follows:

*1. Resolution:* Raw scores offer superior resolution across the entire
spectrum, and preserve relative differences between scores that may otherwise be
rounded away in the scaled scores. For example, the bottom 90% (~7.74 billion)
of all GRCh37/hg19 reference SNVs (~8.6 billion) are compressed into scaled CADD
units of 0 to 10, while the next 9% (top 10% to top 1%, spanning ~774 million
SNVs) occupy CADD-10 to CADD-20, etc., with the scaled units only getting close
to resolving individual SNVs from one another at the extreme top end. As a
result, many variants that have substantive raw score differences between them
will be necessarily forced to the same or very similar rank unit.

*2. Frame of reference:* Since there must always be a top-ranked variant,
second-ranked variant, etc, scaled scores are easier to interpret at first
glance and will be comparable across CADD versions as we, for example, update
the model to include new annotations (or even use an entirely distinct
model-building method). A scaled score of 10, for example, refers to the top 10%
of all reference genome SNVs, regardless of the details of the annotation set,
model parameters, etc. Furthermore, with scaled values one can always infer,
with just a simple glance, the probability of picking a variant(s) at that score
or greater when selecting randomly from all possible reference SNVs.

## We envision the "typical use" cases for CADD, and appropriate choice of score set, as follows:

*1. Discovering causal variants within an individual, or small groups, of
exomes or genomes.* Scaled CADD scores are most useful in this context, as one
will generally only be interested or capable of reviewing a small set of the
"most interesting" variants. In this setting, the distinction between a variant
at the 25th percentile and 75th percentile is effectively irrelevant (scaled
scores of ~0 to 1), while the difference between a variant in the top 10%
(scaled score of 10) vs 1% (scaled score of 20) may be quite meaningful.
Further, the absolute frame of the reference is valuable here, allowing an
analyst to quickly place a variant in context and facilitate easier translation
of results across publications, studies, etc.

*2. Fine-mapping to discover causal variants within associated loci.* As
above, scaled scores are likely to be more useful here by allowing focus on a
small set of manually reviewable best candidates and providing the absolute
frame of the reference genome.

*3. Comparing distributions of scores between groups of variants, e.g.,
cases vs controls.* In this case, raw scores should be used, as they preserve
distinctions that may be relevant across the entire scoring spectrum. Scaled
scores may obscure systematic and potentially highly significant distinctions
between two groups of variants (e.g., the first and third quartiles of all reference
SNV scores). Further, since such analyses are generally conducted
computationally and without manual intervention, the absolute frame of reference
advantage to scaled scores is not as valuable here.

# What are the scores in the files and which score cutoff should I use?

The last column of the provided files is the PHRED-like (-10\*log10(rank/total)) scaled
C-score ranking a variant relative to all possible substitutions of the human genome
(8.6x10^9). Like explained above, a scaled C-score of greater of equal 10 indicates
that these are predicted to be the 10% most deleterious substitutions that you
can do to the human genome, a score of greater or equal 20 indicates the
1% most deleterious and so on.

The second to last column is the raw score of the model. Due to the high
mislabeling in our training data, it does not have any interpretation (even
the sign does not have an interpretation). The higher the raw C score the more
predicted to be deleterious. If you want to do a non-parametric test between
sets of variants, we recommend using this raw C-score (see above). If you want
to put a cutoff on deleteriousness, we recommend the last column (scaled C-score)
as it has some interpretation by relating the raw C-score to the raw C-scores
of all possible substitutions in the human genome.

If you would like to apply a cutoff on deleteriousness, e.g. to identify potentially
pathogenic variants, we would suggest to put a cutoff somewhere between 10 and 20.
Maybe at 15, as this also happens to be the median value for all possible canonical
splice site changes and non-synonymous variants in CADD v1.0. However, there is not a
natural choice here -- it is always arbitrary. We therefore recommend integrating
C-scores with other evidence and to rank your candidates for follow up rather than
hard filtering.

# I checked the "include underlying annotation in output", what information do I get? Why are there multiple lines per variant?

CADD uses many different annotations for its combined score. These include
functional effect predictions based on gene models, conservation measures,
ENCODE data summaries -- more than 60 annotations already in CADD v1.0.
Given a set of variants, we use [Ensembl Variant
Effect Predictor (VEP)](http://www.ensembl.org/info/docs/tools/vep/index.html) on the set of variants to obtain the gene model based
predictions. We run VEP with the --per\_gene option, which will return a
"representative" transcript with the most severe effect for a certain gene. If a
position overlaps multiple genes, it will return multiple annotations for this
variant. We then extent the VEP output by values from different [UCSC](http://genome.ucsc.edu/)-style annotation tracks
(Encode OpenChromatin, expression, histones, conservation scores, ...). Once we
got the fully annotated table, the raw C-score is calculated as described in our
publication (see below). In case of multiple annotations, we report the highest
score for both annotations of a variant. The corresponding scaled C-score is
looked up and added to the output. If you check "include underlying annotation
in output", this is the file that you will get. We provide these input annotations
to allow users an interpretation of their scoring results. All the columns present
in files of CADD v1.0 and below are listed and briefly described in [Supplementary Table 1 of our paper (page 22).](https://static-content.springer.com/esm/art%3A10.1038/ng.2892/MediaObjects/41588_2014_BFng2892_MOESM56_ESM.pdf) Annotation information for
CADD v1.1-v1.7 is available in the respective release notes. Find the release notes of
CADD v1.7 [here](/static/ReleaseNotes_CADD_v1.7.pdf)

Please do not use the annotation provided with the score as a replacement for
annotating your variants using up-to-date gene annotation. For example, CADD v1.0 uses what
is now a very outdated gene build (Ensembl v68). CADD v1.7 is based on Ensembl gene build
version 110 (July 2023). Further, for all CADD versions, the output does not
contain information on all transcripts and the "representative" transcript picked
by VEP does not need be the canonical one or even represent the most severe
effect based on up-to-date annotations.

# I fail to retrieve scores for my variants using the web server. What is going wrong?

## (1) If your upload fails it can be for two different reasons:

(a) You are attempting to upload a file larger than 2MB, which is automatically
rejected by the web server with a connection reset (white page, server error).
In this case, please submit your variant set in smaller pieces or try removing
additional columns in the VCF (CADD only requires the first 5 columns) to meet
the upload limit. Also consider gzip-compression of your VCF file. We generally
recommend submitting variants in small batches, as different submissions can be
processed in parallel.

(b) If the file is smaller than 2MB, but it is not correctly formatted as a VCF
or the file extension is neither vcf, tsv, txt nor gz, you get the "Your upload
failed." error message on the regular CADD website with some description on how
the uploaded file needs to be formatted and named. If you get this type of error,
please adjust the formatting of the information (i.e. 5 columns: 