cwlVersion: v1.2
class: CommandLineTool
baseCommand: theseus_mtools
label: theseus_mtools
doc: "Maximum likelihood multiple sequence alignment and superposition toolset.\n\n
  Tool homepage: https://github.com/theseus-os/Theseus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/theseus:v3.3.0-8-deb_cv1
stdout: theseus_mtools.out
