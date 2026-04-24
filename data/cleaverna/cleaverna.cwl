cwlVersion: v1.2
class: CommandLineTool
baseCommand: CleaveRNA
label: cleaverna
doc: "Advanced machine learning-based computational tool for scoring candidate DNAzyme
  cleavage sites in substrate RNA sequences using structural and thermodynamic features.\n\
  \nTool homepage: https://github.com/reyhaneh-tavakoli/CleaveRNA"
inputs:
  - id: model_name
    type: string
    doc: Model identifier and output file prefix (e.g., "my_experiment")
    inputBinding:
      position: 101
      prefix: --model_name
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: 'Output directory for results (default: current directory)'
    inputBinding:
      position: 101
      prefix: --output_dir
  - id: params
    type:
      - 'null'
      - File
    doc: 'Parameters file with columns: LA, RA, CS, Tem, CA'
    inputBinding:
      position: 101
      prefix: --params
  - id: prediction_mode
    type:
      - 'null'
      - string
    doc: 'Analysis mode selection: • default : Standard cleavage site prediction •
      target_screen : Screen custom cleavage sites • target_check : Validate sites
      in specific regions • specific_query : Analyze custom DNAzyme sequences'
    inputBinding:
      position: 101
      prefix: --prediction_mode
  - id: specific_query_input
    type:
      - 'null'
      - File
    doc: Custom query parameters for specific_query mode
    inputBinding:
      position: 101
      prefix: --specific_query_input
  - id: target_files_prediction
    type:
      - 'null'
      - type: array
        items: File
    doc: Target RNA sequence files in FASTA format (required for prediction 
      mode)
    inputBinding:
      position: 101
      prefix: --target_files_prediction
  - id: target_files_training
    type:
      - 'null'
      - type: array
        items: File
    doc: Training RNA sequence files in FASTA format (required for training 
      mode)
    inputBinding:
      position: 101
      prefix: --target_files_training
  - id: training_file
    type:
      - 'null'
      - File
    doc: Training data feature matrix (mutually exclusive with 
      --target_files_training)
    inputBinding:
      position: 101
      prefix: --training_file
  - id: training_scores
    type:
      - 'null'
      - File
    doc: Training target labels/scores (required with --training_file)
    inputBinding:
      position: 101
      prefix: --training_scores
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cleaverna:1.0.0--pyhdfd78af_0
stdout: cleaverna.out
