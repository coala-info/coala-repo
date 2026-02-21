cwlVersion: v1.2
class: CommandLineTool
baseCommand: milonga_milonga_setup.sh
label: milonga_milonga_setup.sh
doc: "Setup script for milonga. (Note: The provided text is an error log and does
  not contain usage information or argument definitions.)\n\nTool homepage: https://gitlab.com/bfr_bioinformatics/milonga"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/milonga:1.0.3--hdfd78af_0
stdout: milonga_milonga_setup.sh.out
