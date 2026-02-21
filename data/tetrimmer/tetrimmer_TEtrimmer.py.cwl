cwlVersion: v1.2
class: CommandLineTool
baseCommand: TEtrimmer.py
label: tetrimmer_TEtrimmer.py
doc: "TEtrimmer (Note: The provided help text contains only container execution errors
  and no usage information.)\n\nTool homepage: https://github.com/qjiangzhao/TETrimmer.git"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tetrimmer:1.6.2--hdfd78af_0
stdout: tetrimmer_TEtrimmer.py.out
