cwlVersion: v1.2
class: CommandLineTool
baseCommand: cuteSV
label: cutesv
doc: "The provided text does not contain help information for the tool. It is an error
  log from a container runtime (Singularity/Apptainer) indicating a failure to extract
  the image due to lack of disk space.\n\nTool homepage: https://github.com/tjiangHIT/cuteSV"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cutesv:2.1.3--pyhdfd78af_0
stdout: cutesv.out
