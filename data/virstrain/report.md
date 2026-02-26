# virstrain CWL Generation Report

## virstrain

### Tool Description
An RNA virus strain-level identification tool for short reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/virstrain:1.17--pyhdfd78af_1
- **Homepage**: https://github.com/liaoherui/VirStrain
- **Package**: https://anaconda.org/channels/bioconda/packages/virstrain/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/virstrain/overview
- **Total Downloads**: 13.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/liaoherui/VirStrain
- **Stars**: N/A
### Original Help Text
```text
usage: VirStrain.py [-h] -i INPUT_READS [-p INPUT_READS2] -d DB_DIR
                    [-o OUT_DIR] [-c SF_CUTOFF] [-s RK_SITE] [-f CLOSE_FIG]
                    [-m [HM_VIRUS]]

VirStrain - An RNA virus strain-level identification tool for short reads.

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT_READS, --input_reads INPUT_READS
                        Input fastq data --- Required
  -p INPUT_READS2, --input_reads2 INPUT_READS2
                        Input fastq data for PE reads.
  -d DB_DIR, --database_dir DB_DIR
                        Database dir --- Required
  -o OUT_DIR, --output_dir OUT_DIR
                        Output dir (default: current dir/VirStrain_Out)
  -c SF_CUTOFF, --site_filter_cutoff SF_CUTOFF
                        The cutoff of filtering one site (default: 0.05)
  -s RK_SITE, --rank_by_sites RK_SITE
                        If set to 1, then VirStrain will sort the most
                        possible strain by matches to the sites. (default: 0)
  -f CLOSE_FIG, --turn_off_figures CLOSE_FIG
                        If set to 1, then VirStrain will not generate figures.
                        (default: 0)
  -m [HM_VIRUS], --high_mutation_virus [HM_VIRUS]
                        If the virus has high mutation rate, use this option.
                        (default: Not use)
```

