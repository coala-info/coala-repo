cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncbi-blast-plus-legacy
label: ncbi-blast-plus-legacy
doc: The provided text is a system error log indicating a failure to initialize the
  container environment (no space left on device) and does not contain help text or
  usage information for the tool.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ncbi-blast-plus-legacy:v2.8.1-1-deb_cv1
stdout: ncbi-blast-plus-legacy.out
