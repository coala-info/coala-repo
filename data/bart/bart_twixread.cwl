cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, twixread]
requirements:
  - class: InlineJavascriptRequirement
label: bart_twixread
doc: "Read data from Siemens twix (.dat) files.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: dat_file
    type: File
    doc: Input Siemens twix (.dat) file
    inputBinding:
      position: 10
  - id: output
    type: string
    doc: Output file
    inputBinding:
      position: 11
  - id: automatic_dimensions
    type:
      - 'null'
      - boolean
    doc: automatic [guess dimensions]
    inputBinding:
      position: 1
      prefix: -A
  - id: num_averages
    type:
      - 'null'
      - int
    doc: number of averages
    inputBinding:
      position: 1
      prefix: -v
  - id: num_channels
    type:
      - 'null'
      - int
    doc: number of channels
    inputBinding:
      position: 1
      prefix: -c
  - id: num_repetitions
    type:
      - 'null'
      - int
    doc: number of repetitions
    inputBinding:
      position: 1
      prefix: -n
  - id: num_samples
    type:
      - 'null'
      - int
    doc: number of samples (read-out)
    inputBinding:
      position: 1
      prefix: -x
  - id: num_slices
    type:
      - 'null'
      - int
    doc: number of slices
    inputBinding:
      position: 1
      prefix: -s
  - id: partition_encoding_steps
    type:
      - 'null'
      - int
    doc: partition encoding steps
    inputBinding:
      position: 1
      prefix: -z
  - id: phase_encoding_steps
    type:
      - 'null'
      - int
    doc: phase encoding steps
    inputBinding:
      position: 1
      prefix: -y
  - id: total_num_adcs
    type:
      - 'null'
      - int
    doc: total number of ADCs
    inputBinding:
      position: 1
      prefix: -a
  - id: use_linectr_offset
    type:
      - 'null'
      - boolean
    doc: use linectr offset
    inputBinding:
      position: 1
      prefix: -L
  - id: use_partctr_offset
    type:
      - 'null'
      - boolean
    doc: use partctr offset
    inputBinding:
      position: 1
      prefix: -P
outputs:
  - id: output_file
    type: File
    doc: Array written as output.cfl/.hdr
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.output).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
