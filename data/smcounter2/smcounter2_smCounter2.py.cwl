cwlVersion: v1.2
class: CommandLineTool
baseCommand: smCounter2.py
label: smcounter2_smCounter2.py
doc: "The provided text does not contain help information for the tool, but appears
  to be a container runtime error log. No arguments could be extracted.\n\nTool homepage:
  https://github.com/qiaseq/qiaseq-smcounter-v2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smcounter2:0.1.2018.08.28--py27r351_0
stdout: smcounter2_smCounter2.py.out
