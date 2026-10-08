# gbsx CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| gbsx_BarcodeDiscovery | PASS |  |
| gbsx_BarcodeGenerator | PASS |  |
| gbsx_DNAComplement | PASS |  |
| gbsx_Demultiplexer | PASS |  |
| gbsx_GBSsimulator | PASS | works with a sample/barcode/enzyme table like the example barcode_list.txt; crashes with the raw BarcodeGenerator output |

## gbsx_Demultiplexer

### Tool Description
GBSX demultiplex v3: demultiplexes fastq or fastq.gz files from sequencing with inline barcodes, as used in GBS and RAD protocols.

### Metadata
- **Docker Image**: quay.io/biocontainers/gbsx:1.3--0
- **Homepage**: https://github.com/GenomicsCoreLeuven/GBSX
- **Package**: https://anaconda.org/channels/bioconda/packages/gbsx/overview
- **Validation**: PASS

### Original Help Text
```text


This is the help of the demultiplexer.

KU Leuven
Licenced under GPLv3
GBSX demultiplex v3

This program demultiplexes fastq or fastq.gz files direved of Sequencing with inline barcodes.
Like used in GBS, RAD, ... protocols.

These parameters are mandatory: 
	 -f1 	 the name and path of the fastq or fastq.gz file to demultiplex
	 -i 	 the name and path of the info file. This is a tab delimeted file without headings, with three (or more) columns: sample, sequence of the barcode, name of the enzyme, name of the second enzyme (optional, can be an empty string), the second barcode (optional, can be an empty string),mismatches for the barcode (optional)

These parameters are optional: 
	 -f2 	 the name of the second fastq or fastq.gz file (only with paired-end sequencing)
	 -o 	 the name of the output directory (standard the directory of the call)
	 -lf 	 use long file names (standard false) filename is standard the sample name, long file names is sample name _ barcode _ enzyme
	 -rad 	 if the data is rad data or not (-rad true for RAD data, -rad false for GBS data) standard false (GBS)
	 -gzip 	 the input and output are/must be gziped (.gz) (standard false: input and output are .fastq, if true this is .fastq.gz)
	 -t 	 the number of threads to use (standard 1)
	 -mb 	 the allowed mismatches in the barcodes (overrides the option -m)
	 -me 	 the allowed mismatches in the enzymes (overrides the option -m)
	 -minsl 	 the minimum allowed length for the sequences (standard 0, rejected sequences are found in the stats for each sample in the rejected.count column. The sequences self are found untrimmed in the undetermined file.)
	 -n 	 keep sequences where N occurs as nucleotide (standard true)
	 -ca 	 the common adaptor used in the sequencing (standard (only first piece) AGATCGGAAGAGCG) currently only used for adaptor ligase see -al and when -rad is true) (minimum length is 10)
	 -s 	 the posible distance of the start. This is the distance count from the start of the read to the first basepair of the barcode or enzyme (standard 0, maximum 20)
	 -kc 	 Keep the enzyme cut-site remains (standard true)
	 -ea 	 Add enzymes from the given file (keeps the standard enzymes, and add the new) (enzyme file: no header, enzyme name tab cutsites (multiple cutsites are comma separeted)) (only use once, not use -er)
	 -er 	 Replace enzymes from the given file (don't keep the standard enzymes) (enzyme file: no header, enzyme name tab cutsites (multiple cutsites are comma separeted)) (only use once, not use -ea)
	 -scb 	 Use self correcting barcodes (barcodes created by the barcodeGenerator) (standard false)
	 -malg 	 the used algorithm to find mismatches and indels, possible algorithms (see README): 
	 	 	hammings (Standard)	Checks for mismatches (no indels)
	 	 	knuth	Faster than hammings, but can miss some locations
	 	 	indelmis	Checks for mismatches and indels, the barcode/enzyme/adaptor with the least errors (mismatches or indels) is taken
	 	 	misindel	Checks for mismatches and indels, the mismatches are supperior to the indels (faster than indelmis, but errors can be higher)

	 -q 	 the kind of quality scores used in the fastq file (including how phred scores are encoded): 
	 	 	Illumina1.8 (Standard)
	 	 	Illumina1.5
	 	 	Illumina1.3
	 	 	Sanger
	 	 	Solid



Possible Standard Enzymes for the info file: (NAN is no enzyme)
	ApeKI
	PstI
	EcoT22I
	PasI
	HpaII
	MspI
	PstI-EcoT22I
	PstI-MspI
	PstI-TaqI
	SbfI-MspI
	AsiSI-MspI
	BssHII-MspI
	FseI-MspI
	SalI-MspI
	ApoI
	BamHI
	MseI
	Sau3AI
	RBSTA
	RBSCG
	NspI
	AvaII
	NA

Developed by the KU Leuven 2014
Licenced under GPLv3
For licence information use -licence
```

## gbsx_BarcodeDiscovery

### Tool Description
GBSX Barcode Discovery v1.0: searches a fastq file for possible barcodes and barcode-enzyme combinations.

### Metadata
- **Docker Image**: quay.io/biocontainers/gbsx:1.3--0
- **Homepage**: https://github.com/GenomicsCoreLeuven/GBSX
- **Package**: https://anaconda.org/channels/bioconda/packages/gbsx/overview
- **Validation**: PASS

### Original Help Text
```text


This is the help of the BarcodeFinder.

KU Leuven
Licenced under GPLv3
Barcode Discovery v1.0

This program search for possible barcodes, and barcode enzyme combinations.

Mandatory paramters:
	 -f1 	 the name of the input file 
Optional parameters:
	 -min 	 the minimum length of the barcode (standard 6) 
	 -max 	 the maximum length of the barcode (standard 16) 
	 -gzip 	 use gzip files as input and output (standard false) 
	 -o 	 the output directory (standard the directory of execution) 
	 -ea 	 Add enzymes from the given file (keeps the standard enzymes, and add the new) (enzyme file: no header, enzyme name tab cutsites (multiple cutsites are comma separeted)) (only use once, not use -er)
	 -er 	 Replace enzymes from the given file (don't keep the standard enzymes) (enzyme file: no header, enzyme name tab cutsites (multiple cutsites are comma separeted)) (only use once, not use -ea)
	 -barmin 	 The minimum occurance of a barcode before it is shown in the results (standard: 200) 
	 -barmax 	 The maximum of barcodes shown in the output (increasing this number will increase ram usage, but gives a slightly better result) (standard: 100)
	 -barmis 	 The percentage of mismatches that may occure between barcodes (integer between 1 and 10) (standard: 10)
	 -fe 	 Find possible enzyme combinations (standard: true)



Developed by the KU Leuven 2014
Licenced under GPLv3
For licence information use -licence
```

## gbsx_DNAComplement

### Tool Description
GBSX DNA Complement creator: makes the complement of a given DNA sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/gbsx:1.3--0
- **Homepage**: https://github.com/GenomicsCoreLeuven/GBSX
- **Package**: https://anaconda.org/channels/bioconda/packages/gbsx/overview
- **Validation**: PASS

### Original Help Text
```text
This is the DNA complement creator.
The only parameter is a string of DNA.
```

## gbsx_BarcodeGenerator

### Tool Description
GBSX Barcode Generator v1.0: generates a given number of random self-correcting barcodes (Hamming distance of at least 3).

### Metadata
- **Docker Image**: quay.io/biocontainers/gbsx:1.3--0
- **Homepage**: https://github.com/GenomicsCoreLeuven/GBSX
- **Package**: https://anaconda.org/channels/bioconda/packages/gbsx/overview
- **Validation**: PASS

### Original Help Text
```text


This is the help of the BarcodeGenerator.

KU Leuven
Licenced under GPLv3
Barcode Generator v1.0

This program generates a given number of random Barcodes.

Mandatory parameters:
	 -b 	 the number of barcodes needed.
	 -e 	 the enzyme used for the experiment.
Optional parameters:
	 -ef 	 the enzyme file. This option adds new enzymes. The file must be tab delimited: First column the enzyme name, second column the cutsites remains (comma separated). 
	 -nb 	 the number of bootstraps that maximum must be executed. (standard 10000) By the start of a new bootstrap a complete new design is made. The best scored design (most random barcodes and best scored bases distribution is kept as result) 
	 -bt 	 the number of barcode tries. (standard 20) If a random barcode does not fit into the current design try this number of times with a new random barcode before restarting the bootstrap.
	 -o 	 the output directory (standard current working directory) 
	 -us 	 try tho find the ultime match: the best barcode combination with the best bases distribution (standard false)  true: continue even when the right number of barcodes is found.
	 -bf 	 a file with all barcodes that are used as basic set (this file is one of the possible output files)
	 -nf 	 a file with all barcodes that may not be used in the design. If this file contains barcodes that are also foundin the basic set file, these barcodes will be replaced in the design by new random barcodes



Developed by the KU Leuven 2014
Licenced under GPLv3
For licence information use -licence
```

## gbsx_GBSsimulator

### Tool Description
GBSX GBS Data Simulator v2.0: simulates GBS data (one or two fastq files, plus a file with the errors per barcode) from a fasta file and a barcode file. Meant for testing.

### Metadata
- **Docker Image**: quay.io/biocontainers/gbsx:1.3--0
- **Homepage**: https://github.com/GenomicsCoreLeuven/GBSX
- **Package**: https://anaconda.org/channels/bioconda/packages/gbsx/overview
- **Validation**: PASS

### Original Help Text
```text


This is the help of the GBSsimulator.

Genomics Core Leuven
Licenced under GLPv3
GBS Data Simulator v2.0

This program simulates GBS data, given a fasta file and a barcode file.
The program will output one or two fastq files (single/paired-end), a file with the errors per barcode

	-o	Output directory
	-f	fastafile (sequences in the fasta file must be orientated as enzyme1 to enzyme2)
	-b	barcode file (output of the Barcode Generator)
	-p	is paired end (optional, standard true)(dual barcodes are only possible in the paired end mode)
	-a	common adapter (optional, AGATCGGAAGAGCG)
	-l	read length (optional, standard 100)
	-rpl	read per locus (optional, standard 6)
	-e	errors (optional, standard true)


Developed by the Genomics Core Leuven 2014
Licenced under GLPv3
```

