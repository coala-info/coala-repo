cwlVersion: v1.2
class: CommandLineTool
baseCommand: predex_annotation
label: predex_annotation
doc: "Perform annotation using predex.\n\nTool homepage: https://github.com/tomkuipers1402/predex"
inputs:
  - id: fasta
    type: File
    doc: Fasta file input
    inputBinding:
      position: 101
      prefix: --fasta
  - id: gtf
    type: File
    doc: GTF file input
    inputBinding:
      position: 101
      prefix: --gtf
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/predex:0.9.3--pyh5e36f6f_0
