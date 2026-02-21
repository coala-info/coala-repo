cwlVersion: v1.2
class: CommandLineTool
baseCommand: stream_atac
label: stream_atac
doc: "Single-cell Trajectory Reconstruction, Exploration And Mapping for ATAC-seq
  (Note: The provided text contains container build logs and error messages rather
  than command-line help documentation).\n\nTool homepage: https://github.com/pinellolab/STREAM_atac"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stream:1.1--pyhdfd78af_0
stdout: stream_atac.out
