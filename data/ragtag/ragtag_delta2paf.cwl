cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ragtag.py
  - delta2paf
label: ragtag_delta2paf
doc: "Convert a Nucmer delta file to a PAF file (written to standard output).\n\n\
  Tool homepage: https://github.com/malonge/RagTag"
inputs:
  - id: delta
    type: File
    doc: delta file to convert
    inputBinding:
      position: 1
outputs:
  - id: paf
    type: stdout
    doc: PAF alignments
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ragtag:2.1.0--pyhb7b1952_0
stdout: ragtag_delta2paf.paf
