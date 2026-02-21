cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp3_vsnp3_step2.py
label: vsnp3_vsnp3_step2.py
doc: "Step 2 of the vSNP3 pipeline. Note: The provided text appears to be a container
  runtime error log rather than the tool's help output, so no arguments could be extracted.\n
  \nTool homepage: https://github.com/USDA-VS/vsnp3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp3:3.32--hdfd78af_0
stdout: vsnp3_vsnp3_step2.py.out
