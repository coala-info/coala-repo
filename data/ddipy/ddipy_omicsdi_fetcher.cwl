cwlVersion: v1.2
class: CommandLineTool
baseCommand: ddipy_omicsdi_fetcher
label: ddipy_omicsdi_fetcher
doc: "A tool for fetching data from OmicsDI using the ddipy library. (Note: The provided
  help text contains system error messages regarding container execution and does
  not list specific command-line arguments.)\n\nTool homepage: https://github.com/OmicsDI/ddipy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ddipy:0.0.5--py_0
stdout: ddipy_omicsdi_fetcher.out
