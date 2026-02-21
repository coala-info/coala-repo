cwlVersion: v1.2
class: CommandLineTool
baseCommand: pod5
label: lib-pod5_pod5
doc: "The provided text does not contain help information or a description of the
  tool. It contains error logs related to a container environment (Singularity/Apptainer)
  failing to build an image due to insufficient disk space.\n\nTool homepage: https://github.com/nanoporetech/pod5-file-format"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lib-pod5:0.3.33--py311h25590d1_0
stdout: lib-pod5_pod5.out
