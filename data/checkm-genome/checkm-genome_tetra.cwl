cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - checkm
  - tetra
label: checkm-genome_tetra
doc: "Calculate tetranucleotide signature of sequences.\n\nTool homepage: https://github.com/Ecogenomics/CheckM"
inputs:
  - id: seq_file
    type: File
    doc: 'sequences used to generate bins (fasta format)'
    inputBinding:
      position: 1
  - id: output_file
    type: string
    doc: 'print results to file'
    inputBinding:
      position: 2
  - id: threads
    type:
      - 'null'
      - int
    doc: 'number of threads (default: 1)'
    inputBinding:
      position: 101
      prefix: --threads
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: 'suppress console output'
    inputBinding:
      position: 101
      prefix: --quiet
outputs:
  - id: output_file_out
    type: File
    doc: 'print results to file'
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
