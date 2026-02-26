cwlVersion: v1.2
class: CommandLineTool
baseCommand: ionquant
label: ionquant
doc: "Please provide pass a license key with the --key argument. You may obtain a
  key by agreeing to the terms at https://msfragger.arsci.com/ionquant/.\n\nTool homepage:
  https://github.com/Nesvilab/IonQuant"
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
    dockerPull: quay.io/biocontainers/ionquant:1.11.9--py311hdfd78af_0
stdout: ionquant.out
