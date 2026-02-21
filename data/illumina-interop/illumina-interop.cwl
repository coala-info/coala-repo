cwlVersion: v1.2
class: CommandLineTool
baseCommand: illumina-interop
label: illumina-interop
doc: "The provided text does not contain help information for the tool, but rather
  a system error message indicating a failure to build the container image due to
  insufficient disk space.\n\nTool homepage: http://illumina.github.io/interop/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/illumina-interop:1.9.0--h503566f_0
stdout: illumina-interop.out
