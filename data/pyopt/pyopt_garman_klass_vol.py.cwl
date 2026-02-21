cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyopt_garman_klass_vol.py
label: pyopt_garman_klass_vol.py
doc: "A tool for calculating Garman-Klass volatility (Note: The provided text contains
  container build logs rather than command-line help documentation).\n\nTool homepage:
  https://github.com/boyac/pyOptionPricing"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyopt:1.2.0--py27_1
stdout: pyopt_garman_klass_vol.py.out
