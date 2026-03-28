# mimsi CWL Generation Report

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


## Metadata
- **Skill**: generated
