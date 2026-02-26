cwlVersion: v1.2
class: CommandLineTool
baseCommand: fragpipe
label: fragpipe
doc: "Please accept the academic license.\n\nFragPipe uses tools that are available
  freely for academic research and educational purposes only.\n\nPlease provide license
  keys for MSFragger and IonQuant with the --msfragger_key and --ionquant_key flags.
  By passing these, you verify that you have read the ACADEMIC licenses for the MSFragger
  and IonQuant tools. You may obtain these keys by agreeing to the terms at http://msfragger-upgrader.nesvilab.org/upgrader/
  and https://msfragger.arsci.com/ionquant/.\n\nTool homepage: https://github.com/Nesvilab/FragPipe"
inputs:
  - id: ionquant_key
    type:
      - 'null'
      - string
    doc: License key for IonQuant
    inputBinding:
      position: 101
      prefix: --ionquant_key
  - id: msfragger_key
    type:
      - 'null'
      - string
    doc: License key for MSFragger
    inputBinding:
      position: 101
      prefix: --msfragger_key
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fragpipe:24.0--hdfd78af_0
stdout: fragpipe.out
