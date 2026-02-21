cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svtools
  - genotype
label: svtools_svtools genotype
doc: "Genotype structural variants. (Note: The provided text contains container runtime
  error messages and does not include the tool's help documentation or argument definitions.)\n
  \nTool homepage: https://github.com/hall-lab/svtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtools:0.5.1--py_0
stdout: svtools_svtools genotype.out
