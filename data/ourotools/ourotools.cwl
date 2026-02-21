cwlVersion: v1.2
class: CommandLineTool
baseCommand: ourotools
label: ourotools
doc: "The provided text appears to be a system error log from a container runtime
  (Apptainer/Singularity) rather than the tool's help documentation. As a result,
  no arguments or descriptions could be extracted.\n\nTool homepage: https://github.com/ahs2202/ouro-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ourotools:0.2.9--pyhdfd78af_0
stdout: ourotools.out
