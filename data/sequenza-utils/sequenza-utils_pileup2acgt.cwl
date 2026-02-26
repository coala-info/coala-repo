cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sequenza-utils
  - pileup2acgt
label: sequenza-utils_pileup2acgt
doc: "Converts a pileup file to ACGT format.\n\nTool homepage: http://sequenza-utils.readthedocs.org"
inputs:
  - id: input_file
    type: File
    doc: Input pileup file.
    inputBinding:
      position: 1
  - id: include_indels
    type:
      - 'null'
      - boolean
    doc: Include indels in the output. Default is False.
    inputBinding:
      position: 102
      prefix: --include-indels
  - id: min_base_quality
    type:
      - 'null'
      - int
    doc: Minimum base quality to consider a base. Default is 20.
    default: 20
    inputBinding:
      position: 102
      prefix: --min-base-quality
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum depth to consider a position. Default is 1.
    default: 1
    inputBinding:
      position: 102
      prefix: --min-depth
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: Minimum mapping quality to consider a read. Default is 20.
    default: 20
    inputBinding:
      position: 102
      prefix: --min-mapping-quality
  - id: reference_sequence
    type:
      - 'null'
      - File
    doc: Reference sequence FASTA file. If provided, the output will include the
      reference base at each position.
    inputBinding:
      position: 102
      prefix: --reference-sequence
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output ACGT file. If not specified, output will be written to stdout.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequenza-utils:3.0.0--py311h8ddd9a4_8
