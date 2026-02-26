cwlVersion: v1.2
class: CommandLineTool
baseCommand: fermi build
label: fermi_build
doc: "Build an FM-index for a FASTA file.\n\nTool homepage: https://github.com/quantumlib/OpenFermion"
inputs:
  - id: input_fa
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: append_fm_index
    type:
      - 'null'
      - File
    doc: append the FM-index to the existing FILE
    default: 'null'
    inputBinding:
      position: 102
      prefix: -i
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: force to overwrite the output file (effective with -o)
    inputBinding:
      position: 102
      prefix: -f
  - id: marker_power
    type:
      - 'null'
      - int
    doc: use a small marker per 2^(INT+3) bytes
    default: 3
    inputBinding:
      position: 102
      prefix: -b
  - id: no_trim_identical_forward_reverse
    type:
      - 'null'
      - boolean
    doc: do not trim 1bp for reads whose forward and reverse are identical
    inputBinding:
      position: 102
      prefix: -O
  - id: symbols_to_process
    type:
      - 'null'
      - int
    doc: number of symbols to process at a time
    default: 250000000
    inputBinding:
      position: 102
      prefix: -s
  - id: trim_read_length
    type:
      - 'null'
      - int
    doc: trim read down to INT bp
    default: inf
    inputBinding:
      position: 102
      prefix: -l
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
