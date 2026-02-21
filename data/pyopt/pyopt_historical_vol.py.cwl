cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyopt_historical_vol.py
label: pyopt_historical_vol.py
doc: "A tool for calculating historical volatility (Note: The provided text contains
  system error logs rather than command-line help documentation).\n\nTool homepage:
  https://github.com/boyac/pyOptionPricing"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyopt:1.2.0--py27_1
stdout: pyopt_historical_vol.py.out
