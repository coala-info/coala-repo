[![The Huttenhower Lab](https://huttenhower.sph.harvard.edu/wp-content/uploads/2019/11/6a40af23d280a6234f8eb0dd8b6a0d737987c92e.png)](https://huttenhower.sph.harvard.edu/)

* [Home](https://huttenhower.sph.harvard.edu/home/)
* [About us](https://huttenhower.sph.harvard.edu/about-us/)
* [Teaching](https://huttenhower.sph.harvard.edu/teaching/)
* [Tools](https://huttenhower.sph.harvard.edu/tools/)
* [People](https://huttenhower.sph.harvard.edu/people/)
* [Join our Team](https://huttenhower.sph.harvard.edu/positions/)
* [Contact Us](https://huttenhower.sph.harvard.edu/contact-us/)
* [Software Support](https://forum.biobakery.org)

## humann2

[The Huttenhower Lab](https://huttenhower.sph.harvard.edu "Go to The Huttenhower Lab.") > humann2

HUMAnN 2.0

HUMAnN 2.0 is a pipeline for efficiently and accurately profiling the presence/absence and abundance of microbial pathways in a community from metagenomic or metatranscriptomic sequencing data (typically millions of short DNA/RNA reads). This process, referred to as functional profiling, aims to describe the metabolic potential of a microbial community and its members. More generally, functional profiling answers the question “What are the microbes in my community-of-interest doing (or capable of doing)?”

For more information on the technical aspects of HUMAnN 2.0:

**[User manual](https://github.com/biobakery/humann/tree/2.9)|| [Tutorial](https://github.com/biobakery/biobakery/wiki/humann2) || [Forum](https://forum.biobakery.org/c/Microbial-community-profiling/HUMAnN)**

**Citation:**Franzosa EA\*, McIver LJ\*, Rahnavard G, Thompson LR, Schirmer M, Weingart G, Schwarzberg Lipson K, Knight R, Caporaso JG, Segata N, Huttenhower C. [Species-level functional profiling of metagenomes and metatranscriptomes.](https://www.nature.com/articles/s41592-018-0176-y) *Nat Methods* **15**: 962-968 (2018).

Interested in trying out the latest version? We're in the late-stage testing for a new version [HUMAnN 3.0](/humann3)

FEATURES

1. Community functional profiles stratified by known and unclassified organisms
   * [MetaPhlAn2](http://199.94.60.28/metaphlan2) and [ChocoPhlAn pangenome database](http://199.94.60.28/humann2_data/chocophlan/chocophlan.tar.gz) are used to facilitate fast, accurate, and organism-specific functional profiling
   * Organisms included are Archaea, Bacteria, Eukaryotes, and Viruses
2. Considerably expanded databases of genomes, genes, and pathways
   * [UniRef](http://www.uniprot.org/help/uniref) database provides gene family definitions
   * [MetaCyc](http://metacyc.org/) provides pathway definitions by gene family
   * [MinPath](http://omics.informatics.indiana.edu/MinPath/) is run to identify the set of minimum pathways
3. A simple user interface (single command-driven flow)
   * The user only needs to provide a quality-controlled metagenome or metatranscriptome
4. Accelerated mapping of reads to reference databases (including run-time generated databases tailored to the input)
   * [Bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml) is run for accelerated nucleotide-level searches
   * [Diamond](http://ab.inf.uni-tuebingen.de/software/diamond/) is run for accelerated translated searches

Requirements

![](http://199.94.60.28/wp-content/uploads/2019/11/humann2_diamond_500x500.jpg)

1. [MetaPhlAn 2.0](http://199.94.60.28/metaphlan2)
2. [Bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml) (version >= 2.1) (see NOTE)
3. [Diamond](http://ab.inf.uni-tuebingen.de/software/diamond/) (0.9.0 > version >= 0.8.22) (see NOTE)
4. [MinPath](http://omics.informatics.indiana.edu/MinPath/) (see NOTE)
5. [Python](http://www.python.org/) (version >= 2.7)
6. Memory (>= 16 GB)
7. Disk space (>= 10 GB [to accommodate comprehensive sequence databases])
8. Operating system (Linux or Mac)

NOTE: Bowtie2, Diamond, and MinPath are automatically installed when installing HUMAnN 2.0. If these dependencies do not appear to be installed after installing HUMAnN 2.0 with pip, it might be that your environment is setup to use wheels instead of installing from source. HUMAnN 2.0 must be installed from source for it to also be able to install dependencies. To force pip to install HUMAnN 2.0 from source add one of the following options to your install command, “–no-use-wheel” or “–no-binary :all:”.

GETTING STARTED

Installation

When installing HUMAnN 2.0, please also download and install [MetaPhlAn 2.0](http://199.94.60.28/metaphlan2). You can then add the MetaPhlAn2 folder to your $PATH or you can provide its location when running HUMAnN 2.0 with the option “–metaphlan $DIR” (replacing $DIR with the full path to the MetaPhlAn2 folder). Bowtie2, Diamond, and Minpath will be automatically installed when you install HUMAnN 2.0

1. 1. Install HUMAnN 2.0
      * $ pip install humann2
      * This command will automatically install MinPath (and a new version of glpk) along with Bowtie2 and Diamond (if they are not already installed).
      * To bypass the install of Bowtie2 and Diamond, add the option “–install-option=’–bypass-dependencies-install'” to the install command.
      * To build Diamond from source during the install, add the option “–install-option=’–build-diamond'” to the install command.
      * To overwite existing installs of Bowtie2 and Diamond, add the option “–install-option=’–replace-dependencies-install'” to the install command.
      * If you do not have write permissions to ‘/usr/lib/’, then add the option “–user” to the HUMAnN 2.0 install command. This will install the python package into subdirectories of ‘~/.local’ on Linux. Please note when using the “–user” install option on some platforms, you might need to add ‘~/.local/bin/’ to your $PATH as it might not be included by default. You will know if it needs to be added if you see the following message humann2: command not found when trying to run HUMAnN2 after installing with the “–user” option.
   2. Test the HUMAnN2 install (Optional)
      * $ humann2\_test
      * To also run tool tests, add the option “–run-functional-tests-tools”.
      * To also run end-to-end tests, add the option “-run-functional-tests-end-to-end”. Please note these tests take about 20 minutes to run. Also they require all dependencies of HUMAnN 2.0 be installed in your PATH.
   3. Try out a HUMAnN 2.0 demo run (Optional)
      * Download the HUMAnN 2.0 source with demos: [humann2.tar.gz](https://pypi.python.org/pypi/humann2)
      * $ tar zxvf humann2.tar.gz
      * $ humann2 –input humann2/examples/demo.fastq –output $OUTPUT\_DIR
      * When running this command, $OUTPUT\_DIR should be replaced with the full path to the directory you have selected to write the output from the HUMAnN 2.0 demo run.
      * Other types of demo files are included in this folder and can be run with the exact same command.
      * Demo ChocoPhlAn and UniRef databases are also included in the download. The demo ChocoPhlAn database is located a humann2/data/chocophlan\_DEMO and the demo UniRef database is located a humann2/data/uniref\_DEMO. Until the full databases are downloaded HUMAnN 2.0 will run with the demo database by default.
   4. Download the ChocoPhlAn database (approx. size = 5.6 GB)
      * $ humann2\_databases –download chocophlan full $DIR
      * When running this command, $DIR should be replaced with the full path to the directory you have selected to store the database.
      * This command will update the HUMAnN2 configuration file, storing the location you have selected for the ChocoPhlAn database. If you move this database and would like to change the configuration file, please see the [Configuration Section of the HUMAnN 2.0 User Manual](https://github.com/biobakery/humann/tree/2.9#configuration). Alternatively, if you move this database, you can provide the location by adding the option “–nucleotide-database $DIR” when running HUMAnN 2.0.
   5. Download a UniRef database (only download one database: UniRef50 full, UniRef50 EC filtered, UniRef90 full, or UniRef90 EC filtered)
      * Download one of the following databases (replacing $DIR with the location to store the database):
        + To download the UniRef90 EC filtered database (RECOMMENDED, approx. size = 846 MB):
          - $ humann2\_databases –download uniref uniref90\_ec\_filtered\_diamond $DIR
        + To download the full UniRef90 database (approx. size = 11 GB):
          - $ humann2\_databases –download uniref uniref90\_diamond $DIR
        + To download the UniRef50 EC filtered database (approx. size = 239 MB):
          - $ humann2\_databases –download uniref uniref50\_ec\_filtered\_diamond $DIR
        + To download the full UniRef50 database (approx. size = 4.6 GB):
          - $ humann2\_databases –download uniref uniref50\_diamond $DIR
      * Select a full database if you are interested in identifying uncharacterized proteins in your data set. Alternatively, select an EC filtered database if you have limited disk space and/or memory. For example, a run with 13 million reads (approximately 7 GB fastq file) passed as input to the translated search step, using a single core, ran in about 4 hours with a maximum of 6 GB of memory using the UniRef50 EC filtered database. The same input file using the UniRef50 full database ran in 25 hours, with a single core, with a maximum of 11 GB of memory.
      * The download command will update the HUMAnN2 configuration file, storing the location you have selected for the UniRef database. If you move this database and would like to change the configuration file, please see the [Configuration Section of the HUMAnN2 User Manual](https://github.com/biobakery/humann/tree/2.9#configuration). Alternatively, if you move this database, you can provide the location by adding the option “–protein-database $DIR” when running HUMAnN 2.0.
   6. Download the utility scripts mapping files database (approx. size = 0.5 GB) (Optional)
      * $ humann2\_databases –download utility\_mapping full $DIR
      * When running this command, $DIR should be replaced with the full path to the directory you have selected to store the database.
      * Downloading and installing these mapping files will give you additional options when running the humann2\_rename\_table and humann2\_regroup\_table utility scripts.

How to Run

Basic usage

$ humann2 –input $SAMPLE –output $OUTPUT\_DIR

$SAMPLE = a single file that is one of the following types:

1. filtered shotgun sequencing metagenome file (fastq, fastq.gz, fasta, or fasta.gz format)
2. mapping results file (sam, bam or blastm8 format)
3. gene table file (tsv or biom format)

$OUTPUT\_DIR = the output directory

Three output files will be created:

1. $OUTPUT\_DIR/$SAMPLENAME\_genefamilies.tsv\*
2. $OUTPUT\_DIR/$SAMPLENAME\_pathcoverage.tsv
3. $OUTPUT\_DIR/$SAMPLENAME\_pathabundance.tsv

where $SAMPLENAME is the basename of $SAMPLE

\*The gene families file will not be created if the input file type is a gene table.

Intermediate temp files will also be created:

1. $DIR/$SAMPLENAME\_bowtie2\_aligned.sam
   * the full alignment output from bowtie2
2. $DIR/$SAMPLENAME\_bowtie2\_aligned.tsv
   * only the reduced aligned data from the bowtie2 output
3. $DIR/$SAMPLENAME\_bowtie2\_index\*
   * bowtie2 index files created from the custom chochophlan database
4. $DIR/$SAMPLENAME\_bowtie2\_unaligned.fa
   * a fasta file of unaligned reads after the bowtie2 step
5. $DIR/$SAMPLENAME\_custom\_chocophlan\_database.ffn
   * a custom chocophlan database of fasta sequences
6. $DIR/$SAMPLENAME\_metaphlan\_bowtie2.txt
   * the bowtie2 output from metaphlan
7. $DIR/$SAMPLENAME\_metaphlan\_bugs\_list.tsv
   * the bugs list output from metaphlan
8. $DIR/$SAMPLENAME\_$TRANSLATEDALIGN\_aligned.tsv
   * the alignment results from the translated alignment step
9. $DIR/$SAMPLENAME\_$TRANSLATEDALIGN\_unaligned.fa
   * a fasta file of unaligned reads after the translated alignment step
10. $DIR/$SAMPLENAME.log
    * a log of the run

* $DIR=$OUTPUT\_DIR/$SAMPLENAME\_humann2\_temp/
* $SAMPLENAME is the basename of the fastq/fasta input file
* $TRANSLATEDALIGN is the translated alignment software selected (rapsearch2 or usearch)

NOTE: $SAMPLENAME can be set by the user with the option “–output-basename <$NEWNAME>”.

Standard workflow

The standard workflow involves running HUMAnN2 on each filtered shotgun sequencing metagenome file, normalizing, and then merging output files.

#### Synthetic datasets from the HUMAnN 2.0 paper:

The following archives include the synthetic datasets that were used in the evaluations described in the paper.

* + [synthetic\_dna\_complex.tar.gz](http://199.94.60.28/humann2_data/synthetic_packaging/synthetic_dna_complex.tar.gz)
  + [synthetic\_dna\_human\_gut.tar.gz](http://199.94.60.28/humann2_data/synthetic_packaging/synthetic_dna_human_gut.tar.gz)
  + [synthetic\_dna\_new\_isolates.tar.gz](http://199.94.60.28/humann2_data/synthetic_packaging/synthetic_dna_new_isolates.tar.gz)
  + [synthetic\_dna\_new\_species.tar.gz](http://199.94.60.28/humann2_data/synthetic_packaging/synthetic_dna_new_species.tar.gz)
  + [synthetic\_rna\_human\_gut.tar.gz](http://199.94.60.28/humann2_data/synthetic_packaging/synthetic_rna_human_gut.tar.gz)

© All copyrights are reserved. The Huttenhower Lab