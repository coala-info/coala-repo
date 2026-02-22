cwlVersion: v1.2
class: CommandLineTool
baseCommand: annotsv
label: annotsv
doc: "AnnotSV is a tool for the annotation of structural variants (SV). (Note: The
  provided input text was an error log and did not contain help documentation.)\n\n\
  Tool homepage: https://github.com/lgmgeo/AnnotSV"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/annotsv:3.5.3--py313hdfd78af_0
stdout: annotsv.out
