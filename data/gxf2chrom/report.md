# gxf2chrom CWL Generation Report

## gxf2chrom

### Tool Description
Everythin in .chrom from GTF/GFF

### Metadata
- **Docker Image**: quay.io/biocontainers/gxf2chrom:0.1.0--h9948957_1
- **Homepage**: https://github.com/alejandrogzi/gxf2chrom
- **Package**: https://anaconda.org/channels/bioconda/packages/gxf2chrom/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gxf2chrom/overview
- **Total Downloads**: 1.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/alejandrogzi/gxf2chrom
- **Stars**: N/A
### Original Help Text
```text
2026-02-25T22:44:33.686Z INFO  [gxf2chrom] gxf2chrom v0.1.0
2026-02-25T22:44:33.686Z WARN  [gxf2chrom] For any bug/issue contact: https://github.com/alejandrogzi/gxf2chrom
Everythin in .chrom from GTF/GFF

Usage: gxf2chrom [OPTIONS] --input <GXF> --output <CHROM>

Options:
  -i, --input <GXF>
          ...
          
          This program converts GTF/GFF3 files to .chrom format. Start by providing the path to the GTF/GFF3 file with -i/--input file.gtf or -i/--input file.gff3.

  -o, --output <CHROM>
          Path to output .chrom file

  -t, --threads <THREADS>
          Number of threads
          
          [default: 20]

  -f, --feature <FEATURE>
          Feature to extract
          
          [default: protein_id]

  -h, --help
          Print help (see a summary with '-h')

  -V, --version
          Print version
```

