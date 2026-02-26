# hiphase CWL Generation Report

## hiphase

### Tool Description
A tool for jointly phasing small, structural, and tandem repeat variants for PacBio sequencing data

### Metadata
- **Docker Image**: quay.io/biocontainers/hiphase:1.6.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/HiPhase
- **Package**: https://anaconda.org/channels/bioconda/packages/hiphase/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hiphase/overview
- **Total Downloads**: 15.2K
- **Last updated**: 2026-01-20
- **GitHub**: https://github.com/PacificBiosciences/HiPhase
- **Stars**: N/A
### Original Help Text
```text
A tool for jointly phasing small, structural, and tandem repeat variants for PacBio sequencing data

Usage: hiphase [OPTIONS] --bam <BAM> --vcf <VCF> --output-vcf <VCF> --reference <FASTA>

Options:
      --preset <PRESET>
          Use a preset for the settings

          Possible values:
          - rna: Configure the setting for RNA-seq data

  -t, --threads <THREADS>
          Number of threads to use for phasing
          
          [default: 1]

  -v, --verbose...
          Enable verbose output

  -h, --help
          Print help information (use `-h` for a summary)

  -V, --version
          Print version information

Input/Output:
  -b, --bam <BAM>
          Input alignment file in BAM format

  -p, --output-bam <BAM>
          Output haplotagged alignment file in BAM format

  -c, --vcf <VCF>
          Input variant file in VCF format

  -o, --output-vcf <VCF>
          Output phased variant file in VCF format

  -r, --reference <FASTA>
          Reference FASTA file

  -s, --sample-name <SAMPLE>
          Sample name to phase within the VCF (default: first sample)

      --ignore-read-groups
          Ignore BAM file read group IDs

      --summary-file <FILE>
          Output summary phasing statistics file (optional, csv/tsv)

      --stats-file <FILE>
          Output algorithmic statistics file (optional, csv/tsv)

      --blocks-file <FILE>
          Output blocks file (optional, csv/tsv)

      --haplotag-file <FILE>
          Output haplotag file (optional, csv/tsv)

      --io-threads <THREADS>
          Number of threads for BAM I/O (default: minimum of `--threads` or `4`)

      --csi-index
          Output .csi indices instead of .tbi/.bai

Variant Filtering:
      --min-vcf-qual <GQ>
          Sets a minimum genotype quality (GQ) value to include a variant in the phasing
          
          [default: 0]

Mapping Filtering:
      --min-mapq <MAPQ>
          Sets a minimum MAPQ to include a read in the phasing
          
          [default: 5]

      --min-matched-alleles <COUNT>
          Sets a minimum number of matched variants required for a read to get included in the scoring
          
          [default: 2]

Phase Block Generation:
      --min-spanning-reads <READS>
          Sets a minimum number of reads to span two adjacent variants into a putative phase block
          
          [default: 1]

      --no-supplemental-joins
          Disables the use of supplemental mappings to join phase blocks

      --phase-singletons
          Enables the phasing and haplotagging of singleton phase blocks

      --min-connecting-reads <READS>
          Sets the minimum number of connecting reads required to keep two variants in the same block
          
          [default: 1]

Allele Assignment:
      --max-reference-buffer <LENGTH>
          Sets a maximum reference buffer for local realignment
          
          [default: 15]

      --disable-global-realignment
          Disables global realignment

      --global-realignment-max-ed <DISTANCE>
          The maximum allowed edit distance for global realignment before fallback to local realignment
          
          [default: 500]

      --global-pruning-distance <LENGTH>
          Sets a pruning threshold on global realignment, set to 0 to disable pruning
          
          [default: 500]

      --max-global-failure-ratio <FRAC>
          Sets a maximum global realignment failure ratio before disabling global realignment for entire block
          
          [default: 0.5]

      --global-failure-count <COUNT>
          Sets a minimum number of global realignment failures before --max-global-failure-ratio is active
          
          [default: 50]

Phasing:
      --optimize-variant-order
          Optimize the variant order prior to phasing

      --phase-min-queue-size <SIZE>
          Sets the minimum queue size for the phasing algorithm
          
          [default: 1000]

      --phase-queue-increment <SIZE>
          Sets the queue size increment per variant in a phase block
          
          [default: 3]

Copyright (C) 2004-2026     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## Metadata
- **Skill**: generated
