cwlVersion: v1.2
class: CommandLineTool
baseCommand: pMMRCalculator.py
label: pmmrcalculator_pMMRCalculator.py
doc: "A tool for pMMR (proficient Mismatch Repair) calculation. Note: The provided
  text contains container runtime error logs rather than command-line help documentation,
  so no arguments could be extracted.\n\nTool homepage: https://github.com/TCLamnidis/pMMRCalculator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pmmrcalculator:1.1.0--hdfd78af_0
stdout: pmmrcalculator_pMMRCalculator.py.out
