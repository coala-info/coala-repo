cwlVersion: v1.2
class: CommandLineTool
baseCommand: plotHeatmap
label: deeptools_plotHeatmap
doc: "The provided text does not contain help information for plotHeatmap; it contains
  error logs related to a container runtime (Singularity/Apptainer) failure due to
  insufficient disk space.\n\nTool homepage: https://github.com/deeptools/deepTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deeptools:3.5.6--pyhdfd78af_0
stdout: deeptools_plotHeatmap.out
