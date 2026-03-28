[![Stacks](/stacks/images/stacks_logo.png "Stacks")](/stacks)

Stacks is a software pipeline for building loci from short-read sequences, such as those generated on
the Illumina platform. Stacks was developed to work with restriction enzyme-based data, such as RAD-seq, for the
purpose of building genetic maps and conducting population genomics and phylogeography.

![](./images/download.png)

### Download Stacks

[Version 2.68](/stacks/source/stacks-2.68.tar.gz)

##### Recent Changes [updated August 23, 2024]

## Stacks Pipeline

|  |  |
| --- | --- |
| ![](./images/lg_small.png)Genetic Maps Stacks can be used to generate mappable markers from RAD-seq data. Thousands of markers can be generated from a single generation, F1 map as well as markers for traditional F2 and backcross designs. Stacks can export data to JoinMap, [OneMap](http://dx.doi.org/10.1111/j.2007.0018-0661.02000.x), or R/qtl. These data can be used for examining genomic structure as well as assembling genomic assemblies.  ![](./images/ss/fst_fw-oc_groupIV.png)Population Genomics Stacks can be used to identify SNPs within or among populations. Stacks provides tools to generate summary statistics and to compute population genetic measures such as FIS and π within populations and FST between populations, allowing for genome scans. Data can be exported in [VCF](http://www.1000genomes.org/node/101) format and for use in programs such as [STRUCTURE](http://pritchardlab.stanford.edu/structure.html) or [GenePop](http://genepop.curtin.edu.au/). Data can also be exported for cline analysis in [HZAR format](https://cran.r-project.org/web/packages/hzar/).  Any SNP dataset in [VCF](http://www.1000genomes.org/node/101) format can also be *imported* into the Stacks populations module. SNPs generated from re-sequencing or RNA-seq, among other methods, can now be filtered/smoothed in the same way RAD data can.  ![](./images/ss/phylip.png)Phylogenetics Stacks can export GBS/RAD data for phylogenetic analysis. Identified SNPs can be concatenated and exported in [Phylip](http://cmgm.stanford.edu/phylip/formats.html#6) format; these SNPs can be specified as fixed within and variable among populations, or simply all variable sites (encoded in [IUPAC notation](https://en.wikipedia.org/wiki/International_Union_of_Pure_and_Applied_Chemistry#Amino_acid_and_nucleotide_base_codes)). Stacks can also export SNPs with their full flanking sequence -- the RAD locus. These data can be exported in Phylip format (either as concatenated or partitioned data) which can be fed into any standard phylogenetics package such as [PhyML](http://www.atgc-montpellier.fr/phyml/) or [RAxML](http://sco.h-its.org/exelixis/web/software/raxml/index.html). | Getting started with Stacks  * [Stacks Manual](./manual/) * [Stacks Version 1 Manual](./manual-v1/)  Frequently Asked Questions  * [How should I cite the use of Stacks?](faq.php#cite) * [What are the requirements to run Stacks?](faq.php#reqs) * [How do I optimize the various parameters in Stacks?](faq.php#param) * [Is there a protocol that I can follow for running Stacks?](faq.php#prot) * [Are previous versions of Stacks available?](faq.php#prev) * [Can Stacks perform gapped alignments within and among samples?](faq.php#gap) * [Can Stacks handle double-digested data? How about combinatorial barcodes?](faq.php#dd)   [more...](faq.php)  Tutorials  * [How do the major Stacks parameters control the *de novo* formation of *stacks* and loci?](param_tut.php) |

### [Pipeline components](./comp.php)

The Stacks pipeline is designed modularly to perform several different
types of analyses. Programs listed under *Raw Reads* are used
to clean and filter raw sequence data. Programs under *Core*
represent the main Stacks pipeline — building loci (ustacks),
creating a catalog of loci (cstacks, and matching samples back against
the catalog (sstacks), transposing the data (tsv2bam), adding
paired-end reads to the analysis and calling genotypes, and population
genomics analysis. Programs under *Execution Control* will run
the whole pipeline.

|  |  |  |  |
| --- | --- | --- | --- |
| Raw reads  * [process\_radtags](/stacks/comp/process_radtags.php) * [process\_shortreads](/stacks/comp/process_shortreads.php) * [clone\_filter](/stacks/comp/clone_filter.php) * [kmer\_filter](/stacks/comp/kmer_filter.php) | Core  * [ustacks](/stacks/comp/ustacks.php) * [cstacks](/stacks/comp/cstacks.php) * [sstacks](/stacks/comp/sstacks.php) * [tsv2bam](/stacks/comp/tsv2bam.php) * [gstacks](/stacks/comp/gstacks.php) * [populations](/stacks/comp/populations.php) | Execution control  * [denovo\_map.pl](/stacks/comp/denovo_map.php) * [ref\_map.pl](/stacks/comp/ref_map.php) | Utility programs  * [stacks-dist-extract](/stacks/comp/stacks_dist_extract.php) * [stacks-integrate-alignments](/stacks/comp/stacks_integrate_alignments.php) * [stacks-private-alleles](/stacks/comp/stacks_private_alleles.php) |

The process\_radtags program examines raw reads from an Illumina sequencing run and
first, checks that the barcode and the restriction enzyme cutsite are intact (correcting minor errors).
Second, it slides a window down the length of the read and checks the average quality score within the window.
If the score drops below 90% probability of being correct, the read is discarded. Reads that pass quality
thresholds are demultiplexed if barcodes are supplied.

The process\_shortreads program performs the same task as process\_radtags
for fast cleaning of randomly sheared genomic or transcriptomic data. This program will trim reads that are below the
quality threshold instead of discarding them, making it useful for genomic assembly or other analyses.

The clone\_filter program will take a set of reads and reduce them according to PCR
clones. This is done by matching raw sequence or by referencing a set of random oligos that have been included in the sequence.

The kmer\_filter program allows paired or single-end reads to be filtered according to the
number or rare or abundant kmers they contain. Useful for both RAD datasets as well as randomly sheared genomic or
transcriptomic data.

The ustacks program will take as input a set of short-read sequences and align them into
exactly-matching stacks. Comparing the stacks it will form a set of loci and detect SNPs at each locus using a
maximum likelihood framework.

A catalog can be built from any set of samples processed
by the ustacks program. It will create a set of consensus loci, merging alleles together. In the case
of a genetic cross, a catalog would be constructed from the parents of the cross to create a set of
all possible alleles expected in the progeny of the cross.

Sets of stacks constructed by the ustacks
program can be searched against a catalog produced by the cstacks program. In the case of a
genetic map, stacks from the progeny would be matched against the catalog to determine which progeny
contain which parental alleles.

The tsv2bam program will transpose data so that it is oriented by locus, instead of by sample.
In additon, if paired-ends are available, the program will pull in the set of paired reads that are associate with each
single-end locus that was assembled *de novo*.

The gstacks - For *de novo* analyses, this program will pull in paired-end
reads, if available, assemble the paired-end contig and merge it with the single-end locus, align reads
to the locus, and call SNPs. For reference-aligned analyses, this program will build loci from the
single and paired-end reads that have been aligned and sorted.

This populations program will compute population-level summary statistics such
as π, FIS, and FST. It can output site level SNP calls in VCF format and
can also output SNPs for analysis in STRUCTURE or in Phylip format for phylogenetics analysis.

The denovo\_map.pl program executes each of the Stacks components to create a genetic
linkage map, or to identify the alleles in a set of populations.

The ref\_map.pl program takes reference-aligned input data and executes each of the Stacks
components, using the reference alignment to form stacks, and identifies alleles. It can be used in a genetic map
of a set of populations.

The load\_radtags.pl program takes a set of data produced by either the denovo\_map.pl or
ref\_map.pl progams (or produced by hand) and loads it into the database. This allows the data to be generated on
one computer, but loaded from another. Or, for a database to be regenerated without re-executing the pipeline.

The stacks-dist-extract script will pull data distributions from the log and distribs
files produced by the Stacks component programs.

The stacks-integrate-alignments script will take loci produced by the *de novo* pipeline,
align them against a reference genome, and inject the alignment coordinates back into the *de novo*-produced data.

The stacks-private-alleles script will extract private allele data from the populations program
outputs and output useful summaries and prepare it for plotting.

## Implementation

Stacks is implemented in C++, with some helper programs in Perl, and is parallelized using the
[OpenMP](http://openmp.org/wp/) libraries. It will compile on GNU-based Linux systems
or BSD-based Apple OS X systems. Stacks is released under the
[GNU GPL license](http://www.gnu.org/licenses/gpl.html).

Stacks was developed by Julian Catchen
<> and Nicolas Rochette
<>, with contributions from Angel Amores
<>, Paul Hohenlohe
<>, and Bill Cresko
<>.

## Mailing List

Subscribe to the [stacks-user mailing list](http://groups.google.com/group/stacks-users) for technical help, and to discuss the use and development of Stacks.

## Publications

Here are a few publications that have used the Stacks pipeline for data analysis. These papers show
a variety of uses for the Stacks pipeline.

* N. Rochette, A. Rivera‐Colón, and J. Catchen. *Stacks 2:
  Analytical methods for paired‐end sequencing improve RADseq‐based
  population genomics*. **Molecular Ecology**, 28(21):4737-4754. 2019.
  [[reprint](https://dx.doi.org/10.1111/mec.15253)]
* N. Rochette & J. Catchen. *Deriving genotypes from RAD-seq short-read data using Stacks*.
  **Nature Protocols**, 12:2640–2659, 2017.
  [[reprint](http://doi.org/10.1038/nprot.2017.123)]
* J. Paris, J. Stevens, & J. Catchen. *Lost in parameter space: a road map for Stacks*.
  **Methods in Ecology and Evolution**, 8(10):1360-1373, 2017.
  [[reprint](http://doi.org/10.1111/2041-210X.12775)]
* S. Bassham, J. Catchen, E. Lescak, F. von Hippel, W. Cresko. *Repeated Selection of Alternatively
  Adapted Haplotypes Creates Sweeping Genomic Remodeling in Stickleback*. **Genetics**,
  209:921-939, 2018.
  [[reprint](http://dx.doi.org/10.1534/genetics.117.300610)]
* J. Catchen, P. Hohenlohe, S. Bassham, A. Amores, and W. Cresko. *Stacks: an analysis tool set for
  population genomics*. **Molecular Ecology**, 22(11):3124-3140, 2013.
  [[reprint](http://dx.doi.org/10.1111/mec.12354)]
* J. Catchen, A. Amores, P. Hohenlohe, W. Cresko, and J. Postlethwait. *Stacks: building and genotyping
  loci de novo from short-read sequences*. **G3: Genes, Genomes, Genetics**, 1:171-182, 2011.
  [[reprint](http://www.g3journal.org/content/1/3/171.full)]
* A. Amores, J. Catchen, A. Ferrara, Q. Fontenot and J. Postlethwait. *Genome evolution and meiotic maps
  by massively parallel DNA sequencing: Spotted gar, an outgroup for the teleost genome duplication*.
  **Genetics**, 188:799–808, 2011.
  [[reprint](http://dx.doi.org/10.1534/genetics.111.127324)]
* P. Hohenlohe, S. Amish, J. Catchen, F. Allendorf, G. Luikart. *RAD sequencing identifies
  thousands of SNPs for assessing hybridization between rainbow trout and westslope cutthroat trout*.
  **Molecular Ecology Resources**, 11(s1):117-122, 2011.
  [[reprint](http://dx.doi.org/10.1111/j.1755-0998.2010.02967.x)]
* K. Emerson, C. Merz, J. Catchen, P. Hohenlohe, W. Cresko, W. Bradshaw, C. Holzapfel. *Resolving
  postglacial phylogeography using high-throughput sequencing*. **Proceedings of the National Academy of
  Science**, 107(37):16196-200, 2010.
  [[reprint](http://dx.doi.org/10.1073/pnas.1006538107)]