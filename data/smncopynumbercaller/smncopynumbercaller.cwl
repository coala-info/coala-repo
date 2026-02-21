cwlVersion: v1.2
class: CommandLineTool
baseCommand: smncopynumbercaller
label: smncopynumbercaller
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  indicating a failure to fetch the tool's image.\n\nTool homepage: https://github.com/Illumina/SMNCopyNumberCaller"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smncopynumbercaller:1.1.2--py312h7e72e81_1
stdout: smncopynumbercaller.out
