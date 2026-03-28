# metawrap-kraken CWL Generation Report

## metawrap-kraken_metawrap kraken

### Tool Description
Run on any number of fasta assembly files and/or or paired-end reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/metawrap-kraken:1.3.0--hdfd78af_3
- **Homepage**: https://github.com/bxlab/metaWRAP
- **Package**: https://anaconda.org/channels/bioconda/packages/metawrap-kraken/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/metawrap-kraken/overview
- **Total Downloads**: 43
- **Last updated**: 2025-10-30
- **GitHub**: https://github.com/bxlab/metaWRAP
- **Stars**: N/A
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


## metawrap-kraken_metawrap kraken2

### Tool Description
Please select a proper module of metaWRAP.

### Metadata
- **Docker Image**: quay.io/biocontainers/metawrap-kraken:1.3.0--hdfd78af_3
- **Homepage**: https://github.com/bxlab/metaWRAP
- **Package**: https://anaconda.org/channels/bioconda/packages/metawrap-kraken/overview
- **Validation**: PASS

### Original Help Text
```text
------------------------------------------------------------------------------------------------------------------------
-----                                  Please select a proper module of metaWRAP.                                  -----
------------------------------------------------------------------------------------------------------------------------


MetaWRAP v=1.3.0
Usage: metaWRAP [module]

	Modules:
	read_qc		Raw read QC module (read trimming and contamination removal)
	assembly	Assembly module (metagenomic assembly)
	kraken		KRAKEN module (taxonomy annotation of reads and assemblies)
	blobology	Blobology module (GC vs Abund plots of contigs and bins)

	binning		Binning module (metabat, maxbin, or concoct)
	bin_refinement	Refinement of bins from binning module
	reassemble_bins Reassemble bins using metagenomic reads
	quant_bins	Quantify the abundance of each bin across samples
	classify_bins	Assign taxonomy to genomic bins
	annotate_bins	Functional annotation of draft genomes

	--help | -h		show this help message
	--version | -v	show metaWRAP version
	--show-config	show where the metawrap configuration files are stored
```


## Metadata
- **Skill**: generated
