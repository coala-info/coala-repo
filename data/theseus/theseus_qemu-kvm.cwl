cwlVersion: v1.2
class: CommandLineTool
baseCommand: theseus
label: theseus_qemu-kvm
doc: "Maximum likelihood superpositioning and analysis of macromolecular structures
  (Note: The provided text is a container build log and does not contain usage instructions
  or argument definitions).\n\nTool homepage: https://github.com/theseus-os/Theseus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/theseus:v3.3.0-8-deb_cv1
stdout: theseus_qemu-kvm.out
