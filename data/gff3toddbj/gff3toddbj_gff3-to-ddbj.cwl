cwlVersion: v1.2
class: CommandLineTool
baseCommand: gff3-to-ddbj
label: gff3toddbj_gff3-to-ddbj
doc: "A tool for converting GFF3 files to DDBJ (DNA Data Bank of Japan) format.\n\n
  Tool homepage: https://github.com/yamaton/gff3toddbj"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gff3toddbj:0.4.3--pyhdfd78af_0
stdout: gff3toddbj_gff3-to-ddbj.out
