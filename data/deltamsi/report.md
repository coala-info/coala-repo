# deltamsi CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| deltamsi_evaluate | Not completed | Needs a trained DeltaMSI model and labelled tumour BAMs; no public model or test set is available. |
| deltamsi_predict | Not completed | Needs a trained DeltaMSI model, which needs at least 10 labelled tumour BAMs; no public model or test set is available. |
| deltamsi_train | Not completed | Training needs at least 10 tumour BAMs with known MSI status and no small public set exists; with four 1000 Genomes BAMs the command line works but the tool stops with 'not enough samples'. |

## deltamsi_train

### Tool Description
Train a new model

### Metadata
- **Docker Image**: quay.io/biocontainers/deltamsi:1.0.1--pyh7cba7a3_0
- **Homepage**: https://github.com/RADar-AZDelta/DeltaMSI
- **Package**: https://anaconda.org/channels/bioconda/packages/deltamsi/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deltamsi/overview
- **Total Downloads**: 1.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/RADar-AZDelta/DeltaMSI
- **Stars**: N/A
### Original Help Text
```text
usage: DeltaMSI train [-h] [--bed_file BED_FILE] [--ihc_file IHC_FILE]
                      [--bam_file BAM_FILE] [--bam_list_file BAM_LIST_FILE]
                      [--flanking FLANKING]
                      [--minimum_mapping_quality MINIMUM_MAPPING_QUALITY]
                      [--depth DEPTH] [--out_dir OUT_DIR] [-v]

options:
  -h, --help            show this help message and exit
  --bed_file BED_FILE, -bed BED_FILE
                        The bed file of the regions (chr,start,end,name)
  --ihc_file IHC_FILE, -ihc IHC_FILE
                        Text file (tsv or csv) with as first column the
                        sample_name, second ihc value (pMMR/dMMR, 0/1 or
                        MSS/MSI)
  --bam_file BAM_FILE, -bam BAM_FILE
                        The bam files of the samples
  --bam_list_file BAM_LIST_FILE, -bamf BAM_LIST_FILE
                        A file with all complete paths to the bam files of the
                        samples
  --flanking FLANKING, -f FLANKING
                        The number of bases the flanking must use
  --minimum_mapping_quality MINIMUM_MAPPING_QUALITY, -m MINIMUM_MAPPING_QUALITY
                        The minimum mapping quality of the reads
  --depth DEPTH, -d DEPTH
                        The minimum dapth of a region
  --out_dir OUT_DIR, -o OUT_DIR
                        The output directory for the model
  -v, --verbose         verbose
```

## deltamsi_predict

### Tool Description
Predict one or multiple samples

### Metadata
- **Docker Image**: quay.io/biocontainers/deltamsi:1.0.1--pyh7cba7a3_0
- **Homepage**: https://github.com/RADar-AZDelta/DeltaMSI
- **Package**: https://anaconda.org/channels/bioconda/packages/deltamsi/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deltamsi/overview
- **Total Downloads**: 1.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/RADar-AZDelta/DeltaMSI
- **Stars**: N/A
### Original Help Text
```text
usage: DeltaMSI predict [-h] [--model_directory MODEL_DIRECTORY]
                        [--bam_file BAM_FILE] [--bam_list_file BAM_LIST_FILE]
                        [--out_dir OUT_DIR] [-v]

options:
  -h, --help            show this help message and exit
  --model_directory MODEL_DIRECTORY, --model MODEL_DIRECTORY, -m MODEL_DIRECTORY
                        The model to use
  --bam_file BAM_FILE, -bam BAM_FILE
                        The bam files of the samples
  --bam_list_file BAM_LIST_FILE, -bamf BAM_LIST_FILE
                        A file with all complete paths to the bam files of the
                        samples
  --out_dir OUT_DIR, -o OUT_DIR
                        The output directory for the results
  -v, --verbose         verbose
```

## deltamsi_evaluate

### Tool Description
Evaluate the model with known data

### Metadata
- **Docker Image**: quay.io/biocontainers/deltamsi:1.0.1--pyh7cba7a3_0
- **Homepage**: https://github.com/RADar-AZDelta/DeltaMSI
- **Package**: https://anaconda.org/channels/bioconda/packages/deltamsi/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deltamsi/overview
- **Total Downloads**: 1.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/RADar-AZDelta/DeltaMSI
- **Stars**: N/A
### Original Help Text
```text
usage: DeltaMSI evaluate [-h] [--model_directory MODEL_DIRECTORY]
                         [--bam_file BAM_FILE] [--bam_list_file BAM_LIST_FILE]
                         [--out_dir OUT_DIR] [--ihc_file IHC_FILE] [-v]

options:
  -h, --help            show this help message and exit
  --model_directory MODEL_DIRECTORY, --model MODEL_DIRECTORY, -m MODEL_DIRECTORY
                        The model to use
  --bam_file BAM_FILE, -bam BAM_FILE
                        The bam files of the samples
  --bam_list_file BAM_LIST_FILE, -bamf BAM_LIST_FILE
                        A file with all complete paths to the bam files of the
                        samples
  --out_dir OUT_DIR, -o OUT_DIR
                        The output directory for the results
  --ihc_file IHC_FILE, -ihc IHC_FILE
                        Text file (tsv or csv) with as first column the
                        sample_name, second ihc value (pMMR/dMMR, 0/1 or
                        MSS/MSI)
  -v, --verbose         verbose
```

