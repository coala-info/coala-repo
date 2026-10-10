# metawrap-binning CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| metawrap-binning_binning | PASS | metabat2, maxbin2 and concoct made bins on B. fragilis contigs |


## metawrap-binning_binning

### Tool Description
metaWRAP binning module

### Metadata
- **Docker Image**: quay.io/biocontainers/metawrap-binning:1.3.0
- **Homepage**: https://github.com/bxlab/metaWRAP
- **Package**: https://anaconda.org/channels/bioconda/packages/metawrap-binning/overview
- **Validation**: PASS

### Original Help Text
```text
metawrap binning -h

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
```

