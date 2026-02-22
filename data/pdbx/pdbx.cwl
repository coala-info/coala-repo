cwlVersion: v1.2
class: CommandLineTool
baseCommand: pdbx
label: pdbx
doc: "The provided text contains system error logs regarding a failed container pull/build
  (no space left on device) and does not contain help text or usage information for
  the pdbx tool.\n\nTool homepage: https://github.com/soedinglab/pdbx"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pdbx:1.0.0--py311hdbdd923_1
stdout: pdbx.out
