cwlVersion: v1.2
class: CommandLineTool
baseCommand: pneumocat
label: pneumocat
doc: "Pneumococcal Capsular Typing tool (Note: The provided text is a container build
  error log and does not contain help documentation or argument definitions).\n\n
  Tool homepage: https://github.com/phe-bioinformatics/pneumocat/archive/v1.1.tar.gz"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pneumocat:1.2.1--0
stdout: pneumocat.out
