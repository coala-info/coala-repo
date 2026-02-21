cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribowaltz
label: ribowaltz
doc: "The provided text does not contain help information for ribowaltz; it contains
  error logs from a container build process. No arguments could be extracted.\n\n
  Tool homepage: https://github.com/LabTranslationalArchitectomics/riboWaltz"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribowaltz:2.0--r44hdfd78af_1
stdout: ribowaltz.out
