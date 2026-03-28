|  |
| --- |
| iVar |

Loading...

Searching...

No Matches

Manual

### Table of Contents

* [Available Commands](#autotoc_md14)
* [Description of commands](#autotoc_md15)
  + [Trim primer sequences with iVar](#autotoc_md16)
  + [Call variants with iVar](#autotoc_md17)
  + [Filter variants across replicates with iVar](#autotoc_md18)
  + [Generate a consensus sequences from an aligned BAM file](#autotoc_md19)
  + [Get primers with mismatches to the reference sequence](#autotoc_md20)
  + [Remove reads associated with mismatched primer indices](#autotoc_md21)
  + [(Experimental) trimadapter](#autotoc_md22)

# Available Commands

| Command | Description |
| --- | --- |
| trim | Trim reads in aligned BAM |
| variants | Call variants from aligned BAM file |
| filtervariants | Filter variants across replicates or multiple samples aligned using the same reference |
| consensus | Call consensus from aligned BAM file |
| getmasked | Detect primer mismatches and get primer indices for the amplicon to be masked |
| removereads | Remove reads from trimmed BAM file |
| version | Show version information |
| trimadapter | (EXPERIMENTAL) Trim adapter sequences from reads |

To view detailed usage for each command type `ivar <command>` Note : Commands maked (EXPERIMENTAL) are still under active development.

# Description of commands

## Trim primer sequences with iVar

iVar uses primer positions supplied in a BED file to soft clip primer sequences from an aligned and sorted BAM file. Following this, the reads are trimmed based on a quality threshold(Default: 20). To do the quality trimming, iVar uses a sliding window approach(Default: 4). The windows slides from the 5' end to the 3' end and if at any point the average base quality in the window falls below the threshold, the remaining read is soft clipped. If after trimming, the length of the read is greater than the minimum length specified(Default: 30), the read is written to the new trimmed BAM file.

Please note that the strand is taken into account while doing the trimming so forward primers are trimmed only from forward strand and reverse primers are trimmed from reverse strand.

To sort and index an aligned BAM file (OPTIONAL, if index is not present iVar will create one), the following command can be used,

# Input file - test.bam

samtools sort -o test.sorted.bam test.bam && samtools index test.sorted.bam.

**Note**: All the trimming in iVar is done by soft-clipping reads in an aligned BAM file. This information is lost if reads are extracted in fastq or fasta format from the trimmed BAM file.

Command:

ivar trim

Usage: ivar trim -i [<input.bam>] -b <primers.bed> [-p <prefix>] [-m <min-length>] [-q <min-quality>] [-s <sliding-window-width>]

Input Options Description

-i Sorted bam file, with aligned reads, to trim primers and quality. If not specified will read from standard in

-b (Required) BED file with primer sequences and positions

-f Primer pair information file containing left and right primer names for the same amplicon separated by a tab

If provided, reads will be filtered based on their overlap with amplicons prior to trimming

-m Minimum length of read to retain after trimming (Default: 50% the average length of the first 1000 reads)

-q Minimum quality threshold for sliding window to pass (Default: 20)

-s Width of sliding window (Default: 4)

-e Include reads with no primers. By default, reads with no primers are excluded

-k Keep reads to allow for reanalysis: keep reads which would be dropped by

alignment length filter or primer requirements, but mark them QCFAIL

Output Options Description

-p Prefix for the output BAM file. If none is specified the output will write to standard out.

Example Usage:

ivar trim -b test\_primers.bed -p test.trimmed -i test.bam -q 15 -m 50 -s 4

samtools view -h test.bam | ivar trim -b test\_primers.bed -p test.trimmed

The command above will produce a trimmed BAM file test.trimmed.bam after trimming the aligned reads in test.bam using the primer positions specified in test\_primers.bed and a minimum quality threshold of **15**, minimum read length of **50** and a sliding window of **4**.

Example Usage:

bwa mem -t 32 reference.fa 1.fq 2.fq | ivar trim -b test\_primers.bed -x 3 -m 30 | samtools sort - | samtools mpileup -aa -A -Q 0 -d 0 - | ivar consensus -p test\_consensus -m 10 -n N -t 0.5

The command above will allow you to go from alignment to consensus sequence in a single command using the bwa aligner.

Example BED file

Puerto 28 52 400\_1\_out\_L 60 +

Puerto 482 504 400\_1\_out\_R 60 -

Puerto 359 381 400\_2\_out\_L 60 +

Puerto 796 818 400\_2\_out\_R 60 -

Puerto 658 680 400\_3\_out\_L\* 60 +

Puerto 1054 1076 400\_3\_out\_R\* 60 -

.

.

.

.

## Call variants with iVar

iVar uses the output of the `samtools mpileup` command to call variants - single nucleotide variants(SNVs) and indels. In order to call variants correctly, the reference file used for alignment must be passed to iVar using the `-r` flag. The output of `samtools pileup` is piped into `ivar variants` to generate a .tsv file with the variants. There are two parameters that can be set for variant calling using iVar - minimum quality(Default: 20) and minimum frequency(Default: 0.03). Minimum quality is the minimum quality for a base to be counted towards the ungapped depth to canculate iSNV frequency at a given position. For insertions, the quality metric is discarded and the mpileup depth is used directly. Minimum frequency is the minimum frequency required for a SNV or indel to be reported.

#### Amino acid translation of iSNVs

iVar can identify codons and translate variants into amino acids using a GFF file in the [GFF3](https://github.com/The-Sequence-Ontology/Specifications/blob/master/gff3.md) format containing the required coding regions (CDS). In absence of a GFF file, iVar will not perform the translation and "NA" will be added to the output file in place of the reference and alternate codons and amino acids. The GFF file in the GFF3 format can be downloaded via ftp from NCBI RefSeq/Genbank. They are usually the files with the extension ".gff.gz". For example, the GFF file for Zaire Ebolavirus can be found here. More details on GFF3 files hosted by NCBI can be found in their ftp [FAQs](https://www.ncbi.nlm.nih.gov/genome/doc/ftpfaq/).

#### Account for RNA editing through polymerase slippage

Some RNA viruses such as Ebola virus, might have polymerase slippage causing the insertion of a couple of nucleotides. More details can be found [here](https://viralzone.expasy.org/857?outline=all_by_protein). iVar can account for this editing and identify the correct open reading frames. The user will have to specify two additional parameters, **EditPosition**: Position at which edit occurs and **EditSequence**: The sequence tht is inserted at the given positon, in the "attributes" column of the GFF file to account for this. A test example is given below,

test Genbank CDS 2 292 . + . ID=id-testedit1;Note=PinkFloyd;EditPosition=100;EditSequence=A

test Genbank CDS 2 292 . + . ID=id-testedit2;Note=AnotherBrickInTheWall;EditPosition=102;EditSequence=AA

If a certain base is present in multiple CDSs, iVar will add a new row for each CDS frame and distinguish the rows by adding the ID (specified in attributes of GFF) of the GFF feature used for the translation. This is shown for position 42 in the example output below. There are two rows with two different GFF features: id-test3 and id-test4.

Command:

Usage: samtools mpileup -aa -A -d 0 -B -Q 0 --reference [<reference-fasta] <input.bam> | ivar variants -p <prefix> [-q <min-quality>] [-t <min-frequency-threshold>] [-m <minimum depth>] [-r <reference-fasta>] [-g GFF file]

Note : samtools mpileup output must be piped into ivar variants

Input Options Description

-q Minimum quality score threshold to count base (Default: 20)

-t Minimum frequency threshold(0 - 1) to call variants (Default: 0.03)

-m Minimum read depth to call variants (Default: 0)

-G Count gaps towards depth. By default, gaps are not counted

-r Reference file used for alignment. This is used to translate the nucleotide sequences and identify intra host single nucleotide variants

-g A GFF file in the GFF3 format can be supplied to specify coordinates of open reading frames (ORFs). In absence of GFF file, amino acid translation will not be done.

Output Options Description

-p (Required) Prefix for the output tsv variant file

Example Usage:

samtools mpileup -aa -A -d 600000 -B -Q 0 test.trimmed.bam | ivar variants -p test -q 20 -t 0.03 -r test\_reference.fa -g test.gff

The command above will generate a test.tsv file.

Example of output .tsv file.

REGION POS REF ALT REF\_DP REF\_RV REF\_QUAL ALT\_DP ALT\_RV ALT\_QUAL ALT\_FREQ TOTAL\_DP PVAL PASS GFF\_FEATURE REF\_CODON REF\_AA ALT\_CODON ALT\_AA

test 42 G T 0 0 0 1 0 49 1 1 1 FALSE id-test3 AGG R ATG M

test 42 G T 0 0 0 1 0 49 1 1 1 FALSE id-test4 CAG Q CAT H

test 320 A T 1 1 35 1 1 46 0.5 2 0.666667 FALSE NA NA NA NA NA

test 365 A T 0 0 0 1 1 27 1 1 1 FALSE NA NA NA NA NA

Description

| Field | Description |
| --- | --- |
| REGION | Region from BAM file |
| POS | Position on reference sequence |
| REF | Reference base |
| ALT | Alternate Base |
| REF\_DP | Ungapped depth of reference base |
| REF\_RV | Ungapped depth of reference base on reverse reads |
| REF\_QUAL | Mean quality of reference base |
| ALT\_DP | Ungapped depth of alternate base. |
| ALT\_RV | Ungapped deapth of alternate base on reverse reads |
| ALT\_QUAL | Mean quality of alternate base |
| ALT\_FREQ | Frequency of alternate base |
| TOTAL\_DP | Total depth at position |
| PVAL | p-value of fisher's exact test |
| PASS | Result of p-value <= 0.05 |
| GFF\_FEATURE | ID of the GFF feature used for the translation |
| REF\_CODON | Codong using the reference base |
| REF\_AA | Amino acid translated from reference codon |
| ALT\_CODON | Codon using the alternate base |
| ALT\_AA | Amino acid translated from the alternate codon |

**Note**: Please use the -B options with `samtools mpileup` to call variants and generate consensus. When a reference sequence is supplied, the quality of the reference base is reduced to 0 (ASCII: !) in the mpileup output. Disabling BAQ with -B seems to fix this. This was tested in samtools 1.7 and 1.8.

## Filter variants across replicates with iVar

iVar can be used to get an intersection of variants(in .tsv files) called from any number of replicates or from different samples using the same reference sequence. This intersection will filter out any iSNVs that do not occur in a minimum fraction of the files supplied. This parameter can be changed using the `-t` flag which range from 0 to 1 (default). Fields that are different across replicates(fields apart from REGION, POS, REF, ALT, REF\_CODON, REF\_AA, ALT\_CODON, ALT\_AA) will have the filename added as a suffix. If there are a large number of files to be filtered, the `-f` flag can be used to supply a text file with one sample/replicate variant .tsv file per line.

Command:

Usage: ivar filtervariants -p <prefix> replicate-one.tsv replicate-two.tsv ... OR ivar filtervariants -p <prefix> -f <text file with one variant file per line>

Input: Variant tsv files for each replicate/sample

Input Options Description

-t Minimum fration of files required to contain the same variant. Specify value within [0,1]. (Default: 1)

-f A text file with one variant file per line.

Output Options Description

-p (Required) Prefix for the output filtered tsv file

Example Usage: The command below only retains those variants that are found in atleast 50% of the fiels supplied

ivar filtervariants -t 0.5 -p test.filtered test.1.tsv test.2.tsv test.3.tsv

The three replicates can also be supplied using a text file as shown below

ivar filtervariants -t 0.5 -p test.filtered -f filter\_files.txt

filter\_files.txt

./path/to/test.1.tsv

./path/to/test.2.tsv

./path/to/test.3.tsv

The command above will prodoce an output .tsv file test.filtered.tsv.

Example output of filtered .tsv file from three files test\_rep1.tsv and test\_rep2.tsv

REGION POS REF ALT GFF\_FEATURE REF\_CODON REF\_AA ALT\_CODON ALT\_AA REF\_DP\_test.1.tsv REF\_RV\_test.1.tsv REF\_QUAL\_test.1.tsv ALT\_DP\_test.1.tsv ALT\_RV\_test.1.tsv ALT\_QUAL\_test.1.tsv ALT\_FREQ\_test.1.tsv TOTAL\_DP\_test.1.tsv PVAL\_test.1.tsv PASS\_test.1.tsv REF\_DP\_test.2.tsv REF\_RV\_test.2.tsv REF\_QUAL\_test.2.tsv ALT\_DP\_test.2.tsv ALT\_RV\_test.2.tsv ALT\_QUAL\_test.2.tsv ALT\_FREQ\_test.2.tsv TOTAL\_DP\_test.2.tsv PVAL\_test.2.tsv PASS\_test.2.tsv REF\_DP\_test.3.tsv REF\_RV\_test.3.tsv REF\_QUAL\_test.3.tsv ALT\_DP\_test.3.tsv ALT\_RV\_test.3.tsv ALT\_QUAL\_test.3.tsv ALT\_FREQ\_test.3.tsv TOTAL\_DP\_test.3.tsv PVAL\_test.3.tsv PASS\_test.3.tsv

test 139 T A id-test3 GCT A GCA A 1 0 32 1 0 55 0.5 2 0.666667 FALSE 1 0 32 1 0 55 0.5 2 0.666667 FALSE NA NA NA NA NA NA NA NA NA NA

test 320 A T NA NA NA NA NA 1 1 35 1 1 46 0.5 2 0.666667 FALSE NA NA NA NA NA NA NA NA NA NA 1 1 35 1 1 46 0.5 2 0.666667 FALSE

test 365 A T NA NA NA NA NA 0 0 0 1 1 27 1 1 1 FALSE 0 0 0 1 1 27 1 1 1 FALSE 0 0 0 1 1 27 1 1 1 FALSE

test 42 G T id-test4 CAG Q CAT H 0 0 0 1 0 49 1 1 1 FALSE 0 0 0 1 0 49 1 1 1 FALSE NA NA NA NA NA NA NA NA NA NA

test 42 G T id-testedit1 AGG R ATG M 0 0 0 1 0 49 1 1 1 FALSE 0 0 0 1 0 49 1 1 1 FALSE 0 0 0 1 0 49 1 1 1 FALSE

test 69 T G id-testedit2 TTG L TGG W 1 0 57 1 0 53 0.5 2 0.666667 FALSE 1 0 57 1 0 53 0.5 2 0.666667 FALSE 1 0 57 1 0 53 0.5 2 0.666667 FALSE

Description of fields

| No | Field | Description |
| --- | --- | --- |
| 1 | REGION | Common region across all replicate variant tsv files |
| 2 | POS | Common position across all variant tsv files |
| 3 | REF | Common reference base across all variant tsv files |
| 4 | ALT | Common alternate base across all variant tsv files |
| 5 | GFF\_FEATURE | GFF feature used for the translation |
| 6 | REF\_CODON | The codon using the reference base |
| 7 | REF\_AA | Reference codon translated into amino acid |
| 8 | ALT\_CODON | Codon using the alternate base |
| 9 | ALT\_AA | Alternate codon translated into amino acid |
| 10 | REF\_DP\_<rep1-tsv-file-name> | Depth of reference base in replicate 1 |
| 11 | REF\_RV\_<rep1-tsv-file-name> | Depth of reference base on reverse reads in replicate 1 |
| 12 | REF\_QUAL\_<rep1-tsv-file-name> | Mean quality of reference base in replicate 1 |
| 13 | ALT\_DP\_<rep1-tsv-file-name> | Depth of alternate base in replicate 1 |
| 14 | ALT\_RV\_<rep1-tsv-file-name> | Deapth of alternate base on reverse reads in replicate 1 |
| 15 | ALT\_QUAL\_<rep1-tsv-file-name> | Mean quality of alternate base in replicate 1 |
| 16 | ALT\_FREQ\_<rep1-tsv-file-name> | Frequency of alternate base in replicate 1 |
| 17 | TOTAL\_DP\_<rep1-tsv-file-name> | Total depth at position in replicate 1 |
| 18 | PVAL\_<rep1-tsv-file-name> | p-value of fisher's exact test in replicate 1 |
| 19 | PASS\_<rep1-tsv-file-name> | Result of 