cwlVersion: v1.2
class: CommandLineTool
baseCommand: fates-emerald
label: fates-emerald
doc: "FATES-EMERALD (Note: The provided text contains system error messages regarding
  container execution and does not include the tool's help documentation. No arguments
  could be extracted.)\n\nTool homepage: https://github.com/conda-forge/fates-emerald-feedstock"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fates-emerald:2.0.1
stdout: fates-emerald.out
