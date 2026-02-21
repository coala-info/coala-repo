cwlVersion: v1.2
class: CommandLineTool
baseCommand: cesar_mafIndex
label: cesar_mafIndex
doc: "A tool for indexing MAF (Multiple Alignment Format) files, typically used with
  the CESAR (Coding Exon Structure Aware Realigner) tool.\n\nTool homepage: https://github.com/hillerlab/CESAR2.0"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cesar:1.01--h503566f_3
stdout: cesar_mafIndex.out
