# mudskipper CWL Generation Report

## mudskipper_index

### Tool Description
Parse the GTF and build an index to make later runs faster.

### Metadata
- **Docker Image**: quay.io/biocontainers/mudskipper:0.1.0--h7d875b9_0
- **Homepage**: https://github.com/OceanGenomics/mudskipper
- **Package**: https://anaconda.org/channels/bioconda/packages/mudskipper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mudskipper/overview
- **Total Downloads**: 2.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/OceanGenomics/mudskipper
- **Stars**: N/A
### Original Help Text
```text
mudskipper-index 0.1.0
Parse the GTF and build an index to make later runs faster.

USAGE:
    mudskipper index --dir-index <DIR> --gtf <FILE>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
    -g, --gtf <FILE>         Input GTF/GFF file
    -d, --dir-index <DIR>    Output index directory name
```


## mudskipper_bulk

### Tool Description
Convert alignment of bulk RNA-Seq reads against genome to alignment against transcriptome.

### Metadata
- **Docker Image**: quay.io/biocontainers/mudskipper:0.1.0--h7d875b9_0
- **Homepage**: https://github.com/OceanGenomics/mudskipper
- **Package**: https://anaconda.org/channels/bioconda/packages/mudskipper/overview
- **Validation**: PASS

### Original Help Text
```text
mudskipper-bulk 0.1.0
Convert alignment of bulk RNA-Seq reads against genome to alignment against transcriptome.

USAGE:
    mudskipper bulk [FLAGS] --alignment <FILE> --max-softclip <INT> --out <FILE> --threads <INT> <--gtf <FILE>|--index <DIR>>

FLAGS:
    -r, --rad        Output in RAD format instead of BAM
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
    -a, --alignment <FILE>      Input SAM/BAM file
    -g, --gtf <FILE>            Input GTF/GFF file
    -i, --index <DIR>           Index directory containing parsed GTF files
    -o, --out <FILE>            Output file name
    -s, --max-softclip <INT>    Max allowed softclip length [default: 50]
    -t, --threads <INT>         Number of threads for processing bam files [default: 1]
```


## mudskipper_sc

### Tool Description
Convert alignment of single-cell RNA-Seq reads against genome to alignment against transcriptome.

### Metadata
- **Docker Image**: quay.io/biocontainers/mudskipper:0.1.0--h7d875b9_0
- **Homepage**: https://github.com/OceanGenomics/mudskipper
- **Package**: https://anaconda.org/channels/bioconda/packages/mudskipper/overview
- **Validation**: PASS

### Original Help Text
```text
mudskipper-sc 0.1.0
Convert alignment of single-cell RNA-Seq reads against genome to alignment against transcriptome.

USAGE:
    mudskipper sc [FLAGS] --alignment <FILE> --max-softclip <INT> --out <FILE/DIR> --rad-mapped <FILE> --rad-unmapped <FILE> --threads <INT> <--gtf <FILE>|--index <DIR>>

FLAGS:
    -r, --rad               Output in RAD format instead of BAM
    -c, --corrected-tags    Output error-corrected cell barcode and UMI
    -h, --help              Prints help information
    -V, --version           Prints version information

OPTIONS:
    -a, --alignment <FILE>       Input SAM/BAM file
    -g, --gtf <FILE>             Input GTF/GFF file
    -i, --index <DIR>            Index directory containing parsed GTF files
    -o, --out <FILE/DIR>         Output file name (or directory name when --rad is passed)
    -s, --max-softclip <INT>     Max allowed softclip length [default: 50]
    -t, --threads <INT>          Number of threads for processing bam files [default: 1]
    -m, --rad-mapped <FILE>      Name of output rad file; Only used with --rad [default: map.rad]
    -u, --rad-unmapped <FILE>    Name of file containing the number of unmapped reads for each barcode; Only used with
                                 --rad [default: unmapped_bc_count.bin]
```

