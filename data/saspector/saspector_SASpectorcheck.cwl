cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - SASpector
  - check
label: saspector_SASpectorcheck
doc: "SASpector check utility (Note: The provided text is a container build error
  log and does not contain tool help information or argument definitions).\n\nTool
  homepage: https://github.com/alejocrojo09/SASpector"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/saspector:0.0.5--pyhdfd78af_0
stdout: saspector_SASpectorcheck.out
