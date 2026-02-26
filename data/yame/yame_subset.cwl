cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - yame
  - subset
label: yame_subset
doc: "Subset a multi-sample .cx by sample names (requires an index), or (with -s)
  convert a format-2 state track into one binary track per state.\n\nTool homepage:
  https://github.com/zhou-lab/YAME"
inputs:
  - id: input_cx
    type: File
    doc: Input .cx file
    inputBinding:
      position: 1
  - id: sample_names
    type:
      - 'null'
      - type: array
        items: string
    doc: Sample names to subset
    inputBinding:
      position: 2
  - id: first_n_samples
    type:
      - 'null'
      - int
    doc: If no names are provided, take the first N samples from the input 
      index.
    inputBinding:
      position: 103
      prefix: -H
  - id: format2_state_mode
    type:
      - 'null'
      - boolean
    doc: Format-2 state filtering mode (output format 0; one record per term).
    inputBinding:
      position: 103
      prefix: -s
  - id: last_n_samples
    type:
      - 'null'
      - int
    doc: If no names are provided, take the last N samples from the input index.
    inputBinding:
      position: 103
      prefix: -T
  - id: list_file
    type:
      - 'null'
      - File
    doc: Path to sample/state list. Ignored if names are provided as trailing 
      command-line arguments.
    inputBinding:
      position: 103
      prefix: -l
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write output to a file. If provided, an output index (.cxi) is also 
      generated. If omitted, writes to stdout (no index).
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yame:1.8--ha83d96e_0
