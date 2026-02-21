cwlVersion: v1.2
class: CommandLineTool
baseCommand: xcf2pnm
label: xcftools_xcf2pnm
doc: "The provided text does not contain help information for the tool. It contains
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to fetch or build the image.\n\nTool homepage: https://github.com/j-jorge/xcftools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xcftools:1.0.7--0
stdout: xcftools_xcf2pnm.out
