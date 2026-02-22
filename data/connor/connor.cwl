cwlVersion: v1.2
class: CommandLineTool
baseCommand: connor
label: connor
doc: "A tool for deduplicating BAM files using Unique Molecular Identifiers (UMIs).
  (Note: The provided text contains system error messages regarding disk space and
  container conversion rather than the tool's help documentation; therefore, no arguments
  could be extracted.)\n\nTool homepage: https://github.com/umich-brcf-bioinf/Connor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connor:0.6.1--py_0
stdout: connor.out
