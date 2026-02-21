cwlVersion: v1.2
class: CommandLineTool
baseCommand: gassst
label: gassst
doc: "Global Alignment Short Sequence Search Tool (Note: The provided text is a system
  error log regarding a container build failure and does not contain CLI help information
  or argument definitions).\n\nTool homepage: https://www.irisa.fr/symbiose/projects/gassst/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gassst:1.28--h503566f_3
stdout: gassst.out
