cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp_vSNP_step1.py
label: vsnp_vSNP_step1.py
doc: "vSNP step 1 script (Note: The provided text contains container runtime error
  logs rather than tool help text; no arguments could be parsed from the input).\n
  \nTool homepage: https://github.com/USDA-VS/vSNP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp:2.03--hdfd78af_2
stdout: vsnp_vSNP_step1.py.out
