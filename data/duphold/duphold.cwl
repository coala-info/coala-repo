cwlVersion: v1.2
class: CommandLineTool
baseCommand: duphold
label: duphold
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to pull the image due to lack of disk space.\n\nTool homepage: https://github.com/brentp/duphold"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/duphold:0.2.1--hfb13731_0
stdout: duphold.out
