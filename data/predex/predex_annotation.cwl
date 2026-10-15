cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - predex
  - annotation
label: predex_annotation
doc: "Perform annotation using predex.\n\nTool homepage: https://github.com/tomkuipers1402/predex"
inputs:
  - id: fasta
    type: File
    secondaryFiles:
      - pattern: .fai
        required: true
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
    inputBinding:
      position: 101
      prefix: --threads
  - id: output_path
    type: string
    doc: Output directory (default = current)
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.output_path)
        entry: '$({"class": "Directory", "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/predex:0.9.3--pyh5e36f6f_0
