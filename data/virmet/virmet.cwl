cwlVersion: v1.2
class: CommandLineTool
baseCommand: virmet
label: virmet
doc: "A tool for viral metagenomics. (Note: The provided text is a container runtime
  error log and does not contain help documentation or argument definitions.)\n\n
  Tool homepage: https://github.com/medvir/VirMet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virmet:2.0.1--pyhdfd78af_0
stdout: virmet.out
