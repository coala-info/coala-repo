cwlVersion: v1.2
class: CommandLineTool
baseCommand: PREFACE.R
label: preface_PREFACE.R
doc: "The provided text does not contain help information or a description of the
  tool. It contains system logs and a fatal error regarding a container image build
  process.\n\nTool homepage: https://github.com/CenterForMedicalGeneticsGhent/PREFACE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/preface:0.1.2--hdfd78af_0
stdout: preface_PREFACE.R.out
