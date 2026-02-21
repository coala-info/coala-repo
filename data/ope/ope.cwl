cwlVersion: v1.2
class: CommandLineTool
baseCommand: ope
label: ope
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help documentation or usage instructions for the 'ope' tool.
  As a result, no arguments or descriptions could be extracted.\n\nTool homepage:
  https://github.com/camillescott/ope"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ope:0.8--pyh5bfb8f1_0
stdout: ope.out
