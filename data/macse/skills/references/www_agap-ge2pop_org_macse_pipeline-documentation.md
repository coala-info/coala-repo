[Aller au contenu](#content "Aller au contenu")

[GE²pop](https://www.agap-ge2pop.org/)

Génomique évolutive et gestion des populations

[Home](https://www.agap-ge2pop.org/)

[Tools](https://www.agap-ge2pop.org/tools)

[Datasets](https://www.agap-ge2pop.org/datasets)

![](https://www.agap-ge2pop.org/wp-content/uploads/2023/06/logo_MACSE-1024x567.jpg)

[Tools](https://www.agap-ge2pop.org/tools/)

## **MACSE**

* [Overview](https://www.agap-ge2pop.org/macse/)
* Documentation
  + [Quickstart](https://www.agap-ge2pop.org/macse/macse-quickstart/)
  + [Documentation](https://www.agap-ge2pop.org/macse/macse-documentation/)
  + [Pipeline quickstart](https://www.agap-ge2pop.org/macse/pipeline-quickstart/)
  + [Pipeline documentation](https://www.agap-ge2pop.org/macse/pipeline-documentation/)
  + [Download tutorial files](https://www.agap-ge2pop.org/macse/download-tutorial-files/)
  + [Citing](https://www.agap-ge2pop.org/macse/citing/)
  + [Citations](https://scholar.google.com/scholar?hl=en&lr=&cites=https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0022594)
* Download
  + [MACSE & pipelines](https://www.agap-ge2pop.org/macsee-pipelines/)
  + [Barcoding alignments](https://www.agap-ge2pop.org/barcoding-alignments/)
  + [Tutorial files](https://www.agap-ge2pop.org/macse/download-tutorial-files/)
* [Members](https://www.agap-ge2pop.org/macse/members/)

# This is the documentation for pipelines based on MACSE v2

## 1. Overview

MACSE (Multiple Alignment of Coding SEquences Accounting for Frameshifts and Stop Codons) provides a complete toolkit dedicated to the multiple alignment of coding sequences that can be leveraged via both the command line and a Graphical User Interface (GUI).

Various strategies can be built using the MACSE toolkit to handle datasets of various sizes and containing various types of sequences (contigs, pseudogenes, barcoding sequences).

We share here some of the pipelines that we have built so far using MACSE. These bash pipelines are encapsulated into Singularity containers so that you don’t need to deal with dependancies or configuration issues.

## 2. Getting started

If you are new to Singularity, you should probably start here:

* [singularity quick start](https://www.agap-ge2pop.org/macse/pipeline-quickstart/)

## 3. The alignment pipelines

* AlFiX: this pipeline uses MACSE and HmmCleaner to produce a high quality alignment of nucleotide (NT) coding sequences using their amino acid (AA) translations. It is well suited for datasets containing a few dozen of sequences of a few Kb.
* OMM\_MACSE: this pipeline also produces a codon-aware alignment thanks to MACSE, which could be filtered by HmmCleaner, but it can handle larger datasets by relying on MAFFT, MUSCLE or PRANK to scale up.

## 4. The barcoding related pipelines

For Barcoding, if you have dozen of thousands of sequences to align (e.g. COI-5P or matK) we suggest the following steps i) using a reference sequence that you have eyed cheked, identify similar sequences in your dataset and reverse complement them when needed; then select a subset of about 100 sequences representatives of this dataset ii) align these representative sequences iii) align (in parallel) each sequence against these representative subset. This can be done in three command lines using our dedicated pipelines:

* getRepresentativeSequences: this pipeline uses MACSE, MMSEQ2, seqtK to identify a small subset of representative sequences, filter out non homologous sequences and reverse complement homologous one when needed.
* OMM\_MACSE (see above) allow to align your representative sequences found in previous step
* MACSE\_barcode\_align that will parrallelize the align of your barcoding sequences thanks to nextflow

We succesfully launch this barcoding pipeline on different taxonomic group. The corresponding data are available on this page.

## 5. OMM\_MACSE and AlFiX pipelines share several common steps and options

### Mandatory input and output file options

Both pipelines produce several output files: two alignment files (at the NT and AA levels); a csv file with filtering statistics per sequence, a fasta file with filtering details (where nucleotides of input sequences are in upper cases if present in the final alignment and in lower case otherwise). All output files are stored in a new folder and named with a common prefix so that they do not mix with your own files. Both pipelines have therefore three mandatory options:

| option\_name | used for | example |
| --- | --- | --- |
| –in\_seq\_file | specifying the INput SEQuence FILE containing the coding nucleotide sequences to be aligned, in fasta format | –in\_seq\_file LOC\_48720\_NT.fasta |
| –out\_dir | specifying the OUTput DIRectory in which result files will be stored | –out\_dir RES\_LOC\_48720 |
| –out\_file\_prefix | specifying the common part of output file names | –out\_file\_prefix LOC\_48720 |

### Basic usage examples

As there are only three mandatory options, you can launch these pipelines with default options using the following commands (see [Singularity quick start](https://www.agap-ge2pop.org/macse/pipeline-quickstart/) if needed):

* *./OMM\_MACSE\_v10.01.sif –in\_seq\_file LOC\_48720.fasta –out\_dir RES\_LOC\_48720 –out\_file\_prefix LOC\_48720*
* *./MACSE\_ALFIX\_v01.sif –in\_seq\_file LOC\_48720.fasta –out\_dir RES\_LOC\_48720 –out\_file\_prefix LOC\_48720*

### Optional options for saving intermediary files (mostly for debugging purposes)

| option\_name | used for | example |
| --- | --- | --- |
| –out\_detail\_dir | specifying the output directory that will contains all intermediary files | –out\_detail\_dir DETAILS\_LOC\_48720 |
| –save\_details | turning ON when intermediary files need to be saved | –save\_details |
| –debug | turning ON to keep the temporary folder created in /tmp/ | –debug |

### Optional options related to genetic codes and less reliable sequences set

Both pipelines allow you to specify the [genetic code](https://www.agap-ge2pop.org/genetic-codes/) that should be used to translate your sequences, and to provide a second input file that contains [less reliable sequences](https://www.agap-ge2pop.org/alignsequences/) (e.g. newly assembled contigs, pseudogenes, etc…) in which frameshifts and stop codons are expected to be more frequent:

| option\_name | used for | usage example |
| --- | --- | --- |
| –genetic\_code\_number code\_number | selecting the relevant genetic code | –genetic\_code\_number 5 |
| –in\_seq\_lr\_file | specifying the INput SEQuence FILE containing the Less Reliable sequences | –in\_seq\_lr\_file less\_reliable\_seq\_file.fasta |

### Optional options related to filtering steps

Both pipelines include four optional filtering steps:

* a prefiltering performed before sequence alignment to mask non homologous sequence fragments that is done using [trimNonHomologousFragments](https://www.agap-ge2pop.org/trimnonhomologousfragments/)
* a filtering of the amino acid alignment to mask residues that seem to be misaligned. This is done using HmmCleaner at the amino acid level and reported at the codon level using [reportMaskAA2NT](https://www.agap-ge2pop.org/reportmaskaa2nt/)
* a post-processing filtering is done to further masked isolated codons and patchy sequences (if 80% of a sequence has been masked it is probably better to remove it completely). This step is performed by setting options of [reportMaskAA2NT](https://www.agap-ge2pop.org/reportmaskaa2nt/) accordingly.
* finally the extremities of the alignment are trimmed until a site with a minimal percentage of nucleotides is reached (using [trimAlignment](https://www.agap-ge2pop.org/trimalignment/)).

All these filtering steps are active by default but can be individually turned OFF and the minimal percentage of nucleotides used for the final trimming step can be adjusted:

| option\_name | used for | default value |
| --- | --- | --- |
| –no\_prefiltering | turning OFF the pre-filtering step | ON |
| –no\_FS\_detection | turning OFF the detection of frameshifts (only relevant for the OMM\_MACSE pipeline) | ON |
| –no\_filtering | turning OFF the HmmCleaner alignment filtering | ON |
| –no\_postfiltering | turning OFF the post-filtering of the alignment that mask isolated AA | ON |
| –min\_percent\_NT\_at\_ends | allowing to set the minimal number of nucleotides that should be present at the first and last site of the final alignment | 0.7 |

### Optional option to allocate more memory (for large datasets)

For datasets containing numerous long sequences, MACSE may need more memory than the default value allocated to the java virtual machine. This can be set using the following option:

| option\_name | used for | usage example |
| --- | --- | --- |
| –java\_mem | passing the argument to the jvm via its Xmx option | –java\_mem 600m |

### Optional options to specify how frameshifting codons should be exported

The output directory contains several files (see details in the readme\_output.txt file in the output directory). The final alignment files (NT and AA) are obtained after replacing STOP codons by « NNN », and frameshifting codons by either « NNN » (default) or « — » using [exportAlignment](https://www.agap-ge2pop.org/exportalignment/):

| option\_name | used for | default |
| --- | --- | --- |
| –replace\_FS\_by\_gaps | replacing frameshifting codons by « — » instead of « NNN » | OFF (« NNN ») |

## Three options specific to the OMM\_MACSE pipeline

Because OMM\_MACSE relies on an external tool to rapidly align the amino acid sequences after having detected frameshifts thanks to a draft alignment performed by MACSE, three additional options are available. The first allows to select the amino acid alignment tool (MAFFT or Muscle); the second allows to pass extra parameters to the alignment tool; the third allows to turn OFF the detection of frameshifts by MACSE. Note that if this option is turned OFF while some sequences actually do contain frameshifts, the resulting alignment will be meaningless since based on an erroneous translation of the nucleotide sequences.

| option\_name | used for | usage example |
| --- | --- | --- |
| –alignAA\_soft | specifying the software to use, MAFFT (default), Muscle or PRANK for aligning the frameshift corrected amino acid sequences | –alignAA\_soft MUSCLE |
| –aligner\_extra\_option | specifying the options to provide to the alignment software | –aligner\_extra\_option « –localpair –maxiterate 1000 » |
| –no\_FS\_detection | turning OFF the detection of frameshifts by MACSE | –no\_FS\_detection |

Muscle and PRANK are used with default parameters. MAFFT (default aligner) is launch using « –localpair –maxiterate 2000 », which correspond to [L-INS-i algorithm](https://mafft.cbrc.jp/alignment/software/algorithms/algorithms.html) and is usually better adapted for CDS sequences.

© 2026 GE²pop • Construit avec [GeneratePress](https://generatepress.com)