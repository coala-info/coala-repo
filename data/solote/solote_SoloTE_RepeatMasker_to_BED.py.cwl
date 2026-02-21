cwlVersion: v1.2
class: CommandLineTool
baseCommand: solote_SoloTE_RepeatMasker_to_BED.py
label: solote_SoloTE_RepeatMasker_to_BED.py
doc: "A tool to convert RepeatMasker output to BED format for SoloTE. (Note: The provided
  help text contains only container runtime error logs and does not list specific
  arguments.)\n\nTool homepage: https://github.com/bvaldebenitom/SoloTE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/solote:1.09--hdfd78af_0
stdout: solote_SoloTE_RepeatMasker_to_BED.py.out
