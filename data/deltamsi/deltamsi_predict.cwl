cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - DeltaMSI
  - predict
label: deltamsi_predict
doc: "Predict one or multiple samples\n\nTool homepage: https://github.com/RADar-AZDelta/DeltaMSI"
inputs:
  - id: model_directory
    type: Directory
    doc: "The model to use"
    inputBinding:
      position: 101
      prefix: --model_directory
  - id: bam_file
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --bam_file
    doc: "The bam files of the samples (indexed; the option is repeated once per file)"
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
    inputBinding:
      position: 101
  - id: bam_list_file
    type:
      - 'null'
      - File
    doc: "A file with all complete paths to the bam files of the samples"
    inputBinding:
      position: 101
      prefix: --bam_list_file
  - id: out_dir
    type: string
    doc: "The output directory for the results"
    inputBinding:
      position: 101
      prefix: --out_dir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "verbose"
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: results_dir
    type: Directory
    doc: The output directory with the results
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deltamsi:1.0.1--pyh7cba7a3_0
