# kipoi_veff CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| kipoi_veff_create_mutation_map | Failed | image problem: the image has no sklearn, keras or tensorflow, so the dataloader and model cannot be imported |
| kipoi_veff_plot_mutation_map | Failed | image problem: shapely cannot find libc in the image (OSError: Could not find lib c), so the plot step crashes |
| kipoi_veff_score_variants | Failed | image problem: the image has no sklearn, keras or tensorflow, so the dataloader and model cannot be imported |

## kipoi_veff_score_variants

### Tool Description
Predict effect of SNVs using ISM.

### Metadata
- **Docker Image**: quay.io/biocontainers/kipoi_veff:0.3.1--pyh145b6a8_1
- **Homepage**: https://github.com/kipoi/kipoi-veff
- **Package**: https://anaconda.org/channels/bioconda/packages/kipoi_veff/overview
- **Validation**: PASS

### Original Help Text
```text
usage: kipoi veff score_variants [-h] [--source {kipoi,github-permalink,dir}]
                                 [--dataloader DATALOADER]
                                 [--dataloader_source DATALOADER_SOURCE]
                                 [--dataloader_args DATALOADER_ARGS [DATALOADER_ARGS ...]]
                                 -i INPUT_VCF [-o OUTPUT_VCF]
                                 [--batch_size BATCH_SIZE] [-n NUM_WORKERS]
                                 [-r RESTRICTION_BED] [-e EXTRA_OUTPUT]
                                 [-s SCORES [SCORES ...]]
                                 [-k SCORE_KWARGS [SCORE_KWARGS ...]]
                                 [-l SEQ_LENGTH] [--std_var_id]
                                 [--model_outputs MODEL_OUTPUTS [MODEL_OUTPUTS ...]]
                                 [--model_outputs_i MODEL_OUTPUTS_I [MODEL_OUTPUTS_I ...]]
                                 [--singularity]
                                 model

Predict effect of SNVs using ISM.

positional arguments:
  model                 Model name.

optional arguments:
  -h, --help            show this help message and exit
  --source {kipoi,github-permalink,dir}
                        Model source to use. Specified in ~/.kipoi/config.yaml
                        under model_sources. 'dir' is an additional source
                        referring to the local folder.
  --dataloader DATALOADER
                        Dataloader name. If not specified, the model's
                        defaultDataLoader will be used
  --dataloader_source DATALOADER_SOURCE
                        Dataloader source
  --dataloader_args DATALOADER_ARGS [DATALOADER_ARGS ...]
                        DataLoader arguments either as a json string:'{"arg1":
                        1} or as a file path to a json file
  -i INPUT_VCF, --input_vcf INPUT_VCF
                        Input VCF.
  -o OUTPUT_VCF, --output_vcf OUTPUT_VCF
                        Output annotated VCF file path.
  --batch_size BATCH_SIZE
                        Batch size to use in prediction
  -n NUM_WORKERS, --num_workers NUM_WORKERS
                        Number of parallel workers for loading the dataset
  -r RESTRICTION_BED, --restriction_bed RESTRICTION_BED
                        Regions for prediction can only be subsets of this bed
                        file
  -e EXTRA_OUTPUT, --extra_output EXTRA_OUTPUT
                        Additional output files in other (non-vcf) formats.
                        File format is inferred from the file path ending.
                        Available file formats are: .h5, .hdf5, .pq, .parquet,
                        .zarr, .pqt, .tsv
  -s SCORES [SCORES ...], --scores SCORES [SCORES ...]
                        Scoring method to be used. Only scoring methods
                        selected in the model yaml file areavailable except
                        for `diff` which is always available. Select scoring
                        function by the`name` tag defined in the model yaml
                        file.
  -k SCORE_KWARGS [SCORE_KWARGS ...], --score_kwargs SCORE_KWARGS [SCORE_KWARGS ...]
                        JSON definition of the kwargs for the scoring
                        functions selected in --scoring. The definiton can
                        either be in JSON in the command line or the path of a
                        .json file. The individual JSONs are expected to be
                        supplied in the same order as the labels defined in
                        --scoring. If the defaults or no arguments should be
                        used define '{}' for that respective scoring method.
  -l SEQ_LENGTH, --seq_length SEQ_LENGTH
                        Optional parameter: Model input sequence length -
                        necessary if the model does not have a pre-defined
                        input sequence length.
  --std_var_id          If set then variant IDs in the annotated VCF will be
                        replaced with a standardised, unique ID.
  --model_outputs MODEL_OUTPUTS [MODEL_OUTPUTS ...]
                        Optional parameter: Only return predictions for the
                        selected model outputs. Namingaccording to the
                        definition in model.yaml > schema > targets >
                        column_labels
  --model_outputs_i MODEL_OUTPUTS_I [MODEL_OUTPUTS_I ...]
                        Optional parameter: Only return predictions for the
                        selected model outputs. Give integerindices of the
                        selected model output(s).
  --singularity         Run `kipoi predict` in the appropriate singularity
                        container. Containters will get downloaded to
                        ~/.kipoi/envs/ or to $SINGULARITY_CACHEDIR if set
```

## kipoi_veff_create_mutation_map

### Tool Description
Calculate variant effect scores for mutation map plotting.

### Metadata
- **Docker Image**: quay.io/biocontainers/kipoi_veff:0.3.1--pyh145b6a8_1
- **Homepage**: https://github.com/kipoi/kipoi-veff
- **Package**: https://anaconda.org/channels/bioconda/packages/kipoi_veff/overview
- **Validation**: PASS

### Original Help Text
```text
usage: kipoi veff create_mutation_map [-h]
                                      [--source {kipoi,github-permalink,dir}]
                                      [--dataloader DATALOADER]
                                      [--dataloader_source DATALOADER_SOURCE]
                                      [--dataloader_args DATALOADER_ARGS [DATALOADER_ARGS ...]]
                                      [-r REGIONS_FILE]
                                      [--batch_size BATCH_SIZE]
                                      [-n NUM_WORKERS] [-i] -o OUTPUT
                                      [-s SCORES [SCORES ...]]
                                      [-k SCORE_KWARGS [SCORE_KWARGS ...]]
                                      [-l SEQ_LENGTH] [--singularity]
                                      model

Predict effect of SNVs using ISM.

positional arguments:
  model                 Model name.

optional arguments:
  -h, --help            show this help message and exit
  --source {kipoi,github-permalink,dir}
                        Model source to use (default=kipoi). Specified in
                        ~/.kipoi/config.yaml under model_sources. When 'dir'
                        is used, use the local directory path when specifying
                        the model/dataloader.
  --dataloader DATALOADER
                        Dataloader name. If not specified, the model's
                        defaultDataLoader will be used
  --dataloader_source DATALOADER_SOURCE
                        Dataloader source
  --dataloader_args DATALOADER_ARGS [DATALOADER_ARGS ...]
                        DataLoader arguments either as a json string:'{"arg1":
                        1} or as a file path to a json file
  -r REGIONS_FILE, --regions_file REGIONS_FILE
                        Region definition as VCF or bed file. Not a required
                        input.
  --batch_size BATCH_SIZE
                        Batch size to use in prediction
  -n NUM_WORKERS, --num_workers NUM_WORKERS
                        Number of parallel workers for loading the dataset
  -i, --install_req     Install required packages from requirements.txt
  -o OUTPUT, --output OUTPUT
                        Output HDF5 file. To be used as input for plotting.
  -s SCORES [SCORES ...], --scores SCORES [SCORES ...]
                        Scoring method to be used. Only scoring methods
                        selected in the model yaml file areavailable except
                        for `diff` which is always available. Select scoring
                        function by the`name` tag defined in the model yaml
                        file.
  -k SCORE_KWARGS [SCORE_KWARGS ...], --score_kwargs SCORE_KWARGS [SCORE_KWARGS ...]
                        JSON definition of the kwargs for the scoring
                        functions selected in --scores. The definiton can
                        either be in JSON in the command line or the path of a
                        .json file. The individual JSONs are expected to be
                        supplied in the same order as the labels defined in
                        --scores. If the defaults or no arguments should be
                        used define '{}' for that respective scoring method.
  -l SEQ_LENGTH, --seq_length SEQ_LENGTH
                        Optional parameter: Model input sequence length -
                        necessary if the model does not have a pre-defined
                        input sequence length.
  --singularity         Run `kipoi predict` in the appropriate singularity
                        container. Containters will get downloaded to
                        ~/.kipoi/envs/ or to $SINGULARITY_CACHEDIR if set
```

## kipoi_veff_plot_mutation_map

### Tool Description
Plot mutation map in a file.

### Metadata
- **Docker Image**: quay.io/biocontainers/kipoi_veff:0.3.1--pyh145b6a8_1
- **Homepage**: https://github.com/kipoi/kipoi-veff
- **Package**: https://anaconda.org/channels/bioconda/packages/kipoi_veff/overview
- **Validation**: PASS

### Original Help Text
```text
usage: kipoi veff plot_mutation_map [-h] [-f INPUT_FILE] [-o OUTPUT]
                                    --input_entry INPUT_ENTRY
                                    --model_seq_input MODEL_SEQ_INPUT
                                    --scoring_key SCORING_KEY --model_output
                                    MODEL_OUTPUT
                                    [--limit_region_genomic LIMIT_REGION_GENOMIC LIMIT_REGION_GENOMIC]
                                    [--rc_plot]

Plot mutation map in a file.

optional arguments:
  -h, --help            show this help message and exit
  -f INPUT_FILE, --input_file INPUT_FILE
                        Input HDF5 file produced from `create_mutation_map`
  -o OUTPUT, --output OUTPUT
                        Output image file
  --input_entry INPUT_ENTRY
                        Input line for which the plot should be generated
  --model_seq_input MODEL_SEQ_INPUT
                        Model input name to be used for plotting. As defined
                        in model.yaml.
  --scoring_key SCORING_KEY
                        Variant score label to be used for plotting. As
                        defined when running `create_mutation_map`.
  --model_output MODEL_OUTPUT
                        Model output to be used for plotting. As defined in
                        model.yaml.
  --limit_region_genomic LIMIT_REGION_GENOMIC LIMIT_REGION_GENOMIC
                        Limit to genomic region. Given as tuple without
                        chromosome, eg: `--limit_region_genomic 13245 12347`
  --rc_plot             Make reverse-complement plot.
```
