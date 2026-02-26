# enano CWL Generation Report

## enano

### Tool Description
Compresses and decompresses FASTQ files using methods from FQZComp and a range coder derived from Eugene Shelwien.

### Metadata
- **Docker Image**: quay.io/biocontainers/enano:1.0--h077b44d_7
- **Homepage**: https://github.com/guilledufort/EnanoFASTQ
- **Package**: https://anaconda.org/channels/bioconda/packages/enano/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/enano/overview
- **Total Downloads**: 5.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/guilledufort/EnanoFASTQ
- **Stars**: N/A
### Original Help Text
```text
Enano v1.0 Author Guillermo Dufort y Alvarez, 2019-2020
The methods used for encoding the reads identifiers, and to model frequency counters, 
are the ones proposed by James Bonefield in FQZComp, with some modifications.
The range coder is derived from Eugene Shelwien.

To compress:
  enano [options] [input_file [output_file]]

    -c             To use MAX COMPRESION MODE. Default is FAST MODE.

    -k <length>    Base sequence context length. Default is 7 (max 13).

    -l <lenght>    Length of the DNA sequence context. Default is 6.

    -t <num>       Maximum number of threads allowed to use by the compressor. Default is 8.

To decompress:
   enano -d [options] foo.enano foo.fastq
    -t <num>       Maximum number of threads allowed to use by the decompressor. Default is 8.
```

