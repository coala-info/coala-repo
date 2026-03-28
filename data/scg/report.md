# scg CWL Generation Report

## scg_run_doublet_model

### Tool Description
Run the doublet model.

### Metadata
- **Docker Image**: quay.io/biocontainers/scg:0.3.1--py27_0
- **Homepage**: https://bitbucket.org/aroth85/scg/wiki/Home
- **Package**: https://anaconda.org/channels/bioconda/packages/scg/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/scg/overview
- **Total Downloads**: 6.4K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: Single Cell Genotyper run_doublet_model [-h] --config_file CONFIG_FILE
                                               [--lower_bound_file LOWER_BOUND_FILE]
                                               [--out_dir OUT_DIR]
                                               [--convergence_tolerance CONVERGENCE_TOLERANCE]
                                               [--max_num_iters MAX_NUM_ITERS]
                                               [--seed SEED]
                                               [--labels_file LABELS_FILE]
                                               [--use_position_specific_error_rate]
                                               [--samples_file SAMPLES_FILE]
                                               --state_map_file STATE_MAP_FILE

optional arguments:
  -h, --help            show this help message and exit
  --config_file CONFIG_FILE
                        Path to YAML format configuration file.
  --lower_bound_file LOWER_BOUND_FILE
                        Path of file where lower bound will be written.
  --out_dir OUT_DIR     Path where output files will be written.
  --convergence_tolerance CONVERGENCE_TOLERANCE
  --max_num_iters MAX_NUM_ITERS
  --seed SEED           Set random seed so results can be reproduced. By
                        default a random seed is chosen.
  --labels_file LABELS_FILE
                        Path of file with initial labels to use.
  --use_position_specific_error_rate
                        If an error rate will be estimated for each position.
  --samples_file SAMPLES_FILE
                        Path mapping cells to samples. If set each sample will
                        have a separate mixing proportion.
  --state_map_file STATE_MAP_FILE
```


## scg_run_singlet_model

### Tool Description
Run the singlet model for Single Cell Genotyper.

### Metadata
- **Docker Image**: quay.io/biocontainers/scg:0.3.1--py27_0
- **Homepage**: https://bitbucket.org/aroth85/scg/wiki/Home
- **Package**: https://anaconda.org/channels/bioconda/packages/scg/overview
- **Validation**: PASS

### Original Help Text
```text
usage: Single Cell Genotyper run_singlet_model [-h] --config_file CONFIG_FILE
                                               [--lower_bound_file LOWER_BOUND_FILE]
                                               [--out_dir OUT_DIR]
                                               [--convergence_tolerance CONVERGENCE_TOLERANCE]
                                               [--max_num_iters MAX_NUM_ITERS]
                                               [--seed SEED]
                                               [--labels_file LABELS_FILE]
                                               [--use_position_specific_error_rate]
                                               [--samples_file SAMPLES_FILE]

optional arguments:
  -h, --help            show this help message and exit
  --config_file CONFIG_FILE
                        Path to YAML format configuration file.
  --lower_bound_file LOWER_BOUND_FILE
                        Path of file where lower bound will be written.
  --out_dir OUT_DIR     Path where output files will be written.
  --convergence_tolerance CONVERGENCE_TOLERANCE
  --max_num_iters MAX_NUM_ITERS
  --seed SEED           Set random seed so results can be reproduced. By
                        default a random seed is chosen.
  --labels_file LABELS_FILE
                        Path of file with initial labels to use.
  --use_position_specific_error_rate
                        If an error rate will be estimated for each position.
  --samples_file SAMPLES_FILE
                        Path mapping cells to samples. If set each sample will
                        have a separate mixing proportion.
```


## scg_run_dirichlet_mixture_model

### Tool Description
Run Dirichlet Mixture Model

### Metadata
- **Docker Image**: quay.io/biocontainers/scg:0.3.1--py27_0
- **Homepage**: https://bitbucket.org/aroth85/scg/wiki/Home
- **Package**: https://anaconda.org/channels/bioconda/packages/scg/overview
- **Validation**: PASS

### Original Help Text
```text
usage: Single Cell Genotyper run_dirichlet_mixture_model [-h] --config_file
                                                         CONFIG_FILE
                                                         [--lower_bound_file LOWER_BOUND_FILE]
                                                         [--out_dir OUT_DIR]
                                                         [--convergence_tolerance CONVERGENCE_TOLERANCE]
                                                         [--max_num_iters MAX_NUM_ITERS]
                                                         [--seed SEED]
                                                         [--labels_file LABELS_FILE]

optional arguments:
  -h, --help            show this help message and exit
  --config_file CONFIG_FILE
                        Path to YAML format configuration file.
  --lower_bound_file LOWER_BOUND_FILE
                        Path of file where lower bound will be written.
  --out_dir OUT_DIR     Path where output files will be written.
  --convergence_tolerance CONVERGENCE_TOLERANCE
  --max_num_iters MAX_NUM_ITERS
  --seed SEED           Set random seed so results can be reproduced. By
                        default a random seed is chosen.
  --labels_file LABELS_FILE
                        Path of file with initial labels to use.
```


## Metadata
- **Skill**: not generated
