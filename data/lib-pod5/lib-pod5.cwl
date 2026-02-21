cwlVersion: v1.2
class: CommandLineTool
baseCommand: lib-pod5
label: lib-pod5
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log related to a container runtime (Apptainer/Singularity)
  failing to pull the lib-pod5 image due to insufficient disk space.\n\nTool homepage:
  https://github.com/nanoporetech/pod5-file-format"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lib-pod5:0.3.33--py311h25590d1_0
stdout: lib-pod5.out
