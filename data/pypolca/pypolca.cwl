cwlVersion: v1.2
class: CommandLineTool
baseCommand: pypolca
label: pypolca
doc: "A Python implementation of the POLCA (POLishing CleAn) tool for genomic assembly
  polishing. (Note: The provided text appears to be a container execution error log
  rather than the tool's help text; therefore, no arguments could be extracted.)\n
  \nTool homepage: https://github.com/gbouras13/pypolca"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypolca:0.4.0--pyhdfd78af_0
stdout: pypolca.out
