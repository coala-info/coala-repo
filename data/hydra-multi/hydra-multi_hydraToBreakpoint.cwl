cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hydra-multi
  - hydraToBreakpoint
label: hydra-multi_hydraToBreakpoint
doc: "A tool within the hydra-multi suite, likely used for converting multi-alignment
  data to breakpoint format. (Note: The provided help text contains system error messages
  regarding container execution and does not list specific command-line arguments).\n
  \nTool homepage: https://github.com/arq5x/Hydra"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hydra-multi:0.5.4--py27h5ca1c30_4
stdout: hydra-multi_hydraToBreakpoint.out
