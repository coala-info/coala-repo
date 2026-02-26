# fibertools-rs CWL Generation Report

## fibertools-rs_ft

### Tool Description
Fiber-seq toolkit in rust

### Metadata
- **Docker Image**: quay.io/biocontainers/fibertools-rs:0.8.2--h3b373d1_0
- **Homepage**: https://github.com/mrvollger/fibertools-rs
- **Package**: https://anaconda.org/channels/bioconda/packages/fibertools-rs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fibertools-rs/overview
- **Total Downloads**: 53.4K
- **Last updated**: 2026-02-03
- **GitHub**: https://github.com/mrvollger/fibertools-rs
- **Stars**: N/A
### Original Help Text
```text
Fiber-seq toolkit in rust

Usage: ft [OPTIONS] <COMMAND>

Commands:
  predict-m6a       Predict m6A positions using HiFi kinetics data and encode the results in the MM
                    and ML bam tags. Also adds nucleosome (nl, ns) and MTase sensitive patches (al,
                    as) [aliases: m6A, m6a]
  add-nucleosomes   Add nucleosomes to a bam file with m6a predictions
  fire              Add FIREs (Fiber-seq Inferred Regulatory Elements) to a bam file with m6a
                    predictions
  extract           Extract fiberseq data into plain text files [aliases: ex, e]
  center            This command centers fiberseq data around given reference positions. This is
                    useful for making aggregate m6A and CpG observations, as well as visualization
                    of SVs [aliases: c, ct]
  footprint         Infer footprints from fiberseq data
  qc                Collect QC metrics from a fiberseq bam file
  track-decorators  Make decorated bed files for fiberseq data
  pileup            Make a pileup track of Fiber-seq features from a FIRE bam
  clear-kinetics    Remove HiFi kinetics tags from the input bam file
  strip-basemods    Strip out select base modifications
  ddda-to-m6a       Convert a DddA BAM file to pseudo m6A BAM file
  fiber-hmm         Apply FiberHMM to a bam file
  validate          Validate a Fiber-seq BAM file for m6A, nucleosome, and optionally FIRE calls
  pg-inject         Create a mock BAM file from a reference FASTA with perfectly aligned sequences
  pg-lift           Lift annotations through a pangenome graph from source to target coordinates
  pg-pansn          Add or strip panSN-spec prefixes from BAM contig names
  help              Print this message or the help of the given subcommand(s)

Options:
  -h, --help     Print help
  -V, --version  Print version

Global-Options:
  -t, --threads <THREADS>  Threads [default: 8]

Debug-Options:
  -v, --verbose...  Logging level [-v: Info, -vv: Debug, -vvv: Trace]
      --quiet       Turn off all logging
```

