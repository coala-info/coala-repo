cwlVersion: v1.2
class: CommandLineTool
baseCommand: msfragger
label: msfragger
doc: "Please provide pass a license key with the --key argument. You may obtain a
  key by agreeing to the terms at msfragger-upgrader.nesvilab.org/upgrader/.\n\nTool
  homepage: https://github.com/Nesvilab/MSFragger"
inputs:
  - id: key
    type: string
    doc: license key
    inputBinding:
      position: 101
      prefix: --key
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msfragger:4.2--py311hdfd78af_0
stdout: msfragger.out
