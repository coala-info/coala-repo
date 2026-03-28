|  |
| --- |
|  |

---

[Home](http://www.atgc-montpellier.fr/)

---

[Organization](http://www.atgc-montpellier.fr/organization)

---

[Citations & Statistics](http://www.atgc-montpellier.fr/index.php?type=st)

---

[Partners](http://www.atgc-montpellier.fr/index.php?type=pt)

---

[Online programs](http://www.atgc-montpellier.fr/index.php?type=pg)

---

[Binaries](http://www.atgc-montpellier.fr/index.php?type=bn)

---

[LoRDEC](http://www.atgc-montpellier.fr/lordec/)

---

---

[Databases](http://www.atgc-montpellier.fr/index.php?type=db)

---

[Datasets](http://www.atgc-montpellier.fr/index.php?type=dt)

---

[NGS](http://www.atgc-montpellier.fr/lordec/)

## LoRDEC: a hybrid error correction program for long, PacBio reads

L. Salmela and E. Rivals

LoRDEC: accurate and efficient long read error correction

[Bioinformatics 30(24):3506-3514, 2014, doi: 10.1093/bioinformatics/btu538.](http://bioinformatics.oxfordjournals.org/content/early/2014/08/27/bioinformatics.btu538.abstract "LoRDEC paper")

---

Contents: [Source code](#source) [Installation](#install) [Usage](#usage) [Licences](#licences) [Contact](#contact)

### Overview

LoRDEC is a program to correct sequencing errors in long reads from 3rd generation sequencing with high error rate, and is especially intended for PacBio reads. It uses a hybrid strategy, meaning that it uses two sets of reads: the reference read set, whose error rate is assumed to be small, and the PacBio read set, which is then corrected using the reference set. Typically, the reference set contains Illumina reads.

Usually, errors in PacBio reads include many insertions and deletions, and comparatively less substitutions. LoRDEC can correct errors of all these types.
After correction, a larger portion of the sequence of PacBio reads is usable for detection of region of similarity with other sequences, for aligning them to the contigs of an assembly, etc.

* Why is LoRDEC different?
  + It is efficient and can process large read data sets, included from eukaryotic or vertebrate species, on a usual computing server, and even works on desktop/laptop computers.
  + It adopts a novel graph based approach: it builds a succinct De Bruijn Graph (DBG) representing the short reads, and seeks a corrective sequence for each erroneous region of a long read by traversing chosen paths in the graph.
* **Input and output**

  The inputs read sets are in FASTA or FASTQ format. The reference read set can be compressed (more exactly gzipped).
  The output is the set of corrected reads also in FASTA format. In these corrected sequences: uppercase symbol denote correct nucleotides, while lowercase denote nucleotides left un-corrected.
  The correction program needs also two parameters when it is called (so 5 information altogether, see its Usage below):
  + the parameter, k, i.e. the length of the k-mers that are counted and used in the graph
  + the solidity threshold, s, in other words a minimal number of occurrences of a k-mer such that it is assumed to be correct in Illumina reads.
  For bacterial species or eukaryotic species with small genomes, you may choose k=19 or 17, and s=2 or 3. For species with larger genomes, k=21 and s=2 or 3.
* **Programs**

  LoRDEC contains several programs:
  1. lordec-correct: the main program for correcting the PacBio reads
  2. lordec-stats: for computing statistics about the PacBio reads
  3. lordec-trim: to trim in the corrected PacBio reads the parts at the beginning or end of the sequence that could not be corrected.
  4. lordec-trim-split: trim the corrected PacBio reads and split them into several parts if some internal region could not be corrected.
  5. lordec-build-SR-graph: builds the de Bruijn Graph from the FASTA file of short reads and saves it to a HD5 formatted file
  Programs trim and trim-split take as input corrected PacBio reads.

### Downloads and installation

See [instructions](https://gite.lirmm.fr/lordec/lordec-releases/wikis/home)

LoRDEC is available as

* source code
* conda package
* binaries for Linux and MacOSX

### Usage

Usage (changed at version 0.3)
The parameters on the commande line can be given in any order.

1. For correcting the PacBio reads: lordec-correct
   **Usage**:

   ```
   	  lordec-correct
   	     [--trials <number of target k-mers>]
   	     [--branch <maximum number of branches to explore>]
   	     [--errorrate <maximum error rate>]
   	     [--threads <number of threads>]
   	     -2 <FASTA/Q files> -k <k-mer size> -s <abundance threshold> -i <PacBio FASTA file> -o <output file corrected reads>Typical command:

   ```
   	    lordec-correct -2 illumina.fasta -k 19 -s 3 -i pacbio.fasta -o pacbio-corrected.fasta
   ```
   ```
2. For computing statistics: lordec-stats
   **Usage**:

   ```
         lordec-stats -2 <Short read FASTA/Q file> -k <k-mer size> -s <solid k-mer threshold> -i <PacBio FASTA/Q file> -S <output stat file> [-T <number of threads>]
   ```
3. For trimming the corrected PacBio reads: lordec-trim
   **Usage**:

   ```
         lordec-trim -i <corrected reads file> -o <trimmed reads file>
   ```
4. For trimming and splitting the corrected PacBio reads: lordec-trim-split
   **Usage**:

   ```
       lordec-trim-split -i <corrected reads file> -o <trimmed reads file>
   ```
5. For building and saving the de Bruijn Graph of short reads: lordec-build-SR-graph
   **Usage**:

   ```
         lordec-build-SR-graph [-T <number of threads>] -2 <FASTA file> -k <k-mer size> -s <solid k-mer threshold> -g <out graph file>
   ```

### Licences

* LoRDEC is distributed under the [CeCILL A license](http://www.cecill.info/licences.en.html)
* GATB library is distributed under the [GNU Affero General Public License](http://www.gnu.org/licenses/agpl-3.0.en.html)

### Authors and contact

1. [Leena Salmela](http://www.cs.helsinki.fi/u/lmsalmel/) mail
   Department of Computer Science, P. O. Box 68, FIN-00014 University of Helsinki, Finland
2. [Eric Rivals](http://www.lirmm.fr/~rivals) mail
   LIRMM and Institut de Biologie Computationelle, CNRS and Université Montpellier, Montpellier, France

### Supplementary file

* The set of reads data used for experiments are described in a [supplementary file](http://www.atgc-montpellier.fr/lordec/acor-sm.pdf).

### Funding

This work was supported by

* Academy of Finland [grant number 267591]
* ANR [Colib'read](http://colibread.inria.fr) (ANR-12-BS02-0008)
* Défi [MASTODONS SePhHaDe](http://www.lirmm.fr/mastodons) from CNRS
* [Labex NumEV](http://www.lirmm.fr/numev)

Contact: Webmaster, LIRMM.

|  |  |  |  |  |
| --- | --- | --- | --- | --- |
| [![Universitée de Montpellier](http://www.atgc-montpellier.fr/pictures/logo_um.png "Université de Montpellier")](http://www.umontpellier.fr/) | [![IFB](https://www.france-bioinformatique.fr/wp-content/uploads/logo-ifb-couleur.svg "IFB")](http://www.france-bioinformatique.fr/) | [![CNRS-Ingénierie](http://www.atgc-montpellier.fr/pictures/logo_cnrs.gif "CNRS-INS2I")](http://www.cnrs.fr/ins2i/) | [![Logo France Genomique](https://www.france-genomique.org/wp-content/uploads/2019/03/logo-FG-blue-RVB-medium.png "France Genomique")](http://www.france-genomique.org/) | [![Logo LIRMM](http://www.atgc-montpellier.fr/pictures/logo_lirmm.jpg "LIRMM")](http://www.lirmm.fr/) |