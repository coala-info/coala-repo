cwlVersion: v1.2
class: CommandLineTool
baseCommand: xxhash
label: xxhash
doc: "Fast non-cryptographic hash algorithm (Note: The provided text was an error
  log and did not contain help documentation).\n\nTool homepage: https://github.com/ifduyue/python-xxhash"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xxhash:1.0.1--py35_0
stdout: xxhash.out
