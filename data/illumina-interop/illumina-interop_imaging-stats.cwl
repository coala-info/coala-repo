cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - imaging-stats
label: illumina-interop_imaging-stats
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to build or run the container due
  to insufficient disk space.\n\nTool homepage: http://illumina.github.io/interop/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/illumina-interop:1.9.0--h503566f_0
stdout: illumina-interop_imaging-stats.out
