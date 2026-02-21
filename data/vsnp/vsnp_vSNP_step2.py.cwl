cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp_vSNP_step2.py
label: vsnp_vSNP_step2.py
doc: "vSNP step 2 analysis tool\n\nTool homepage: https://github.com/USDA-VS/vSNP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp:2.03--hdfd78af_2
stdout: vsnp_vSNP_step2.py.out
