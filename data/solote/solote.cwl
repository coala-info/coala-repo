cwlVersion: v1.2
class: CommandLineTool
baseCommand: solote
label: solote
doc: "The provided text does not contain help information or a description of the
  tool; it appears to be a log of a failed container build/pull process.\n\nTool homepage:
  https://github.com/bvaldebenitom/SoloTE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/solote:1.09--hdfd78af_0
stdout: solote.out
