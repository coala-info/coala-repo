cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyopt_black_scholes.py
label: pyopt_black_scholes.py
doc: "Black-Scholes option pricing tool (Note: The provided input text contains container
  runtime error logs rather than the tool's help documentation.)\n\nTool homepage:
  https://github.com/boyac/pyOptionPricing"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyopt:1.2.0--py27_1
stdout: pyopt_black_scholes.py.out
