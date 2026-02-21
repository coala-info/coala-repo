cwlVersion: v1.2
class: CommandLineTool
baseCommand: staramr
label: staramr
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a set of log messages from a container runtime (Singularity/Apptainer)
  indicating a failure to fetch or build the container image.\n\nTool homepage: https://github.com/phac-nml/staramr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/staramr:0.11.1--pyhdfd78af_0
stdout: staramr.out
