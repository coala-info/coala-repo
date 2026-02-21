# bitmapperbs CWL Generation Report

## bitmapperbs

### Tool Description
FAIL to generate CWL: bitmapperbs not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/bitmapperbs:1.0.2.3--hf5e1c6e_5
- **Homepage**: https://github.com/chhylp123/BitMapperBS
- **Package**: https://anaconda.org/channels/bioconda/packages/bitmapperbs/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/bitmapperbs/overview
- **Total Downloads**: 23.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/chhylp123/BitMapperBS
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: bitmapperbs not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: bitmapperbs not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## bitmapperbs_bitmapperBS

### Tool Description
A fast and accurate read aligner for whole-genome bisulfite sequencing.

### Metadata
- **Docker Image**: quay.io/biocontainers/bitmapperbs:1.0.2.3--hf5e1c6e_5
- **Homepage**: https://github.com/chhylp123/BitMapperBS
- **Package**: https://anaconda.org/channels/bioconda/packages/bitmapperbs/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
BitMapperBS: a fast and accurate read aligner for whole-genome bisulte sequencing.

Usage: bitmapperBS [options]

General Options:
 -v|--version		Current Version.
 -h			Show the help file.


Options of indexing step:
 --index [file]		Generate an index from the specified fasta file. 
 --index_folder [folder]Set the folder that stores the genome indexes. If this option is not set, 
			the indexes would be stores in the same folder of genome (input fasta file). 


Options of read mapping step:
 --search [file/folder]	Search in the specified genome. If the indexes of this genome are built without "--index_folder", 
			please provide the path to the fasta file of genome (index files should be in the same folder). 
			Otherwise please provide the path to the index folder (set by "--index_folder" during indexing).
 --fast 		Set bitmapperBS in fast mode (default). This option is only available in paired-end mode.
 --sensitive 		Set bitmapperBS in sensitive mode. This option is only available in paired-end mode.
 --seq [file]		Input sequences in fastq/fastq.gz format [file]. This option is used  
			for single-end reads.
 --seq1 [file]		Input sequences in fastq/fastq.gz format [file] (First file). 
			Use this option to indicate the first file of 
			paired-end reads. 
 --seq2 [file]		Input sequences in fastq/fastq.gz format [file] (Second file). 
			Use this option to indicate the second file of 
			paired-end reads.  
 -o [file]		Output of the mapped sequences in SAM or BAM format. The default is "stdout" (standard output) in SAM format.
 --sam 			Output mapping results in SAM format (default).
 --bam 			Output mapping results in BAM format.
 --methy_out 		Output the intermediate methylation result files, instead of SAM or BAM files.
 -e [float]		Set the edit distance rate of read length. This value is between 0 and 1 (default: 0.08 = 8% of read length).
 --min [int]		Min observed template length between a pair of end sequences (default: 0).
 --max [int]		Max observed template length between a pair of end sequences (default: 500).
 --threads, -t [int]	Set the number of CPU threads (default: 1).
 --pbat 		Mapping the BS-seq from pbat protocol.
 --unmapped_out 	Report unmapped reads.
 --ambiguous_out 	Random report one of hit of each ambiguous mapped read.
 --mapstats [file]	Output the statistical information of read alignment into file.
 --phred33 		Input read qualities are encoded by Phred33 (default).
 --phred64 		Input read qualities are encoded by Phred64.
 --mp_max [INT]		Maximum mismatch penalty (default: 6).
 --mp_min [INT]		Minimum mismatch penalty (default: 2).
 --np [INT]		Ambiguous character (e.g., N) penalty (default: 1).
 --gap_open [INT]	Gap open penalty (default: 5).
 --gap_extension [INT]	Gap extension penalty (default: 3).
```

