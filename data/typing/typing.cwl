cwlVersion: v1.2
class: CommandLineTool
baseCommand: typing
label: typing
doc: "The provided text is a log of a failed container build process (Singularity/Apptainer)
  for the 'typing' package and does not contain CLI help text, usage instructions,
  or argument definitions.\n\nTool homepage: https://github.com/danielmiessler/SecLists"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/typing:3.5.2.2--py36_0
stdout: typing.out
