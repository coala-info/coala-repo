cwlVersion: v1.2
class: CommandLineTool
baseCommand: cpc2_CPC2_output_peptide.py
label: cpc2_CPC2_output_peptide.py
doc: "A script from the CPC2 (Coding Potential Calculator 2) suite. Note: The provided
  help text contains only system error messages regarding container execution and
  does not list command-line arguments.\n\nTool homepage: https://github.com/gao-lab/CPC2_standalone"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cpc2:1.0.1--hdfd78af_0
stdout: cpc2_CPC2_output_peptide.py.out
