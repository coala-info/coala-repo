cwlVersion: v1.2
class: CommandLineTool
baseCommand: trnascan-se
label: trnascan-se
doc: "Scan sequences for tRNA genes.\n\nTool homepage: http://lowelab.ucsc.edu/tRNAscan-SE/"
inputs:
  - id: input_file
    type: File
    doc: Input sequence file (FASTA format)
    inputBinding:
      position: 1
  - id: hmm_file
    type:
      - 'null'
      - File
    doc: Use a specific HMM file
    inputBinding:
      position: 102
      prefix: --hmm
  - id: no_pyrimidines
    type:
      - 'null'
      - boolean
    doc: Do not search for pyrimidine biosynthesis genes
    inputBinding:
      position: 102
      prefix: --no-pyrimidines
  - id: organism
    type:
      - 'null'
      - string
    doc: Specify organism type (e.g., 'euk', 'bac', 'arch', 'mito')
    inputBinding:
      position: 102
      prefix: --organism
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress most output
    inputBinding:
      position: 102
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Prefix for output files
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trnascan-se:2.0.12--pl5321h7b50bb2_2
