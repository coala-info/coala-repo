# kyber CWL Generation Report

## kyber

### Tool Description
Tool to create a length-accuracy heatmap from a cram or bam file

### Metadata
- **Docker Image**: quay.io/biocontainers/kyber:0.6.0d--ha6fb395_0
- **Homepage**: https://github.com/wdecoster/kyber
- **Package**: https://anaconda.org/channels/bioconda/packages/kyber/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kyber/overview
- **Total Downloads**: 667
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/wdecoster/kyber
- **Stars**: N/A
### Original Help Text
```text
Tool to create a length-accuracy heatmap from a cram or bam file

Usage: kyber [OPTIONS] --input [<INPUT>...]

Options:
  -i, --input [<INPUT>...]       cram or bam file(s), or use `-` to read a file from stdin with e.g. samtools view -h
  -t, --threads <THREADS>        Number of parallel decompression threads to use [default: 4]
  -o, --output <OUTPUT>          Output file name [default: accuracy_heatmap.png]
  -c, --color [<COLOR>...]       Color used for heatmap [possible values: red, green, blue, purple, yellow]
  -b, --background <BACKGROUND>  Color used for background [default: black] [possible values: black, white]
  -p, --phred                    Plot accuracy in phred scale
      --normalize                Normalize the counts in each bin with a log2
      --ubam                     get reads from ubam file
  -h, --help                     Print help
  -V, --version                  Print version
```

