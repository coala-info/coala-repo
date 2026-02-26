cwlVersion: v1.2
class: CommandLineTool
baseCommand: fuc fa-filter
label: fuc_fa-filter
doc: "Filter sequence records in a FASTA file.\n\nTool homepage: https://github.com/sbslee/fuc"
inputs:
  - id: fasta
    type: File
    doc: Input FASTA file (compressed or uncompressed).
    inputBinding:
      position: 1
  - id: contigs
    type:
      - 'null'
      - type: array
        items: string
    doc: One or more contigs to be selected. Alternatively, you can provide a 
      file containing one contig per line.
    inputBinding:
      position: 102
      prefix: --contigs
  - id: exclude
    type:
      - 'null'
      - boolean
    doc: Exclude specified contigs.
    inputBinding:
      position: 102
      prefix: --exclude
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_fa-filter.out
