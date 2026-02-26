# bamtocov CWL Generation Report

## bamtocov

### Tool Description
Calculate coverage from BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/bamtocov:2.8.0--h1104d80_0
- **Homepage**: https://github.com/telatin/bamtocov
- **Package**: https://anaconda.org/channels/bioconda/packages/bamtocov/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamtocov/overview
- **Total Downloads**: 32.8K
- **Last updated**: 2025-10-27
- **GitHub**: https://github.com/telatin/bamtocov
- **Stars**: N/A
### Original Help Text
```text
BamToCov 2.8.0

  Usage: bamtocov [options] [<BAM>]...

Arguments:                                                                                                                                                 
  <BAM>         the alignment file for which to calculate depth (default: STDIN)

Core options:
  -p, --physical               Calculate physical coverage
  -s, --stranded               Report coverage separate by strand
  -q, --quantize <breaks>      Comma separated list of breaks for quantized output
  -w, --wig <SPAN>             Output in WIG format (using fixed <SPAN>), 0 will print in BED format [default: 0]
  --op <func>                  How to summarize coverage for each WIG span (mean/min/max) [default: max]
  -o, --report <TXT>           Output coverage report
  --skip-output                Do not output per-base coverage
  --report-low <min>           Report coverage for bases with coverage < min [default: 0]

Target files:
  -r, --regions <bed>          Target file in BED or GFF3/GTF format (detected with the extension)
  -t, --gff-type <feat>        GFF feature type to parse [default: CDS]
  -i, --gff-id <ID>            GFF identifier [default: ID]
  --gff-separator <sep>        GFF attributes separator [default: ;]
  --gff                        Force GFF input (otherwise assumed by extension .gff)
  --gtf                        Force GTF input (otherwise assumed by extension .gtf)

BAM reading options:
  -T, --threads <threads>      BAM decompression threads [default: 0]
  -F, --flag <FLAG>            Exclude reads with any of the bits in FLAG set [default: 1796]
  -Q, --mapq <mapq>            Mapping quality threshold [default: 0]

Other options:
  --extendReads INT            [Experimental] artificially extend reads by INT bases [default: 0]
  --debug                      Enable diagnostics
  -h, --help                   Show help
```

