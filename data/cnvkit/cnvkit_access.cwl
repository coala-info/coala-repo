cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvkit.py
  - access
label: cnvkit_access
doc: "List the locations of accessible sequence regions in a FASTA file.\n\nTool homepage: https://github.com/etal/cnvkit"
inputs:
  - id: fa_fname
    type: File
    secondaryFiles:
      - pattern: .fai
        required: false
    doc: "Genome FASTA file name"
    inputBinding:
      position: 1
  - id: min_gap_size
    type:
      - 'null'
      - int
    doc: "Minimum gap size between accessible sequence regions. Regions separated by less than this distance will be joined together. [Default: 5000]"
    inputBinding:
      position: 101
      prefix: --min-gap-size
  - id: exclude
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --exclude
    doc: "Additional regions to exclude, in BED format. Can be used multiple times."
    inputBinding:
      position: 101
  - id: output
    type: string
    doc: "Output file name"
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: output_out
    type:
      - 'null'
      - File
    doc: "Output file name"
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
