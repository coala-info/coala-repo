cwlVersion: v1.2
class: CommandLineTool
baseCommand: quast_metaquast.py
label: quast_metaquast.py
doc: "QUAST: Quality Assessment Tool for Genome Assemblies (MetaQUAST version). Note:
  The provided input text contains container runtime logs and error messages rather
  than the tool's help documentation.\n\nTool homepage: http://quast.sourceforge.net/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quast:5.3.0--py313pl5321h5ca1c30_2
stdout: quast_metaquast.py.out
