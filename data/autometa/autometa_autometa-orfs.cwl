cwlVersion: v1.2
class: CommandLineTool
baseCommand: autometa-orfs
label: autometa_autometa-orfs
doc: "Calls ORFs with provided input assembly\n\nTool homepage: https://github.com/KwanLab/Autometa"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: assembly
    type: File
    doc: "Path to metagenome assembly"
    inputBinding:
      position: 1
      prefix: --assembly
  - id: output_nucls
    type: string
    doc: "Path to output nucleotide ORFs"
    inputBinding:
      position: 1
      prefix: --output-nucls
  - id: output_prots
    type: string
    doc: "Path to output amino-acid ORFs"
    inputBinding:
      position: 1
      prefix: --output-prots
  - id: cpus
    type:
      - 'null'
      - int
    doc: "Number of processors to use (more than one parallelizes prodigal using GNU parallel) (default: 1)"
    inputBinding:
      position: 1
      prefix: --cpus
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Overwrite existing output ORF filepaths"
    inputBinding:
      position: 1
      prefix: --force
outputs:
  - id: nucls_out
    type: File
    doc: "Nucleotide ORFs"
    outputBinding:
      glob: "$(inputs.output_nucls)"
  - id: prots_out
    type: File
    doc: "Amino-acid ORFs"
    outputBinding:
      glob: "$(inputs.output_prots)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
