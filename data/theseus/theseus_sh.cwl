cwlVersion: v1.2
class: CommandLineTool
baseCommand: theseus
label: theseus_sh
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a log of a failed container build or execution attempt.\n\nTool homepage:
  https://github.com/theseus-os/Theseus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/theseus:v3.3.0-8-deb_cv1
stdout: theseus_sh.out
