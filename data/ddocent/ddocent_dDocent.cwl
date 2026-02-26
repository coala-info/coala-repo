cwlVersion: v1.2
class: CommandLineTool
baseCommand: ddocent
label: ddocent_dDocent
doc: "dDocent 2.9.8\n\nTool homepage: https://ddocent.com"
inputs:
  - id: individuals_detected_correct
    type: string
    doc: Indicates if the detected number of individuals is correct (yes/no)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ddocent:2.9.8--hdfd78af_0
stdout: ddocent_dDocent.out
