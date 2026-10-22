# svclone CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| svclone_annotate | PASS | synthetic data: simulated example from the SVclone repository (100 deletions at 80 percent purity); clone proportion 0.8 recovered |
| svclone_cluster | PASS | synthetic data: simulated example from the SVclone repository (100 deletions at 80 percent purity); clone proportion 0.8 recovered |
| svclone_count | PASS | synthetic data: simulated example from the SVclone repository (100 deletions at 80 percent purity); clone proportion 0.8 recovered |
| svclone_filter | PASS | synthetic data: simulated example from the SVclone repository (100 deletions at 80 percent purity); clone proportion 0.8 recovered |
| svclone_postassign | PASS | synthetic data: simulated example from the SVclone repository (100 deletions at 80 percent purity); clone proportion 0.8 recovered |

## svclone_annotate

### Tool Description
Extract directions and SV classifications

### Metadata
- **Docker Image**: quay.io/biocontainers/svclone:1.1.4--pyr44hdfd78af_0
- **Homepage**: https://github.com/mcmero/SVclone
- **Package**: https://anaconda.org/channels/bioconda/packages/svclone/overview
- **Validation**: PASS

### Original Help Text
```text
usage: SVclone annotate [-h] [-cfg CFG] -i SVIN -b BAM -s SAMPLE [-o OUT]
                        [--sv_format {vcf,simple,socrates}]
                        [--blacklist BLIST]

options:
  -h, --help            show this help message and exit
  -cfg CFG, --config CFG
                        Config file.
  -i SVIN, --input SVIN
                        Structural variants input file. See README for input
                        format
  -b BAM, --bam BAM     Corresponding indexed BAM file
  -s SAMPLE, --sample SAMPLE
                        Sample name. Output is written to
                        <out_dir>/<sample>_svin.txt.
  -o OUT, --out OUT     Output directory. Sample name by default.
  --sv_format {vcf,simple,socrates}
                        Possible SV input formats: vcf, simple, socrates
  --blacklist BLIST     Takes a file in BED format as an argument. Skip
                        processing of any break-pairs where either SV break-
                        end overlaps an interval specified in the supplied bed
                        file.
```

## svclone_count

### Tool Description
Count reads from called structural variations

### Metadata
- **Docker Image**: quay.io/biocontainers/svclone:1.1.4--pyr44hdfd78af_0
- **Homepage**: https://github.com/mcmero/SVclone
- **Package**: https://anaconda.org/channels/bioconda/packages/svclone/overview
- **Validation**: PASS

### Original Help Text
```text
usage: SVclone count [-h] [-cfg CFG] -i SVIN -b BAM -s SAMPLE [-o OUT]

options:
  -h, --help            show this help message and exit
  -cfg CFG, --config CFG
                        Config file.
  -i SVIN, --input SVIN
                        Structural variants input file. See README for input
                        format
  -b BAM, --bam BAM     Corresponding indexed BAM file
  -s SAMPLE, --sample SAMPLE
                        Sample name. Output is written to
                        <out_dir>/<sample>_svinfo.txt.
  -o OUT, --out OUT     Output directory. Default: sample name.
```

## svclone_filter

### Tool Description
Filter output from process step

### Metadata
- **Docker Image**: quay.io/biocontainers/svclone:1.1.4--pyr44hdfd78af_0
- **Homepage**: https://github.com/mcmero/SVclone
- **Package**: https://anaconda.org/channels/bioconda/packages/svclone/overview
- **Validation**: PASS

### Original Help Text
```text
usage: SVclone filter [-h] [-cfg CFG] -s SAMPLE [-i PROCD_SVS] [-g GERMLINE]
                      [-c CNVS] [--params PARAM_FILE] [--snvs SNVS]
                      [--snv_format {sanger,mutect,mutect_callstats,consensus,multisnv}]
                      [-o OUT] [-p PP_FILE] [--blacklist BLIST]

options:
  -h, --help            show this help message and exit
  -cfg CFG, --config CFG
                        Config file. Default: svclone_config.ini
  -s SAMPLE, --sample SAMPLE
                        Sample name. WARNING: if clustering using mutect SNVs,
                        the sample name must match the sample name in the vcf
                        file.
  -i PROCD_SVS, --input PROCD_SVS
                        Required: Processed structural variation input (comma
                        separated if multiple).
  -g GERMLINE, --germline GERMLINE
                        Germline SVs in output format from process step. If
                        not provided, will assume all SVs are somatic.
  -c CNVS, --cnvs CNVS  Phased copy-number states from Battenberg. If not
                        provided, all SVs assumed copy-neutral.
  --params PARAM_FILE   Read parameters file containing read length, average
                        insert and insert standard deviation (see README). If
                        not supplied, the default search path is
                        <outdir>/<sample>_params.txt. If the file does not
                        exist, a read length of 100 and mean insert length of
                        300 will be allocated.
  --snvs SNVS           SNVs in VCF format to (optionally) compare the
                        clustering with SVs.
  --snv_format {sanger,mutect,mutect_callstats,consensus,multisnv}
                        Supplied SNV VCF is in the following input format:
                        sanger (default), mutect, consensus (PCAWG) or
                        mutect_callstats (non-VCF).
  -o OUT, --out OUT     Output directory. Default: sample name.
  -p PP_FILE, --purity_ploidy PP_FILE
                        Tumour purity ploidy file. See README for format. The
                        default file path is <outdir>/purity_ploidy.txt. If
                        not found, default purity = 1 (100%); default ploidy =
                        2.
  --blacklist BLIST     Takes a file in BED format as an argument. Filter out
                        any break-pairs where either SV break-end overlaps an
                        interval specified in the supplied bed file.
```

## svclone_cluster

### Tool Description
Run clustering step

### Metadata
- **Docker Image**: quay.io/biocontainers/svclone:1.1.4--pyr44hdfd78af_0
- **Homepage**: https://github.com/mcmero/SVclone
- **Package**: https://anaconda.org/channels/bioconda/packages/svclone/overview
- **Validation**: PASS

### Original Help Text
```text
usage: SVclone cluster [-h] [-cfg CFG] [-i SV_FILE] -s SAMPLE [-o OUT]
                       [--params PARAM_FILE] [-p PP_FILE] [--snvs SNV_FILE]
                       [--subsample SUBSAMPLE] [--ss_seeds SS_SEEDS] [--XX]
                       [--XY]

options:
  -h, --help            show this help message and exit
  -cfg CFG, --config CFG
                        Config file.
  -i SV_FILE, --input SV_FILE
                        Filtered structural variant input from filter step.
                        Default loc: <outdir>/<sample>_filtered_svs.tsv
  -s SAMPLE, --sample SAMPLE
                        Sample name.
  -o OUT, --out OUT     Output directory. Default: sample name.
  --params PARAM_FILE   Read parameters file containing read length, average
                        insert and insert standard deviation (see README). If
                        not supplied, the default search path is
                        <outdir>/<sample>_params.txt. If the file does not
                        exist, a read length of 100 and mean insert length of
                        300 will be allocated.
  -p PP_FILE, --purity_ploidy PP_FILE
                        Tumour purity ploidy file. See README for format. The
                        default file path is <outdir>/purity_ploidy.txt. If
                        not found, default purity = 1 (100%); default ploidy =
                        2.
  --snvs SNV_FILE       To specify filtered SNVs output from Filter Step.
                        Default loc: <outdir>/<sample>_filtered_snvs.tsv
  --subsample SUBSAMPLE
                        Subsample N SNVs from total filtered output to use for
                        clustering.
  --ss_seeds SS_SEEDS   Integer seeds to set seeds for replicability of
                        subsampling.
  --XX                  Specify XX genotype. (Overwrites config file, sets
                        male to False.)
  --XY                  Specify XY genotype. (Overwrites config file, sets
                        male to True.)
```

## svclone_postassign

### Tool Description
Run post-assign step

### Metadata
- **Docker Image**: quay.io/biocontainers/svclone:1.1.4--pyr44hdfd78af_0
- **Homepage**: https://github.com/mcmero/SVclone
- **Package**: https://anaconda.org/channels/bioconda/packages/svclone/overview
- **Validation**: PASS

### Original Help Text
```text
usage: SVclone postassign [-h] -s SAMPLE [-o OUT] [-j] [--svs SV_RDATA]
                          [--snvs SNV_RDATA]

options:
  -h, --help            show this help message and exit
  -s SAMPLE, --sample SAMPLE
                        Sample name.
  -o OUT, --out OUT     Output directory. Default:
                        <sample>/ccube_out/post_assign.
  -j, --joint           Indicates that variants will be post-assigned to a
                        joint SV + SNV model
  --svs SV_RDATA        SV RData file from postassign step output.
  --snvs SNV_RDATA      SNV RData file from postassign step output.
```

