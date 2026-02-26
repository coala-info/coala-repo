# insurveyor CWL Generation Report

## insurveyor_insurveyor.py

### Tool Description
INSurVeyor, an insertion caller [1.1.2].

### Metadata
- **Docker Image**: quay.io/biocontainers/insurveyor:1.1.3--h077b44d_2
- **Homepage**: https://github.com/kensung-lab/INSurVeyor
- **Package**: https://anaconda.org/channels/bioconda/packages/insurveyor/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/insurveyor/overview
- **Total Downloads**: 7.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/kensung-lab/INSurVeyor
- **Stars**: N/A
### Original Help Text
```text
usage: insurveyor.py [-h] [--threads THREADS] [--seed SEED]
                     [--max-clipped-pos-dist MAX_CLIPPED_POS_DIST]
                     [--min-insertion-size MIN_INSERTION_SIZE]
                     [--max-trans-size MAX_TRANS_SIZE]
                     [--min-stable-mapq MIN_STABLE_MAPQ]
                     [--min-clip-len MIN_CLIP_LEN]
                     [--max-seq-error MAX_SEQ_ERROR]
                     [--sampling-regions SAMPLING_REGIONS]
                     [--per-contig-stats] [--samplename SAMPLENAME]
                     [--sample-clipped-pairs] [--use-csi] [--version]
                     bam_file workdir reference

INSurVeyor, an insertion caller [1.1.2].

positional arguments:
  bam_file              Input bam file.
  workdir               Working directory for Surveyor to use.
  reference             Reference genome in FASTA format.

options:
  -h, --help            show this help message and exit
  --threads THREADS     Number of threads to be used.
  --seed SEED           Seed for random sampling of genomic positions.
  --max-clipped-pos-dist MAX_CLIPPED_POS_DIST
                        Max distance (in bp) for two clips to be considered
                        representing the same breakpoint.
  --min-insertion-size MIN_INSERTION_SIZE
                        Minimum size of the insertion to be called.Smaller
                        insertions will be reported anyway but markedas SMALL
                        in the FILTER field.
  --max-trans-size MAX_TRANS_SIZE
                        Maximum size of the transpositions which INSurVeyor
                        will predict.
  --min-stable-mapq MIN_STABLE_MAPQ
                        Minimum MAPQ for a stable read.
  --min-clip-len MIN_CLIP_LEN
                        Minimum clip len to consider.
  --max-seq-error MAX_SEQ_ERROR
                        Max sequencing error admissible on the platform used.
  --sampling-regions SAMPLING_REGIONS
                        File in BED format containing a list of regions to be
                        used to estimatestatistics such as depth.
  --per-contig-stats    Statistics are computed separately for each contig
                        (experimental).
  --samplename SAMPLENAME
                        Name of the sample to be used in the VCF output.If not
                        provided, the basename of the bam/cram file will be
                        used,up until the first '.'
  --sample-clipped-pairs
                        When estimating the insert size distribution by
                        sampling pairs, do not discard pairs where one or both
                        of the reads are clipped.
  --use-csi             Use CSI indices instead of BAI for intermediate bam
                        files.
  --version             Print version number.
```

