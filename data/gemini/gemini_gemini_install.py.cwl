cwlVersion: v1.2
class: CommandLineTool
baseCommand: gemini_gemini_install.py
label: gemini_gemini_install.py
doc: "A script to install the GEMINI (Genome MINIng) framework. Note: The provided
  text contains execution logs and error messages rather than standard help documentation.\n
  \nTool homepage: https://github.com/arq5x/gemini"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
stdout: gemini_gemini_install.py.out
