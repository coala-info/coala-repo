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

# Track-Hub of CADD scores for Genome Browsers

## Description

This is information for visualizing the maximum CADD single nucleotide variant (SNV) score along the genome for
CADD versions v1.3 to v1.7 on hg19 (GRCh37) and hg38 (GRCh38) in a genome browser like the [UCSC genome
browser](https://genome.ucsc.edu/cgi-bin/hgGateway) track [hub](https://genome.ucsc.edu/goldenPath/help/hgTrackHubHelp.html).
Similarly, the files can be used for [NCBI genome data
viewer](https://www.ncbi.nlm.nih.gov/genome/gdv/) and [Ensembl genome browser](https://www.ensembl.org).
The track displays the highest [CADD score](https://cadd.gs.washington.edu/info) of any 3
possible SNVs for a genomic position. It is available for every determined (i.e. non-N) position on the major
chromosomes of the reference genome.

## Usage

To view the tracks, you have to link to `hub.txt` available on our [US](https://krishna.gs.washington.edu/download/CADD/bigWig/CADD-browserTracks/) or [German](https://kircherlab.bihealth.org/download/CADD/bigWig/CADD-browserTracks/) repository. The
simplest way to do this is for the US mirror of the UCSC genome browser is to click [here for hg19/GRCh37](https://genome.ucsc.edu/cgi-bin/hgTracks?db=hg19&hubUrl=https://krishna.gs.washington.edu/download/CADD/bigWig/CADD-browserTracks/hub.txt)
and [here
for hg38/GRCh38](https://genome.ucsc.edu/cgi-bin/hgTracks?db=hg38&hubUrl=https://krishna.gs.washington.edu/download/CADD/bigWig/CADD-browserTracks/hub.txt). For the European mirror please click [here for hg19/GRCh37](https://genome-euro.ucsc.edu/cgi-bin/hgTracks?db=hg19&hubUrl=https://kircherlab.bihealth.org/download/CADD/bigWig/CADD-browserTracks/hub.txt)
and [here
for hg38/GRCh38](https://genome-euro.ucsc.edu/cgi-bin/hgTracks?db=hg38&hubUrl=https://kircherlab.bihealth.org/download/CADD/bigWig/CADD-browserTracks/hub.txt)

For NCBI GDV (CADD US server): [hg19/GRCh37](https://www.ncbi.nlm.nih.gov/genome/gdv/browser/genome/?acc=GCF_000001405.25&hub=https://krishna.gs.washington.edu/download/CADD/bigWig/CADD-browserTracks/hub.txt)
and [hg38/GRCh38](https://www.ncbi.nlm.nih.gov/genome/gdv/browser/genome/?acc=GCF_000001405.40&hub=https://krishna.gs.washington.edu/download/CADD/bigWig/CADD-browserTracks/hub.txt).

For Ensembl (CADD DE server): [hg19/GRCh37](https://grch37.ensembl.org/TrackHub?url=https://kircherlab.bihealth.org/download/CADD/bigWig/CADD-browserTracks/hub.txt;species=Homo_sapiens;name=CADD;registry=1)
and [hg38/GRCh38](https://www.ensembl.org/TrackHub?url=https://kircherlab.bihealth.org/download/CADD/bigWig/CADD-browserTracks/hub.txt;species=Homo_sapiens;name=CADD;registry=1).
Please note that we had trouble with Ensembl (no options for showing older CADD releases) and you may need to open the above links twice before Ensembl genome browser registers the track.

## Reference

CADD has been described in four publications. The publication introducing the UCSC tracks is the 2018 NAR publication.
The most recent manuscript describes CADD v1.7, an extension to the annotations
included in the model. Most prominently, this version improves the scoring of
coding variants with features derived from the ESM-1v protein language model
as well as the scoring of regulatory variants with features derived from a
convolutional neural network trained on regions of open chromatin:
> Schubach M, Maass T, Nazaretyan L, Röner S, Kircher M.
> *CADD v1.7: Using protein language models, regulatory CNNs and other nucleotide-level scores to improve genome-wide
> variant predictions.*
> Nucleic Acids Res. 2024 Jan 5. doi: [10.1093/nar/gkad989](https://doi.org/10.1093/nar/gkad989).
> PubMed PMID: [38183205](https://pubmed.ncbi.nlm.nih.gov/38183205/).

Before that there is the publication on CADD-Splice (CADD v1.6), which specifically improved the prediction of splicing effects:
> Rentzsch P, Schubach M, Shendure J, Kircher M.
> *CADD-Splice—improving genome-wide variant effect prediction using deep learning-derived splice scores.*
> Genome Med. 2021 Feb 22. doi: [10.1186/s13073-021-00835-9](https://doi.org/10.1186/s13073-021-00835-9).
> PubMed PMID: [33618777](http://www.ncbi.nlm.nih.gov/pubmed/33618777).

The CADD manuscript in 2018 describes updates since the initial publication of
CADD including these UCSC Genome Browser tracks. It was published by
Nucleic Acids Research:
> Rentzsch P, Witten D, Cooper GM, Shendure J, Kircher M.
> *CADD: predicting the deleteriousness of variants throughout the human genome.*
> Nucleic Acids Res. 2018 Oct 29. doi: [10.1093/nar/gky1016](https://dx.doi.org/10.1093/nar/gky1016).
> PubMed PMID: [30371827](https://www.ncbi.nlm.nih.gov/pubmed/30371827).

The original manuscript describing the CADD method was published by
Nature Genetics in 2014:
> Kircher M, Witten DM, Jain P, O'Roak BJ, Cooper GM, Shendure J.
> *A general framework for estimating the relative pathogenicity of human genetic variants.*
> Nat Genet. 2014 Feb 2. doi: [10.1038/ng.2892](https://dx.doi.org/10.1038/ng.2892).
> PubMed PMID: [24487276](https://www.ncbi.nlm.nih.gov/pubmed/24487276).

## Data Access

The bigWig datasets displayed in these tracks are located on our [US webserver](https://krishna.gs.washington.edu/download/CADD/bigWig/) or its [German counterpart](https://kircherlab.bihealth.org/download/CADD/bigWig/).
The code for this track-hub is further hosted [on GitHub](https://github.com/kircherlab/CADD-browserTracks).

## Copyright

Copyright (c) University of Washington, Hudson-Alpha Institute for
Biotechnology and Berlin Institute of Health at Charité --
Universitätsmedizin Berlin 2013-2023. All rights reserved.
Permission is hereby granted, to all non-commercial users and licensees of CADD
(Combined Annotation Dependent Framework, licensed by the University of
Washington) to obtain copies of this software and associated documentation
files (the "Software"), to use the Software without restriction, including
rights to use, copy, modify, merge, and distribute copies of the Software. The
above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## Contact

If you have technical problems using the CADD track-hub, please also check the information provided in the README on the [US server](https://krishna.gs.washington.edu/download/CADD/bigWig/CADD-browserTracks/readme.md) or [German server](https://kircherlab.bihealth.org/download/CADD/bigWig/CADD-browserTracks/readme.md). If this
does not resolve your issues, please contact us at cadd-support [at] uw.edu.

© University of Washington, Hudson-Alpha Institute for Biotechnology and Berlin Institute
of Health at Charité - Universitätsmedizin Berlin 2013-2023. All rights reserved.

[Terms and Conditions](http://www.washington.edu/online/terms/) and the [Online Privacy Statement](http://www.washington.edu/online/privacy/) of the University of
Washington apply.