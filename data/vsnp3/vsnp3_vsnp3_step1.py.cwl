cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp3_vsnp3_step1.py
label: vsnp3_vsnp3_step1.py
doc: "vSNP3 step 1 script. Note: The provided text contains container runtime logs
  and error messages rather than tool help documentation, so no arguments could be
  extracted.\n\nTool homepage: https://github.com/USDA-VS/vsnp3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp3:3.32--hdfd78af_0
stdout: vsnp3_vsnp3_step1.py.out
