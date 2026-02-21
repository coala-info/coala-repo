cwlVersion: v1.2
class: CommandLineTool
baseCommand: tmb
label: tmb
doc: "Tumor Mutational Burden analysis tool (Note: The provided text is a container
  build error log and does not contain help documentation or argument definitions).\n
  \nTool homepage: https://github.com/bioinfo-pf-curie/TMB"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tmb:1.5.0--pyhdfd78af_1
stdout: tmb.out
