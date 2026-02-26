# accusnv CWL Generation Report

## accusnv

### Tool Description
Apply filters and CNN to call SNVs for closely related bacterial isolates.

### Metadata
- **Docker Image**: quay.io/biocontainers/accusnv:1.0.0.5--pyhdfd78af_0
- **Homepage**: https://github.com/liaoherui/AccuSNV
- **Package**: https://anaconda.org/channels/bioconda/packages/accusnv/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/accusnv/overview
- **Total Downloads**: 511
- **Last updated**: 2025-08-18
- **GitHub**: https://github.com/liaoherui/AccuSNV
- **Stars**: N/A
### Original Help Text
```text
usage: Local analysis module of AccuSNV [-h] -i INPUT_MAT [-c INPUT_COV]
                                        [-s MIN_COV_SAMP] [-v MIN_COV]
                                        [-e EXCLUDE_SAMP] [-g GENERATE_REP]
                                        [-r REF_GENOME] [-o OUTPUT_DIR]

Apply filters and CNN to call SNVs for closely related bacterial isolates.

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT_MAT, --input_mat INPUT_MAT
                        The input mutation table in npz file
  -c INPUT_COV, --input_cov INPUT_COV
                        The input coverage table in npz file
  -s MIN_COV_SAMP, --min_cov_for_filter_sample MIN_COV_SAMP
                        Before running the CNN model, low-quality samples with
                        more than 45% of positions having zero aligned reads
                        will be filtered out. (default "-s 45") You can adjust
                        this threshold with this parameter; to include all
                        samples, set "-s 100".
  -v MIN_COV, --min_cov_for_filter_pos MIN_COV
                        For the filter module: on individual samples, calls
                        must have at least this many reads on the fwd/rev
                        strands individually. If many samples have low
                        coverage (e.g. <5), then you can set this parameter to
                        smaller value. (e.g. -v 2). Default is 5.
  -e EXCLUDE_SAMP, --excluse_samples EXCLUDE_SAMP
                        The names of the samples you want to exclude (e.g. -e
                        S1,S2,S3). If you specify a number, such as "-e 1000",
                        any sample with more than 1,000 SNVs will be
                        automatically excluded.
  -g GENERATE_REP, --generate_report GENERATE_REP
                        If not generate html report and other related files,
                        set to 0. (default: 1)
  -r REF_GENOME, --rer REF_GENOME
                        The reference genome
  -o OUTPUT_DIR, --output_dir OUTPUT_DIR
                        The output dir
```

