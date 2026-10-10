# mimsi CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| mimsi_analyze | Failed | image problem: numpy 1.24 rejects the ragged instance array in save_bag (inhomogeneous shape error); default model file is also missing |
| mimsi_create_data | Failed | image problem: numpy 1.24 rejects the ragged instance array in save_bag (inhomogeneous shape error); --cores also crashes |
| mimsi_evaluate_sample | Failed | tool bug: default tsv summary crashes (msi_status missing lci); only npy output works, tested on vectors built from real BAMs |
| mimsi_mi_msi_train_test | PASS | synthetic data: vectors from real BAMs copied with made-up labels, 1 epoch |
| mimsi_visualize_instance | PASS | synthetic data: vectors built from real BAMs with the tool's own convert_bam |

## mimsi_evaluate_sample

### Tool Description
MiMSI Sample(s) Evalution Utility

### Metadata
- **Docker Image**: quay.io/biocontainers/mimsi:0.4.5--pyhdfd78af_0
- **Homepage**: https://github.com/mskcc/mimsi
- **Package**: https://anaconda.org/channels/bioconda/packages/mimsi/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mimsi/overview
- **Total Downloads**: 6.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mskcc/mimsi
- **Stars**: N/A
### Original Help Text
```text
usage: evaluate_sample [-h] [--version] [--no-cuda] [--model MODEL]
                       [--vector-location VECTOR_LOCATION] [--save]
                       [--save-format {tsv,npy,both}]
                       [--save-location SAVE_LOCATION] [--name NAME]
                       [--seed S] [--coverage COVERAGE]
                       [--confidence-interval CONFIDENCE_INTERVAL]
                       [--use-attention]

MiMSI Sample(s) Evalution Utility

optional arguments:
  -h, --help            show this help message and exit
  --version             Display current version of MiMSI
  --no-cuda             Disables CUDA for use off GPU, if this is not
                        specified the utility will check availability of
                        torch.cuda
  --model MODEL         name of the saved model weights to load
  --vector-location VECTOR_LOCATION
                        directory containing the generated vectors to evaluate
  --save                save the results of the evaluation to a numpy array or
                        a tsv text file
  --save-format {tsv,npy,both}
                        save the results of the evaluation to a numpy array or
                        as summary in a tsv text file or both
  --save-location SAVE_LOCATION
                        The location on the filesystem to save the final
                        results (default:
                        Current_working_directory/mimsi_results/).
  --name NAME           name of the run, this will be the filename for any
                        saved results in tsv format with more than one
                        samples.
  --seed S              Random Seed (default: 2)
  --coverage COVERAGE   Required coverage for both the tumor and the normal.
                        Any coverage in excess of this limit will be randomly
                        downsampled
  --confidence-interval CONFIDENCE_INTERVAL
                        Confidence interval for the estimated MSI Score
                        reported in the tsv output file (default: 0.95)
  --use-attention       Use attention pooling rather than average pooling to
                        aggregate sample embeddings (default: False)
```


## mimsi_analyze

### Tool Description
MiMSI Analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/mimsi:0.4.5--pyhdfd78af_0
- **Homepage**: https://github.com/mskcc/mimsi
- **Package**: https://anaconda.org/channels/bioconda/packages/mimsi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: analyze [-h] [--version] [--no-cuda] [--model MODEL] [--save]
               [--save-format {tsv,npy,both}] [--seed S]
               [--microsatellites-list MICROSATELLITES_LIST]
               [--save-location SAVE_LOCATION] [--cores CORES]
               [--coverage COVERAGE]
               [--confidence-interval CONFIDENCE_INTERVAL] [--use-attention]
               [--tumor-bam TUMOR_BAM] [--normal-bam NORMAL_BAM]
               [--case-id CASE_ID] [--norm-case-id NORM_CASE_ID]
               [--case-list CASE_LIST] [--name NAME]

MiMSI Analysis

optional arguments:
  -h, --help            show this help message and exit
  --version             Display current version of MiMSI
  --no-cuda             Disables CUDA for use off GPU, if this is not
                        specified the utility will check availability of
                        torch.cuda
  --model MODEL         name of the saved model weights to load (default:
                        model/mimsi_mskcc_impact_200.model)
  --save                save the results of the evaluation to a numpy array or
                        a tsv text file
  --save-format {tsv,npy,both}
                        save the results of the evaluation to a numpy array or
                        as summary in a tsv text file or both
  --seed S              Random Seed (default: 2)
  --microsatellites-list MICROSATELLITES_LIST
                        The list of microsatellites to check in the
                        tumor/normal pair (default:
                        utils/microsatellites.list)
  --save-location SAVE_LOCATION
                        The location on the filesystem to save the converted
                        vectors and final results (default:
                        Current_working_directory/mimsi_results/). WARNING:
                        Exisitng files in this directory in the formats
                        *_locations.npy and *_data.npy will be deleted!
  --cores CORES         Number of cores to utilize in parallel (default: 16)
  --coverage COVERAGE   Required coverage for both the tumor and the normal.
                        Any coverage in excess of this limit will be randomly
                        downsampled
  --confidence-interval CONFIDENCE_INTERVAL
                        Confidence interval for the estimated MSI Score
                        reported in the tsv output file (default: 0.95)
  --use-attention       Use attention pooling rather than average pooling to
                        aggregate sample embeddings (default: False)

Single Sample Mode:
  --tumor-bam TUMOR_BAM
                        Tumor bam file for conversion
  --normal-bam NORMAL_BAM
                        Matched normal bam file for conversion
  --case-id CASE_ID     Unique identifier for the single sample/case
                        submitted. This will be the filename for any saved
                        results (default: TestCase)
  --norm-case-id NORM_CASE_ID
                        Normal case name (default: None)

Batch Mode:
  --case-list CASE_LIST
                        Case List for generating sample vectors in bulk, if
                        specified all other input file args will be ignored
  --name NAME           name of the run submitted using --case-list, this will
                        be the filename for any saved results in the tsv
                        format (default: BATCH)
```


## mimsi_create_data

### Tool Description
MiMSI Vector Generation Utility

### Metadata
- **Docker Image**: quay.io/biocontainers/mimsi:0.4.5--pyhdfd78af_0
- **Homepage**: https://github.com/mskcc/mimsi
- **Package**: https://anaconda.org/channels/bioconda/packages/mimsi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: create_data [-h] [--version] [--tumor-bam TUMOR_BAM]
                   [--normal-bam NORMAL_BAM] [--case-id CASE_ID]
                   [--norm-case-id NORM_CASE_ID] [--case-list CASE_LIST]
                   [--name NAME] [--microsatellites-list MICROSATELLITES_LIST]
                   [--save-location SAVE_LOCATION] [--coverage COVERAGE]
                   [--cores CORES]

MiMSI Vector Generation Utility

optional arguments:
  -h, --help            show this help message and exit
  --version             Display current version of MiMSI
  --microsatellites-list MICROSATELLITES_LIST
                        The list of microsatellites to check in the
                        tumor/normal pair (default:
                        tests/microsatellites_impact_only.list)
  --save-location SAVE_LOCATION
                        The location on the filesystem to save the converted
                        vectors (default:
                        Current_working_directory/generated_samples/).
                        WARNING: Existing files in this directory in the
                        formats *_locations.npy and *_data.npy will be
                        deleted!
  --coverage COVERAGE   Required coverage for both the tumor and the normal.
                        Any coverage in excess of this limit will be randomly
                        downsampled
  --cores CORES         Number of cores to utilize in parallel

Single Sample Mode:
  --tumor-bam TUMOR_BAM
                        Tumor bam file for conversion
  --normal-bam NORMAL_BAM
                        Matched normal bam file for conversion
  --case-id CASE_ID     Unique identifier for the single sample/case
                        submitted. This will be the filename for any saved
                        results (default: TestCase)
  --norm-case-id NORM_CASE_ID
                        Normal case name (default: None)

Batch Mode:
  --case-list CASE_LIST
                        Case List for generating sample vectors in bulk, if
                        specified all other input file args will be ignored
  --name NAME           name of the run submitted using --case-list, this will
                        be the filename for any saved results in the tsv
                        format (default: BATCH)
```

## mimsi_mi_msi_train_test

### Tool Description
MiMSI - A Multiple Instance Learning Model for detecting microsatellite instability in NGS data

### Metadata
- **Docker Image**: quay.io/biocontainers/mimsi:0.4.5--pyhdfd78af_0
- **Homepage**: https://github.com/mskcc/mimsi
- **Package**: https://anaconda.org/channels/bioconda/packages/mimsi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mi_msi_train_test [-h] [--version] [--epochs N] [--lr LR] [--reg R]
                         [--seed S] [--no-cuda] [--name NAME]
                         [--train-location TRAIN_LOCATION]
                         [--test-location TEST_LOCATION] [--save SAVE]

MiMSI - A Multiple Instance Learning Model for detecting microsatellite
instability in NGS data

optional arguments:
  -h, --help            show this help message and exit
  --version             Display current version of MiMSI
  --epochs N            Number of epochs to train (default: 40)
  --lr LR               Learning rate used in training (default: 0.0001)
  --reg R               Weight decay used in training (default: 5e-4)
  --seed S              Random Seed (default: 2)
  --no-cuda             Disables CUDA training for use off GPU, if this is not
                        specified the utility will check availability of
                        torch.cuda
  --name NAME           Name of the model,
  --train-location TRAIN_LOCATION
                        Directory Location for Training Data
  --test-location TEST_LOCATION
                        Directory Location for Testing Data
  --save SAVE           Save the model weights to disk after training
```

## mimsi_visualize_instance

### Tool Description
MiMSI Site Visualization Utility

### Metadata
- **Docker Image**: quay.io/biocontainers/mimsi:0.4.5--pyhdfd78af_0
- **Homepage**: https://github.com/mskcc/mimsi
- **Package**: https://anaconda.org/channels/bioconda/packages/mimsi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: visualize_instance [-h] [--version] [--vector VECTOR]
                          [--locations LOCATIONS] [--site SITE]
                          [--site-list SITE_LIST] [--coverage COVERAGE]
                          [--output OUTPUT]

MiMSI Site Visualization Utility

optional arguments:
  -h, --help            show this help message and exit
  --version             Display current version of MiMSI
  --vector VECTOR       Vector .npy for the case you'd like to visualize
  --locations LOCATIONS
                        Locations .npy for the case you'd like to visualize
  --site SITE           Site to visualize, must be present in locations file
                        for the image to generate properly
  --site-list SITE_LIST
                        File indicating the site(s) to visualize
  --coverage COVERAGE   Required coverage for both the tumor and the normal.
                        Any coverage in excess of this limit will be randomly
                        downsampled
  --output OUTPUT       Name of the output filename
```

## Metadata
- **Skill**: generated
