cwlVersion: v1.2
class: CommandLineTool
baseCommand: illumina-interop_summary
label: illumina-interop_summary
doc: "The provided text is an error log indicating a failure to pull or build the
  container image ('no space left on device') and does not contain the help text or
  usage information for the tool.\n\nTool homepage: http://illumina.github.io/interop/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/illumina-interop:1.9.0--h503566f_0
stdout: illumina-interop_summary.out
