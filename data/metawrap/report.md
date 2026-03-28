# metawrap CWL Generation Report

## metawrap_read_qc

### Tool Description
Performs quality control on raw sequencing reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/metawrap:1.2--0
- **Homepage**: https://github.com/bxlab/metaWRAP
- **Package**: https://anaconda.org/channels/bioconda/packages/metawrap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/metawrap/overview
- **Total Downloads**: 14.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bxlab/metaWRAP
- **Stars**: N/A
### Original Help Text
```text
metawrap read_qc --help

Usage: metaWRAP read_qc [options] -1 reads_1.fastq -2 reads_2.fastq -o output_dir
Note: the read files have to be named in the name_1.fastq/name_2.fastq convention.
Options:

	-1 STR          forward fastq reads
	-2 STR          reverse fastq reads
	-o STR          output directory
	-t INT          number of threads (default=1)
	-x STR		prefix of host index in bmtagger database folder (default=hg38)

	--skip-bmtagger		dont remove human sequences with bmtagger
	--skip-trimming		dont trim sequences with trimgalore
	--skip-pre-qc-report	dont make FastQC report of input sequences
	--skip-post-qc-report	dont make FastQC report of final sequences
```


## metawrap_assembly

### Tool Description
Assemble reads into contigs

### Metadata
- **Docker Image**: quay.io/biocontainers/metawrap:1.2--0
- **Homepage**: https://github.com/bxlab/metaWRAP
- **Package**: https://anaconda.org/channels/bioconda/packages/metawrap/overview
- **Validation**: PASS

### Original Help Text
```text
metawrap assembly --help

Usage: metaWRAP assembly [options] -1 reads_1.fastq -2 reads_2.fastq -o output_dir
Options:

	-1 STR          forward fastq reads
	-2 STR          reverse fastq reads
	-o STR          output directory
	-m INT          memory in GB (default=24)
	-t INT          number of threads (defualt=1)
	-l INT		minimum length of assembled contigs (default=1000)

	--megahit	assemble with megahit (default)
	--metaspades	assemble with metaspades instead of megahit (better results but slower amd higher memory requirement)
```


## metawrap_kraken

### Tool Description
Run on any number of fasta assembly files and/or or paired-end reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/metawrap:1.2--0
- **Homepage**: https://github.com/bxlab/metaWRAP
- **Package**: https://anaconda.org/channels/bioconda/packages/metawrap/overview
- **Validation**: PASS

### Original Help Text
```text
metawrap kraken --help

Run on any number of fasta assembly files and/or or paired-end reads.
Usage: metaWRAP kraken [options] -o output_dir assembly.fasta reads_1.fastq reads_2.fastq ...
Options:

	-o STR          output directory
	-t INT          number of threads
	-s INT		read subsampling number (default=all)
	--no-preload	do not pre-load the kraken DB into memory (slower, but lower memory requirement)

	Note: you may pass any number of sequence files with the following extensions:
	*.fa *.fasta (assumed to be assembly files) or *_1.fastq and *_2.fastq (assumed to be paired)
```


## metawrap_blobology

### Tool Description
Run blobology on assembly and reads

### Metadata
- **Docker Image**: quay.io/biocontainers/metawrap:1.2--0
- **Homepage**: https://github.com/bxlab/metaWRAP
- **Package**: https://anaconda.org/channels/bioconda/packages/metawrap/overview
- **Validation**: PASS

### Original Help Text
```text
metawrap blobology --help

Usage: metaWRAP blobology [options] -a assembly.fasta -o output_dir readsA_1.fastq readsA_2.fastq [readsB_1.fastq readsB_2.fastq ... ]
Options:

	-a STR		assembly fasta file
	-o STR          output directory
	-t INT          number of threads

	--subsamble 	INT	Number of contigs to run blobology on. Subsampling is randomized. (default=ALL)
	--bins		STR	Folder containing bins. Contig names must match those of the assembly file. (default=None)
```


## metawrap_binning

### Tool Description
Binning module for metagenomic assemblies

### Metadata
- **Docker Image**: quay.io/biocontainers/metawrap:1.2--0
- **Homepage**: https://github.com/bxlab/metaWRAP
- **Package**: https://anaconda.org/channels/bioconda/packages/metawrap/overview
- **Validation**: PASS

### Original Help Text
```text
metawrap binning --h

Usage: metaWRAP binning [options] -a assembly.fa -o output_dir readsA_1.fastq readsA_2.fastq ... [readsX_1.fastq readsX_2.fastq]
Note1: Make sure to provide all your separately replicate read files, not the joined file.
Note2: You may provide single end or interleaved reads as well with the use of the correct option
Note3: If the output already has the .bam alignments files from previous runs, the module will skip re-aligning the reads

Options:

	-a STR          metagenomic assembly file
	-o STR          output directory
	-t INT          number of threads (default=1)
	-m INT		amount of RAM available (default=4)
	-l INT		minimum contig length to bin (default=1000bp). Note: metaBAT will default to 1500bp minimum

	--metabat2      bin contigs with metaBAT2
	--metabat1	bin contigs with the original metaBAT
	--maxbin2	bin contigs with MaxBin2
	--concoct	bin contigs with CONCOCT

	--universal	use universal marker genes instead of bacterial markers in MaxBin2 (improves Archaea binning)
	--run-checkm	immediately run CheckM on the bin results (requires 40GB+ of memory)
	--single-end	non-paired reads mode (provide *.fastq files)
	--interleaved	the input read files contain interleaved paired-end reads


************************************************************************************************************************
*****           You must select at least one binning method: --metabat2, --metabat1, --maxbin2, --concoct          *****
************************************************************************************************************************
```


## metawrap_bin_refinement

### Tool Description
Refine metagenomic bins from multiple sources.

### Metadata
- **Docker Image**: quay.io/biocontainers/metawrap:1.2--0
- **Homepage**: https://github.com/bxlab/metaWRAP
- **Package**: https://anaconda.org/channels/bioconda/packages/metawrap/overview
- **Validation**: PASS

### Original Help Text
```text
metawrap bin_refinement --h

------------------------------------------------------------------------------------------------------------------------
-----                             Non-optional parameters -o and/or -A were not entered                            -----
------------------------------------------------------------------------------------------------------------------------


Usage: metaWRAP bin_refinement [options] -o output_dir -A bin_folderA [-B bin_folderB -C bin_folderC]
Note: the contig names in different bin folders must be consistant (must come from the same assembly).

Options:

	-o STR          output directory
	-t INT          number of threads (default=1)
	-m INT		memory available (default=40)
	-c INT          minimum % completion of bins [should be >50%] (default=70)
	-x INT          maximum % contamination of bins that is acceptable (default=10)

	-A STR		folder with metagenomic bins (files must have .fa or .fasta extension)
	-B STR		another folder with metagenomic bins
	-C STR		another folder with metagenomic bins

	--skip-refinement	dont use binning_refiner to come up with refined bins based on combinations of binner outputs
	--skip-checkm		dont run CheckM to assess bins
	--skip-consolidation	choose the best version of each bin from all bin refinement iteration
	--keep-ambiguous	for contigs that end up in more than one bin, keep them in all bins (default: keeps them only in the best bin)
	--remove-ambiguous	for contigs that end up in more than one bin, remove them in all bins (default: keeps them only in the best bin)
	--quick			adds --reduced_tree option to checkm, reducing runtime, especially with low memory
```


## metawrap_reassemble_bins

### Tool Description
Reassemble metagenomic bins using provided reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/metawrap:1.2--0
- **Homepage**: https://github.com/bxlab/metaWRAP
- **Package**: https://anaconda.org/channels/bioconda/packages/metawrap/overview
- **Validation**: PASS

### Original Help Text
```text
metawrap reassemble_bins --h

------------------------------------------------------------------------------------------------------------------------
-----                                 Some non-optional parameters were not entered                                -----
------------------------------------------------------------------------------------------------------------------------


Usage: metaWRAP reassemble_bins [options] -o output_dir -b bin_folder -1 reads_1.fastq -2 reads_2.fastq

Options:

	-b STR		folder with metagenomic bins
	-o STR		output directory
	-1 STR          forward reads to use for reassembly
	-2 STR          reverse reads to use for reassembly

	-t INT		number of threads (default=1)
	-m INT		memory in GB (default=40)
	-c INT		minimum desired bin completion % (default=70)
	-x INT		maximum desired bin contamination % (default=10)
	-l INT		minimum contig length to be included in reassembly (default=500)

	--strict-cut-off	maximum allowed SNPs for strict read mapping (default=2)
	--permissive-cut-off	maximum allowed SNPs for permissive read mapping (default=5)
	--skip-checkm		dont run CheckM to assess bins
	--parallel		run spades reassembly in parallel, but only using 1 thread per bin
```


## metawrap_quant_bins

### Tool Description
Quantify abundance of bins in metagenomic datasets

### Metadata
- **Docker Image**: quay.io/biocontainers/metawrap:1.2--0
- **Homepage**: https://github.com/bxlab/metaWRAP
- **Package**: https://anaconda.org/channels/bioconda/packages/metawrap/overview
- **Validation**: PASS

### Original Help Text
```text
metawrap quant_bins --h

------------------------------------------------------------------------------------------------------------------------
-----                              Non-optional parameters -b and -o were not entered                              -----
------------------------------------------------------------------------------------------------------------------------


Usage: metaWRAP quant_bins [options] -b bins_folder -o output_dir -a assembly.fa readsA_1.fastq readsA_2.fastq ... [readsX_1.fastq readsX_2.fastq]
Options:

	-b STR          folder containing draft genomes (bins) in fasta format
	-o STR          output directory
	-a STR		fasta file with entire metagenomic assembly (strongly recommended!)
	-t INT		number of threads
```


## metawrap_classify_bins

### Tool Description
Classify bins

### Metadata
- **Docker Image**: quay.io/biocontainers/metawrap:1.2--0
- **Homepage**: https://github.com/bxlab/metaWRAP
- **Package**: https://anaconda.org/channels/bioconda/packages/metawrap/overview
- **Validation**: PASS

### Original Help Text
```text
metawrap classify_bins --help

Usage: metaWRAP classify_bins [options] -b bin_folder -o output_dir
Options:

	-b STR		folder with the bins to be classified (in fasta format)
	-o STR		output directory
	-t INT          number of threads
```


## metawrap_annotate_bins

### Tool Description
Annotates metagenomic bins.

### Metadata
- **Docker Image**: quay.io/biocontainers/metawrap:1.2--0
- **Homepage**: https://github.com/bxlab/metaWRAP
- **Package**: https://anaconda.org/channels/bioconda/packages/metawrap/overview
- **Validation**: PASS

### Original Help Text
```text
metawrap annotate_bins --h

------------------------------------------------------------------------------------------------------------------------
-----                                 Some non-optional parameters were not entered                                -----
------------------------------------------------------------------------------------------------------------------------


Usage: metaWRAP annotate_bins [options] -o output_dir -b bin_folder

Options:

	-o STR		output directory
	-t INT		number of threads (default=1)
	-b STR		folder with metagenomic bins in fasta format
```


## Metadata
- **Skill**: generated
