# gxf2bed CWL Generation Report

## gxf2bed

### Tool Description
Fastest GTF/GFF-to-BED converter chilling around

### Metadata
- **Docker Image**: quay.io/biocontainers/gxf2bed:0.3.2--ha6fb395_0
- **Homepage**: https://github.com/alejandrogzi/gxf2bed
- **Package**: https://anaconda.org/channels/bioconda/packages/gxf2bed/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gxf2bed/overview
- **Total Downloads**: 8.9K
- **Last updated**: 2026-01-28
- **GitHub**: https://github.com/alejandrogzi/gxf2bed
- **Stars**: N/A
### Original Help Text
```text
Fastest GTF/GFF-to-BED converter chilling around

Usage: gxf2bed [OPTIONS] --input <GXF> --output <BED>

Options:
  -i, --input <GXF>
          The fastest G{T,F}F-to-BED converter chilling around the world!
          
          This program converts GTF/GFF3 files to BED format blazingly fast. Start by providing the path to the GTF/GFF3 file with -i/--input file.gtf or -i/--input file.gff3.

  -o, --output <BED>
          Path to output BED file

  -T, --threads <THREADS>
          Number of threads
          
          [default: 20]

  -F, --parent-feature <PARENT>
          Parent feature

  -f, --child-features <CHILDS>...
          Child features

  -A, --parent-attribute <FEATURE>
          Feature to extract

  -a, --child-attribute <CHILD>
          Child feature to extract

  -t, --type <BED_TYPE>
          BED type format
          
          [default: 12]

  -d, --additional-fields <ADDITIONAL>...
          BED additional fields

  -c, --chunks <CHUNKS>
          Chunk size for parallel processing
          
          [default: 15000]

  -h, --help
          Print help (see a summary with '-h')

  -V, --version
          Print version
```

