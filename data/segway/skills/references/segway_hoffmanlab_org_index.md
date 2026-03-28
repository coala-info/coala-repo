# Segway semi-automated genomic annotation

> Hoffman MM, Buske OJ, Wang J, Weng Z, Bilmes J, Noble WS. 2012.
> [Unsupervised pattern discovery in human chromatin structure through
> genomic segmentation.](http://www.nature.com/nmeth/journal/v9/n5/full/nmeth.1937.html) *Nat Methods*
> 9:473–476. [doi:10.1038/nmeth.1937](http://dx.doi.org/10.1038/nmeth.1937).
> PubMed Central (free version): [PMC3340533](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3340533/)
> ([BibTeX](segway.bib))

> Chan RCW, Libbrecht MW, Roberts EG, Noble WS, Hoffman MM. 2017.
> [Segway 2.0: Gaussian mixture models and minibatch training.](https://academic.oup.com/bioinformatics/article/34/4/669/4209995)
> *Bioinformatics* 34(4):669–771. [https://doi.org/10.1093/bioinformatics/btx603](https://academic.oup.com/bioinformatics/article/34/4/669/4209995)
> ([BibTeX](segway2.bib))

> Chan RCW, McNeil M, Roberts EG, Mendez M, Libbrecht MW, Hoffman MM.
> 2020.
> [Semi-automated genome annotation using epigenomic data and Segway.](https://doi.org/10.1101/2020.01.30.926923)
> Preprint: [doi.org:10.1101/2020.01.30.926923](https://doi.org/10.1101/2020.01.30.926923)

> Hoffman MM\*,
> Ernst J\*,
> Steven WP,
> Kundaje A,
> Harris RS,
> Libbrecht M,
> Giardine B,
> Ellenbogen PM,
> Bilmes JA,
> Birney E,
> Hardison RC,
> Dunham I,
> Kellis M,
> Noble WS.
> 2012.
> [Integrative annotation of chromatin elements from ENCODE data.](http://nar.oxfordjournals.org/content/41/2/827)
> *Nucleic Acids Res* 41:827-841
> [doi:](http://dx.doi.org/10.1093/nar/gks1284)
> ([BibTeX](iaceEd.bib))

> Roberts EG, Mendez M, Viner C, Karimzadeh M, Chan RCW, Ancar R,
> Chicco D, Hesselberth JR, Kundaje A, Hoffman MM. 2016.
> [Semi-automated genome annotation using epigenomic data and Segway.](http://doi.org/10.1101/080382)
> Preprint: [doi.org:10.1101/080382](http://doi.org/10.1101/080382)

**The free Segway software package contains a novel method
for analyzing multiple tracks of functional genomics data.**
Our method uses a dynamic Bayesian network (DBN) model, which
enables it to analyze the entire genome at 1-bp resolution even in
the face of heterogeneous patterns of missing data. This method is
the first application of DBN techniques to genome-scale data and the
first genomic segmentation method designed for use with the maximum
resolution data available from ChIP-seq experiments without
downsampling. Segway uses the
[Graphical Models Toolkit (GMTK)](http://melodi.ee.washington.edu/gmtk/)
for efficient DBN inference.
Our software has extensive documentation and was
designed from the outset with external users in mind.

We thank the [National Human Genome Research
Institute](https://www.genome.gov), the [Canadian Institutes for
Health Research](https://cihr-irsc.gc.ca/), the [Natural
Sciences and Engineering Research Council of Canada](https://www.nserc-crsng.gc.ca/), the [Princess Margaret Cancer Foundation](https://thepmcf.ca/), and the [Princess Margaret Data Science](https://pmdatascience.ca/) program for
funding Segway development.

## Segmentations

### Human chromatin structure

There are two published segmentations of human chromatin structure
available.

1. The regulatory segmentation from the [Ensembl Regulatory Build](http://genomebiology.com/content/pdf/s13059-015-0621-5.pdf)
   viewable in
   [Ensembl](http://www.ensembl.org/Homo_sapiens/)
2. The segmentation from our *Nature Methods* paper,
   "Unsupervised pattern discovery in human chromatin structure through genomic
   segmentation," viewable in the
   [UCSC Genome Browser](https://genome.ucsc.edu/cgi-bin/hgGateway)

#### Ensembl

The segmentation can be displayed by clicking the "Configure this page"
option on the left navigation bar. The segmentations for each cell line can be
selected under "Regulatory Features" and under the heading of "Enable/disable
all Segmentation features". As an example you can try viewing the segmentations
for
[*BRCA2* in hg38](http://www.ensembl.org/Homo_sapiens/Gene/Summary?db=core;g=ENSG00000139618;r=13:32315474-32400266).

For more details and instructions see the description of
[Regulatory Segmentation](http://www.ensembl.org/info/genome/funcgen/regulatory_segmentation.html).

#### UCSC Genome Browser

The [Ensembl Regulatory Build for GRCh38 (hg38)](http://ngs.sanger.ac.uk/production/ensembl/regulation/hg38/) can be viewed
[from the UCSC Genome Browser](http://genome.ucsc.edu/cgi-bin/hgTracks?db=hg38&hubUrl=http://ngs.sanger.ac.uk/production/ensembl/regulation/hub.txt&hgS_loadUrlName=http://pmgenomics.ca/hoffmanlab/proj/segway/2015/ensembl-regulatory-segway.hg38.session&hgS_doLoadUrl=submit).
The annotation can also be loaded through the
[Track
Data Hub](http://genome.ucsc.edu/cgi-bin/hgHubConnect?db=hg38) interface. You can connect "Ensembl Regulatory Build" listed in
the Public Hubs directory. After loading the track hub, you can show the
"Cell Type Segmentations" supertrack which contains a Segway track for each
of 18 cell types.

Annotations for older assemblies can be browsed on the UCSC Genome Browser below:

* [GRCh37 (hg19)](http://genome.ucsc.edu/cgi-bin/hgTracks?db=hg19;position=chr18:3447551-3460100;hgt.customText=http://pmgenomics.ca/hoffmanlab/proj/segway/2011/segway.hg19.browser)
* [NCBI36 (hg18)](http://genome.ucsc.edu/cgi-bin/hgTracks?db=hg18;position=chr16:31098821-31110700;hgt.customText=http://pmgenomics.ca/hoffmanlab/proj/segway/2011/segway.hg18.browser)

There is a brief [description of the various classes of segment labels](2011_segmentation.html).

You can download the segmentation for further
analysis. [GRCh37 (hg19)](2011/segway.hg19.bed.gz).
[NCBI36 (hg18)](2011/segway.hg18.bed.gz). (~165 MB,
gzipped BED). Here are
the [mnemonic assignments](2011/mnemonics.20110125.tab)
(tab-delimited).

### Integrative annotation of chromatin elements

View the segmentation from our *Nucleic Acids Research*
paper, "Integrative annotation of chromatin elements from ENCODE
data," in the UCSC Genome
Browser: [hg19](http://genome.ucsc.edu/cgi-bin/hgTracks?hgS_doOtherUser=submit;hgS_otherUserName=PaulEllenbogen;hgS_otherUserSessionName=Integrative%20annotation%20of%20chromatin%20elements%20from%20ENCODE%20data%3A%20segway%20website)
only. These segmentations are already relabeled so it is not
necessary to use a mnemonic assignment file.

Segmentation downloads (hg19)

* GM12878
  ([bed](2012/segway_gm12878.bed.gz))
  ([bigbed](http://ftp.ebi.ac.uk/pub/databases/ensembl/encode/awgHub/byDataType/segmentations/jan2011/segway_gm12878_relabel.bb))
* H1-Hesc
  ([bed](2012/segway_h1hesc.bed.gz))
  ([bigbed](http://ftp.ebi.ac.uk/pub/databases/ensembl/encode/awgHub/byDataType/segmentations/jan2011/segway_h1hesc_relabel.bb))
* HelaS3
  ([bed](2012/segway_helas3.bed.gz))
  ([bigbed](http://ftp.ebi.ac.uk/pub/databases/ensembl/encode/awgHub/byDataType/segmentations/jan2011/segway_helas3_relabel.bb))
* Hepg2
  ([bed](2012/segway_hepg2.bed.gz))
  ([bigbed](http://ftp.ebi.ac.uk/pub/databases/ensembl/encode/awgHub/byDataType/segmentations/jan2011/segway_hepg2_relabel.bb))
* Huvec
  ([bed](2012/segway_huvec.bed.gz))
  ([bigbed](http://ftp.ebi.ac.uk/pub/databases/ensembl/encode/awgHub/byDataType/segmentations/jan2011/segway_huvec_relabel.bb))
* K562
  ([bed](2012/segway_k562.bed.gz))
  ([bigbed](http://ftp.ebi.ac.uk/pub/databases/ensembl/encode/awgHub/byDataType/segmentations/jan2011/segway_k562_relabel.bb))

### Annotation of 164 human cell types and the Segway encyclopedia

[View and download annotations and encyclopedia](http://noble.gs.washington.edu/proj/encyclopedia/)
from our submitted manuscript,
["A unified encyclopedia of human functional elements through fully
automated annotation of 164 human cell types" (preprint).](http://dx.doi.org/10.1101/086025)

## Documentation

[Read the documentation,](doc/3.0.4/segway.html) which
begins with
a [quick
start](doc/3.0.4/segway.html#quick-start). The documentation is also available as
a [PDF](doc/3.0.4/Segway.pdf).
Live, editable documentation of the Segway development branch is available through
[Read the Docs](http://segway.readthedocs.io/en/latest/).

## Installation

To install Segway on [bioconda](https://bioconda.github.io/):

```
conda install -c bioconda segway
```

For additional installation methods, see the
["Quick Start"](doc/3.0.4/quick.html) section of the documentation.
For more detailed installation instructions read the
[installation guide](doc/3.0.4/segway.html#installation).

Currently, segway can run locally or on various cluster systems such as
the Sun Grid Engine/Oracle Grid Engine/[Open Grid Scheduler](http://gridscheduler.sourceforge.net/) and Platform LSF.
If you would like to use Segway on another system,
please [open
a ticket in the issue tracker](https://github.com/hoffmangroup/segway/issues). You can also run Segway on SGE
via
the [Amazon
EC2 compute cloud](https://github.com/jayhesselberth/segway-amazon/blob/master/doc/segway-amazon-cloud.rst).

Segway is only supported on Linux. Specifically, this means it is
not supported on other operating systems such as Mac OS X.

## Support

For support of Segway, please write to
the [`segway-users`
mailing list](https://listserv.utoronto.ca/cgi-bin/wa?A0=segway-l), rather than writing the authors directly. Using the
mailing list will get your question answered more quickly. It also
allows us to pool knowledge and reduce getting the same inquiries over
and over. Questions sent to the mailing list will receive a
higher priority than those sent to us individually.

Alternatively if you wish to ask on a public forum, you can post your
message to a [Biostars](https://www.biostars.org/p/new/post/?tag_val=segway,annotation)
with a segway tag and an expert will be notified to help you.

Specifically, if you want to report a bug or request a feature,
please do so using
the [Segway
issue tracker](https://github.com/hoffmangroup/segway/issues). We are interested in all comments on the package,
and the ease of use of installation and documentation.

If you do not want to read discussions about other people's use of
Segway, but would like to hear about new releases and other important
information,
please [subscribe
to the `segway-announce` mailing list](https://listserv.utoronto.ca/cgi-bin/wa?A0=segtools-announce-l). Announcements of this nature
are sent to both `segway-users`
and `segway-announce`.

## Useful links

[Running
Segway in the Amazon Compute Cloud](http://sc3id.ucdenver.edu/jhessel/segway-cloud/segway-amazon-cloud.html)
by [Jay
Hesselberth](http://www.ucdenver.edu/academics/colleges/medicalschool/programs/Molbio/faculty/HesselberthJ/Pages/HesselberthJ.aspx), University of Colorado Denver

## Source code

* [Version 3.0.4](https://github.com/hoffmangroup/segway/archive/3.0.4.tar.gz)
* [Github repository](https://github.com/hoffmangroup/segway)
* [Latest source snapshot](https://github.com/hoffmangroup/segway/archive/master.zip)

## Notes on the segmentation

The underlying signal data for the segmentation presented above is
available in [bedGraph](2011/bedGraph/)
and [bigWig](2011/bigWig/) formats (NCBI36/hg18).
Use [this browser file](2011/bigWig/all_tracks.txt) to
load all the bigWigs. We produced these signal files
using [Wiggler](http://code.google.com/p/align2rawsignal/)
from original data available
from the [Encode
DCC](http://hgdownload.cse.ucsc.edu/goldenPath/hg18/encodeDCC/).

We produced the original segmentations for NCBI36. We used liftOver
(minMatch=0.99) to convert segmentations to GRCh37, and then
filtered out any overlapping regions.
 segway-users mailing list