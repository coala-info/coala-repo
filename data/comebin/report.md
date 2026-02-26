# comebin CWL Generation Report

## comebin_gen_cov_file.sh

### Tool Description
Generates coverage files from reads and a metagenomic assembly.

### Metadata
- **Docker Image**: quay.io/biocontainers/comebin:1.0.4--hdfd78af_1
- **Homepage**: https://github.com/ziyewang/COMEBin
- **Package**: https://anaconda.org/channels/bioconda/packages/comebin/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/comebin/overview
- **Total Downloads**: 5.2K
- **Last updated**: 2025-09-18
- **GitHub**: https://github.com/ziyewang/COMEBin
- **Stars**: N/A
### Original Help Text
```text
1
1000

------------------------------------------------------------------------------------------------------------------------
-----                             Non-optional parameters -a and/or -o were not entered                            -----
------------------------------------------------------------------------------------------------------------------------ 


Usage: bash gen_coverage_file.sh [options] -a assembly.fa -o output_dir readsA_1.fastq readsA_2.fastq ... [readsX_1.fastq readsX_2.fastq]
Note1: Make sure to provide all your separately replicate read files, not the joined file.
Note2: You may provide single end or interleaved reads as well with the use of the correct option
Note3: If the output already has the .bam alignments files from previous runs, the module will skip re-aligning the reads

Options:

	-a STR    metagenomic assembly file
	-o STR    output directory (to save the coverage files)
	-b STR    directory for the bam files
	-t INT    number of threads (default=1)
	-m INT		amount of RAM available (default=4)
	-l INT		minimum contig length to bin (default=1000bp).
	--single-end	non-paired reads mode (provide *.fastq files)
	--interleaved	the input read files contain interleaved paired-end reads
	-f STR    Forward read suffix for paired reads (default=_1.fastq)
	-r STR    Reverse read suffix for paired reads (default=_2.fastq)
```


## comebin_run_comebin.sh

### Tool Description
COMEBin version: 1.0.4

### Metadata
- **Docker Image**: quay.io/biocontainers/comebin:1.0.4--hdfd78af_1
- **Homepage**: https://github.com/ziyewang/COMEBin
- **Package**: https://anaconda.org/channels/bioconda/packages/comebin/overview
- **Validation**: PASS

### Original Help Text
```text
COMEBin version: 1.0.4
Usage: bash run_comebin.sh [options] -a contig_file -o output_dir -p bam_file_path
Options:

  -a STR          metagenomic assembly file
  -o STR          output directory
  -p STR          path to access to the bam files
  -n INT          number of views for contrastive multiple-view learning (default=6)
  -t INT          number of threads (default=5)
  -l FLOAT        temperature in loss function (default=0.07 for assemblies with an N50 > 10000, default=0.15 for others)
  -e INT          embedding size for comebin network (default=2048)
  -c INT          embedding size for coverage network (default=2048)
  -b INT          batch size for training process (default=1024)
```

