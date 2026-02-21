cwlVersion: v1.2
class: CommandLineTool
baseCommand: domsearch
label: embassy-domsearch
doc: The provided text contains only system error messages related to a container
  runtime failure (no space left on device) and does not include the actual help text
  or usage information for the tool. Consequently, no arguments could be extracted.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/embassy-domsearch:v1-0.1.660-3-deb_cv1
stdout: embassy-domsearch.out
