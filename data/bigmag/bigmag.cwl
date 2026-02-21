cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigmag
label: bigmag
doc: "The provided text does not contain help information or usage instructions for
  the tool 'bigmag'. It appears to be a log of a failed container build process (Apptainer/Singularity)
  due to insufficient disk space.\n\nTool homepage: https://github.com/jeffe107/BIgMAG"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bigmag:1.1.0--pyhdfd78af_0
stdout: bigmag.out
