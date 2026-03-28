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

## February 2, 2024: Y chromosomal variants added and headers for CADD v1.7 GRCh37 release fixed

Pre-scored CADD v1.7 files were missing Y chromosomal SNVs. We have added them to the whole genome files and are sorry
for any inconveniences that has or will cause. Please note that while we support scores on Y (in contrast to scoring
MT),
the quality of the Y sequence in GRCh37 and GRCh38 lacks behind the autosomes and various annotations are not at the same
quality as for other chromosomes (e.g., due to the reduced number of male individuals contributing data in for example
biochemical activity data from ENCODE). As part of the updated files, we also corrected headers in some GRCh37 files
that were stating a GRCh38 origin in the first line.

## January 20, 2024: All pre-scored files for CADD v1.7 available

Pre-scored InDels from gnomAD v4 and whole genome SNV files for CADD v1.7 are available for both GRCh37/hg19 and
GRCh38/hg38.
They can be used for SNV and SNV range lookup, for tabix, API retrieval and download. We also provided updated UCSC
tracks
with the maximum SNV score for each genomic location. A final scoring release document and an updated script release for
offline scoring is going through some final tests before release.

## January 6, 2024: partial release of CADD v1.7 on our webservers

While preparing pre-scored genome-wide files for CADD v1.7, we accidentally picked a random gene per position rather
than
scoring effects across overlapping gene models. To correct this, we had to rerun pre-scoring for all 9 billion substitutions and
a set of more than 100 million indels for GRCh38 and GRCh37. Unfortunately, some of this processing is still ongoing, and
we can only release files for GRCh38 for the new CADD v1.7 version at this point.

## January 5, 2024: CADD v1.7 published in Nucleic Acids Research

The new manuscript describes [CADD v1.7](https://doi.org/10.1093/nar/gkad989),
the latest extension of CADD to improve scoring of protein-coding variants by using protein language models as well as regulatory
variants effects by deep convolutional neural networks. Further, it incorporates a number of other new features, e.g. derived from
the Roulette mutability score and substantially deeper mammalian whole genome alignments of the Zoonomia project.

## February 22, 2021: CADD-Splice manuscript published in Genome Medicine

The new manuscript describes [CADD-Splice](https://doi.org/10.1186/s13073-021-00835-9), the
latest extension
of CADD to improve its predictions of splicing effects. CADD-Splice is released on this server as CADD v1.6.

## July 2, 2020: Fixed off-by-one error in MMSplice annotation for CADD GRCh37-v1.6 and GRCh38-v1.6

We were notified of some inconsistencies between offline scoring without prescored files and online scoring. Tests
over many
variants have shown small score differences for 95 out of six million variants.
Most of those were due to a problem with adding MMSplice annotations. Here, the first (in minus strand genes, last)
position of any
gene was not annotated with MMSplice. This was only an issue for scoring InDel variants, as well as offline scoring of
SNVs
without prescored files. If you have downloaded the offline scoring scripts and all annotations prior to this fix,
please
replace the files in the folder `data/annotations/GRCh37-v1.6/mmsplice/` with the updated files for
[GRCh37](https://krishna.gs.washington.edu/download/CADD/v1.6/GRCh37/MMSpliceUpdate/) and
[GRCh38](https://krishna.gs.washington.edu/download/CADD/v1.6/GRCh38/MMSpliceUpdate/) or
re-download all
annotations. Please note that you will also have to redownload prescored files for InDels (but not SNVs) if you used
any of those
files.
Unfortunately, we also noticed a caching problem with the used version of Ensembl VEP. Under rare and uncontrollable
circumstances,
VEP fails to annotate transcription factor motif scores to GRCh38 variants. This feature has since been fixed in
Ensembl VEP, however
we cannot update the used VEP version without updating the CADD model. Our next CADD release will update to the most
recent Ensembl VEP
version and will fix that issue. The frequency of such events is very low. In our test set, we discovered it in 26 out
of
more than six million variants, with CADD PHRED-score changes of a maximum of 0.4 and only for GRCh38.
We consider these effects very minor and predict that they will not affect most users. We are still sorry for any
inconvenience
that this may cause. If you have further questions about this issue, please feel free to contact us.

## May 26, 2020: Output of multiple annotation lines and SpliceAI tabix index in CADD GRCh37-v1.6

On May 15, we fixed a minor issue with our SpliceAI annotation on GRCh37 that affects chromosome X between 192'989 and
196'609
due to an error in a tabix index. This only affected InDels scored on the webserver and offline scoring without
prescored variants.
The annotation release has been updated. If you have downloaded the offline scoring scripts and all annotations prior
to the fix, replace the files in the folder `data/annotations/GRCh37-v1.6/spliceai/` with the updated files from
[our server](https://krishna.gs.washington.edu/download/CADD/v1.6/GRCh37/spliceAIupdate/)
or re-download all annotations.
On May 25, we noticed that in CADD v1.6 at most one annotation line was returned from pre-scored files.
As a result, when retrieving scores for SNVs using our website or offline scoring scripts, for genomic positions
overlapping two and more
gene annotations, only one annotation line was returned. This has **no** impact on retrieving the correct CADD
score, but might interfere
with applications using the returned annotations (also see our note in the [info section](/info) about
using annotation output).
Please consider updating your offline scoring [scripts of CADD v1.6](/download).

## April 11, 2020: Scores and scripts for CADD v1.6 released

With v1.6, CADD integrates two deep learning scores as domain specific-knowledge for splice effect prediction.
This release also fixes another issue of the GERP annotation in the GRCh38 model of CADD v1.4/v1.5.
More information about the new model can be found in the [release notes](/static/ReleaseNotes_CADD_v1.6.pdf).
The offline installation has been renewed and is now based on [Snakemake](https://snakemake.readthedocs.io/en/stable/). Please follow our instructions
on the [GitHub repository](https://github.com/kircherlab/CADD-scripts).

## February 26, 2019: Scores and scripts for CADD v1.5 released

This release fixes issues in the GERP and ReMap annotations in the GRCh38 model of
CADD v1.4. We have further reduced the precision of several annotations in order to
decrease the overall file size and updated Ensembl based annotations to release 95.
More information about the new model can be found in the [release notes](/static/ReleaseNotes_CADD_v1.5.pdf).
In case you need to update your offline installation, please follow our instructions
on the [GitHub repository](https://github.com/kircherlab/CADD-scripts/tree/CADD1.5).

## October 29, 2018: New CADD manuscript published

The manuscript provides an overview over the changes in CADD from version
1.0 up to 1.4. We further provide some recommendation on how we envision
the use of CADD.

> Rentzsch P, Witten D, Cooper GM, Shendure J, Kircher M.
> *CADD: predicting the deleteriousness of variants throughout the human genome.*
> Nucleic Acids Res. 2018 Oct 29. doi: [10.1093/nar/gky1016](http://dx.doi.org/10.1093/nar/gky1016).
> PubMed PMID: [30371827](http://www.ncbi.nlm.nih.gov/pubmed/30371827).

## August 9, 2018: Browser tracks for UCSC genome browser released, website relaunch, new API and CADD SNV range scoring

We provide [Genome Browser Tracks](https://github.com/kircherlab/CADD-browserTracks)
that allow users to visualize CADD versions 1.3 and 1.4 in a UCSC Genome Browser instance for
[hg19/GRCh37](http://genome.ucsc.edu/cgi-bin/hgTracks?db=hg19&hubUrl=https://raw.githubusercontent.com/kircherlab/CADD-browserTracks/master/hub.txt)
and [hg38/GRCh38](http://genome.ucsc.edu/cgi-bin/hgTracks?db=hg38&hubUrl=https://raw.githubusercontent.com/kircherlab/CADD-browserTracks/master/hub.txt).
These bigWig tracks were generated using the maximum CADD SNV score for every genome position.

Furthermore, we did a website relaunch that includes several new features for retrieving scores of SNVs (at a single
position and now also for coordinate ranges). With the new SNV
lookup, we also offer direct links to genome browsers and other resources. Finally, we introduce an API that enables
an even simpler retrieval of CADD SNV scores from other applications.

## July 4, 2018: Scores and scripts for CADD v1.4 released

The main focus of this release is the support of the genome build GRCh38/hg38,
however this version also includes a new CADD model for GRCh37/hg19. We further
fixed some minor issues identified in CADD v1.3 with respect to how annotations were
interpreted in the model and updated some of the underlying datasets. We included
a new splice score ([dbscSNV](https://www.ncbi.nlm.nih.gov/pubmed/25416802))
and measures of genome-wide variant density. The GRCh38 and GRCh37 models are based
on the same (or, if these were not available, very similar) annotations. Comprehensive
information about the new models can be found in the [release notes](/static/ReleaseNotes_CADD_v1.4.pdf).

## June 27, 2018: GRCh38 release on the horizon

We are actively working on a release of CADD available for both the GRCh37/hg19 and
GRCh38/hg38 builds of the human genome. Over the last months, we have collected,
curated and created required annotation tracks for GRCh38. We have also updated most
of the code base for CADD, making the support of two versions easier for us.
Unfortunately, we keep identifying small issues with our release candidates.
We hope to release CADD v1.4 very soon...

## April 12, 2018: Easy retrieval of individual variants or genomic positions

Based upon frequent requests, we are adding a [single variant (SNV) lookup](/snv)
that allows the quick retrieval of CADD scores (and underlying annotations) for a specific
genomic position or variant. If interested in a pre-calculated score of a SNV, users no
longer need to submit a VCF file through our scoring form or use third-party software
(e.g. tabix) to manually retrieve the sites from our pre-scored files.

## July 29, 2015: Webserver v1.3 submission rerun for InDels with annotations

We were kindly informed that webform submissions including InDels and
requesting results including annotations were missing the InDels for v1.3.
The source of the incomplete files was a typo in one of the cluster
submission scripts, causing the commands to not be executed. We reran these
submissions and ask users to download their files again. If you do not have your
download link available, upload your file again and you will be immediately
directed to the download page.

## July 11, 2015: Scores and scripts for CADD v1.3 released

In CADD v1.3 (3rd developmental/minor release), we fix some minor issues
identified with CADD v1.1 and v1.2 related to overlapping gene annotation.
This release is still based on the GRCh37/hg19 genome build and we are
missing many annotations for the new genome build, not allowing us to release
a version for GRCh38 at this point. As for CADD v1.1 and v1.2, many of the results
for the validation sets are similar or better than for our last major release (CADD v1.0).
We would like to highlight again that there is a measurable
reshuffling of variant ranks to the last major release and we see differences
in the score ranges that are obtained for certain predicted functional
consequences compared to the last major release. Please find further information in the [release notes](/static/ReleaseNotes_CADD_v1.3.pdf).

For scoring your variants locally with CADD v1.3, we are providing the required
[annotation tracks (same as for CADD v1.2 with one update)](http://krishna.gs.washington.edu/download/CADD/v1.2/annotations.tgz), an updated set of
[primate whole genome alignments](http://krishna.gs.washington.edu/download/CADD/v1.3/primateWGA_annoUpdate.tgz) and [set of scripts](http://krishna.gs.washington.edu/download/CADD/v1.3/cadd_v1.3_scripts.tgz). Provided pre-scored variant sets of CADD v1.3 can be used with
these scripts to first retrieve pre-scored variants without recalculating their scores.
Please check the installation instruction detailed in the README provided with
the [scripts](http://krishna.gs.washington.edu/download/CADD/v1.3/cadd_v1.3_scripts.tgz) (132K), before downloading all annotations (206G).

## Jan 21, 2015: Scores and scripts for CADD v1.2 released

In CADD v1.2 (2nd developmental/minor release), we fix some minor issues
identified with CADD v1.1. CADD v1.2 is still based on the GRCh37/hg19 genome build.
As for CADD v1.1, many of the results for the validation sets
are similar or better than for our last major release (CADD v1.0).
However, we would like to highlight that there is a measurable
reshuffling of variant ranks between versions and we see differences
in the score ranges that are obtained for certain predicted functional
consequences. Please find further information in the [release notes](/static/ReleaseNotes_CADD_v1.2.pdf).

For scoring your variants locally with CADD v1.2, we are providing the required
[annotation tracks (same as for CADD v1.1)](http://krishna.gs.washington.edu/download/CADD/v1.2/annotations.tgz) and a
[set of scripts](http://krishna.gs.washington.edu/download/CADD/v1.2/cadd_v1.2_scripts.tgz). Provided pre-scored variant sets of CADD v1.2 can be used with
these scripts to first retrieve pre-scored variants without recalculating their scores.
Please check the installation instruction detailed in the README provided with
the [scripts](http://krishna.gs.washington.edu/download/CADD/v1.2/cadd_v1.2_scripts.tgz) (132K), before downlo