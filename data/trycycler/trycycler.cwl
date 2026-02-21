cwlVersion: v1.2
class: CommandLineTool
baseCommand: trycycler
label: trycycler
doc: "The provided text does not contain help information for trycycler. It appears
  to be an error log from a Singularity/Apptainer container build process that failed
  due to insufficient disk space.\n\nTool homepage: https://github.com/rrwick/Trycycler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trycycler:0.5.6--pyhdfd78af_0
stdout: trycycler.out
