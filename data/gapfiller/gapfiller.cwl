cwlVersion: v1.2
class: CommandLineTool
baseCommand: gapfiller
label: gapfiller
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log from a container runtime (Apptainer/Singularity) indicating
  a failure to pull the image due to lack of disk space.\n\nTool homepage: https://sourceforge.net/projects/gapfiller"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gapfiller:2.1.2--h7ff8a90_4
stdout: gapfiller.out
