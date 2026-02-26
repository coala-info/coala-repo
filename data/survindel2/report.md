# survindel2 CWL Generation Report

## survindel2_survindel2.py

### Tool Description
SurVIndel2, a CNV caller.

### Metadata
- **Docker Image**: quay.io/biocontainers/survindel2:1.1.4--h503566f_0
- **Homepage**: https://github.com/kensung-lab/SurVIndel2
- **Package**: https://anaconda.org/channels/bioconda/packages/survindel2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/survindel2/overview
- **Total Downloads**: 1.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/kensung-lab/SurVIndel2
- **Stars**: N/A
### Original Help Text
```text
usage: survindel2.py [-h] [--threads THREADS] [--seed SEED]
                     [--min_sv_size MIN_SV_SIZE] [--min_clip_len MIN_CLIP_LEN]
                     [--max_seq_error MAX_SEQ_ERROR]
                     [--max_clipped_pos_dist MAX_CLIPPED_POS_DIST]
                     [--min_size_for_depth_filtering MIN_SIZE_FOR_DEPTH_FILTERING]
                     [--samplename SAMPLENAME]
                     [--sampling-regions SAMPLING_REGIONS] [--log]
                     [--match_score MATCH_SCORE] [--min-diff-hsr MIN_DIFF_HSR]
                     [--version]
                     bam_file workdir reference

SurVIndel2, a CNV caller.

positional arguments:
  bam_file              Input bam file.
  workdir               Working directory for Surveyor to use.
  reference             Reference genome in FASTA format.

options:
  -h, --help            show this help message and exit
  --threads THREADS     Number of threads to be used.
  --seed SEED           Seed for random sampling of genomic positions.
  --min_sv_size MIN_SV_SIZE
                        Min SV size.
  --min_clip_len MIN_CLIP_LEN
                        Min length for a clip to be used.
  --max_seq_error MAX_SEQ_ERROR
                        Max sequencing error admissible on the platform used.
  --max_clipped_pos_dist MAX_CLIPPED_POS_DIST
                        Max clipped position distance.
  --min_size_for_depth_filtering MIN_SIZE_FOR_DEPTH_FILTERING
                        Minimum size for depth filtering.
  --samplename SAMPLENAME
                        Name of the sample to be used in the VCF output.If not
                        provided, the basename of the bam/cram file will be
                        used,up until the first '.'
  --sampling-regions SAMPLING_REGIONS
                        File in BED format containing a list of regions to be
                        used to estimatestatistics such as depth.
  --log                 Activate in-depth logging (can be very large and
                        cryptic).
  --match_score MATCH_SCORE
                        Match score used by the aligner that produced tha
                        BAM/CRAM file (TODO: auto-determine).
  --min-diff-hsr MIN_DIFF_HSR
                        Minimum number of differences with the reference
                        (considered as number of insertions, deletions and
                        mismatches) for a read to be considered a hidden split
                        read.
  --version             Print version number.
```

