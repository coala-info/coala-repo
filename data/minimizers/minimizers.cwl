cwlVersion: v1.2
class: CommandLineTool
baseCommand: minimizers
label: minimizers
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help information or usage instructions for the 'minimizers'
  tool.\n\nTool homepage: https://github.com/cumbof/minimizers"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minimizers:0.1.2--pyhdfd78af_0
stdout: minimizers.out
