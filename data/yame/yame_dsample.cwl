cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - yame
  - dsample
label: yame_dsample
doc: "Downsample methylation data for format 3 or 6.\n  - For format 3, downsampling
  masks by setting M=U=0.\n  - For format 6, downsampling masks by clearing the universe
  bit.\n\nTool homepage: https://github.com/zhou-lab/YAME"
inputs:
  - id: input_cx_file
    type: File
    doc: Input .cx file
    inputBinding:
      position: 1
  - id: binarize_sampled_format3
    type:
      - 'null'
      - boolean
    doc: After sampling, randomly binarize sampled format 3 (MU) rows. Output is
      still format 3.
    inputBinding:
      position: 102
      prefix: -b
  - id: num_records_to_sample
    type:
      - 'null'
      - int
    doc: number of records to sample/keep per sample. If N >= available records,
      all available records are kept.
    inputBinding:
      position: 102
      prefix: -N
  - id: num_replicates
    type:
      - 'null'
      - int
    doc: number of downsampled replicates per input sample. Each replicate is 
      independently re-sampled.
    inputBinding:
      position: 102
      prefix: -r
  - id: replicate_sample_name_prefix
    type:
      - 'null'
      - string
    doc: 'replicate sample name prefix. If given, the out sample name is: [sname]-[pre]-[rep_id].'
    inputBinding:
      position: 102
      prefix: -p
  - id: seed
    type:
      - 'null'
      - int
    doc: seed for random sampling
    inputBinding:
      position: 102
      prefix: -s
outputs:
  - id: output_cx_file
    type:
      - 'null'
      - File
    doc: Output .cx file name. If missing, write to stdout (no index will be 
      written).
    outputBinding:
      glob: '*.out'
  - id: output_file
    type:
      - 'null'
      - File
    doc: output .cx file name.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yame:1.8--ha83d96e_0
