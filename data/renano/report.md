# renano CWL Generation Report

## renano

### Tool Description
Renano v1.0 Author Guillermo Dufort y Alvarez, 2020-2021

### Metadata
- **Docker Image**: quay.io/biocontainers/renano:1.3--h077b44d_4
- **Homepage**: https://github.com/guilledufort/RENANO
- **Package**: https://anaconda.org/channels/bioconda/packages/renano/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/renano/overview
- **Total Downloads**: 10.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/guilledufort/RENANO
- **Stars**: N/A
### Original Help Text
```text
ERROR: Either input or output files are missing.
Renano v1.0 Author Guillermo Dufort y Alvarez, 2020-2021

COMPRESSION: 
> Without reference:
	renano [options] [input_file [output_file]]

> With reference:
	renano [options] -r [ref_file [paf_file]] [input_file [output_file]]

> With reference and making decompression independent of the reference:
	renano [options] -s [ref_file [paf_file]] [input_file [output_file]]

COMPRESSION OPTIONS: 
	-k <length>    Base call sequence context length. Default is 7 (max 13).

	-l <lenght>    Length of the DNA neighborhood sequence. Default is 6.

	-t <num>       Maximum number of threads allowed to use by the compressor. Default is 8.

DECOMPRESSION: 
> Without reference:
	renano -d [options] foo.enano foo.fastq

> With reference:
	renano -d [options] -r [ref_file] foo.enano foo.fastq

DECOMPRESSION OPTIONS: 
	-t <num>       Maximum number of threads allowed to use by the decompressor. Default is 8.

CREDITS :
The methods used for encoding the reads identifiers, and to model frequency counters, 
are the ones proposed by James Bonefield in FQZComp, with some modifications.
The range coder is derived from Eugene Shelwien.
The kseq library used to parse FASTA files is authored by Heng Li.
```

