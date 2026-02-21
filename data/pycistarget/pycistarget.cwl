cwlVersion: v1.2
class: CommandLineTool
baseCommand: pycistarget
label: pycistarget
doc: "The provided text does not contain help information or usage instructions for
  pycistarget. It appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  failing to fetch the tool's image.\n\nTool homepage: https://github.com/aertslab/pycistarget"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pycistarget:1.1--pyhdfd78af_0
stdout: pycistarget.out
