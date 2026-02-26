cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - crocodeel
  - train_model
label: crocodeel_train_model
doc: "Train a Random Forest model to classify species based on their abundance.\n\n\
  Tool homepage: https://github.com/metagenopolis/crocodeel"
inputs:
  - id: nproc
    type:
      - 'null'
      - int
    doc: Number of parallel processes to search contaminations
    default: 20
    inputBinding:
      position: 101
      prefix: --nproc
  - id: ntrees
    type:
      - 'null'
      - int
    doc: Number of trees in the RandomForest model
    default: 100
    inputBinding:
      position: 101
      prefix: --ntrees
  - id: rng_seed
    type:
      - 'null'
      - int
    doc: Seed of the random number generator for reproducibility
    default: 0
    inputBinding:
      position: 101
      prefix: --rng-seed
  - id: species_abundance_table
    type: File
    doc: Input TSV file corresponding to the species abundance table
    inputBinding:
      position: 101
      prefix: -s
  - id: test_size
    type:
      - 'null'
      - float
    doc: Proportion of dataset to include in test split
    default: 0.3
    inputBinding:
      position: 101
      prefix: --test-size
outputs:
  - id: model_file
    type: File
    doc: Output file storing the trained Random Forest model
    outputBinding:
      glob: $(inputs.model_file)
  - id: json_report_file
    type: File
    doc: Output JSON file storing classification performance metrics for train 
      and test splits
    outputBinding:
      glob: $(inputs.json_report_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crocodeel:1.1.0--pyhdfd78af_0
