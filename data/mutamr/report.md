# mutamr CWL Generation Report

## mutamr_wgs

### Tool Description
Run mutamr for whole genome sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/mutamr:0.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/MDU-PHL/mutamr
- **Package**: https://anaconda.org/channels/bioconda/packages/mutamr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mutamr/overview
- **Total Downloads**: 855
- **Last updated**: 2025-09-15
- **GitHub**: https://github.com/MDU-PHL/mutamr
- **Stars**: N/A
### Original Help Text
```text
usage: mutamr wgs [-h] [--read1 READ1] [--read2 READ2] [--seq_id SEQ_ID]
                  [--reference REFERENCE]
                  [--annotation_species ANNOTATION_SPECIES]
                  [--min_depth MIN_DEPTH] [--min_frac MIN_FRAC]
                  [--threads THREADS] [--ram RAM] [--tmp TMP] [--mtb] [--keep]
                  [--force]

options:
  -h, --help            show this help message and exit
  --read1, -1 READ1     path to read1 (default: )
  --read2, -2 READ2     path to read2 (default: )
  --seq_id, -s SEQ_ID   Sequence name (default: mutamr)
  --reference, -r REFERENCE
                        Reference to use for alignment. Not required if using
                        --mtb (default: )
  --annotation_species, -a ANNOTATION_SPECIES
                        Name of species for annotation - needs to be a snpEff
                        annotation config. Not required if using --mtb
                        (default: )
  --min_depth, -md MIN_DEPTH
                        Minimum depth to call a variant (default: 20)
  --min_frac, -mf MIN_FRAC
                        Minimum proportion to call a variant (0-1) (default:
                        0.1)
  --threads, -t THREADS
                        Threads to use for generation of vcf file. (default:
                        8)
  --ram RAM             Max ram to use (default: 8)
  --tmp TMP             temp directory to use (default: /tmp)
  --mtb                 Run for Mtb (default: False)
  --keep, -k            Keep accessory files for further use. (default: False)
  --force, -f           Force override an existing mutamr run. (default:
                        False)
```

