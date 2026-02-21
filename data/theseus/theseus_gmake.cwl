cwlVersion: v1.2
class: CommandLineTool
baseCommand: theseus_gmake
label: theseus_gmake
doc: "The provided text does not contain help information or documentation for the
  tool; it is a log of a failed container build process.\n\nTool homepage: https://github.com/theseus-os/Theseus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/theseus:v3.3.0-8-deb_cv1
stdout: theseus_gmake.out
