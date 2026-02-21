cwlVersion: v1.2
class: CommandLineTool
baseCommand: tabview
label: tabview
doc: "The provided text does not contain help information for the tool; it consists
  of container runtime logs and a fatal error message during a build process.\n\n
  Tool homepage: https://github.com/firecat53/tabview"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tabview:1.4.3--pyh4bbf42b_0
stdout: tabview.out
