cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - DeltaMSI
  - train
label: deltamsi_train
doc: "Train a new model\n\nTool homepage: https://github.com/RADar-AZDelta/DeltaMSI"
inputs:
  - id: bed_file
    type: File
    doc: "The bed file of the regions (chr,start,end,name)"
    inputBinding:
      position: 101
      prefix: --bed_file
  - id: ihc_file
    type:
      - 'null'
      - File
    doc: "Text file (tsv or csv) with as first column the sample_name, second ihc value (pMMR/dMMR, 0/1 or MSS/MSI)"
    inputBinding:
      position: 101
      prefix: --ihc_file
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
  - id: flanking
    type:
      - 'null'
      - int
    doc: "The number of bases the flanking must use"
    inputBinding:
      position: 101
      prefix: --flanking
  - id: minimum_mapping_quality
    type:
      - 'null'
      - int
    doc: "The minimum mapping quality of the reads"
    inputBinding:
      position: 101
      prefix: --minimum_mapping_quality
  - id: depth
    type:
      - 'null'
      - int
    doc: "The minimum dapth of a region"
    inputBinding:
      position: 101
      prefix: --depth
  - id: out_dir
    type: string
    doc: "The output directory for the model"
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
  - id: model_dir
    type: Directory
    doc: The output directory with the trained model
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deltamsi:1.0.1--pyh7cba7a3_0
