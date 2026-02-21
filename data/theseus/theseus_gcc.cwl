cwlVersion: v1.2
class: CommandLineTool
baseCommand: theseus
label: theseus_gcc
doc: "Maximum likelihood multiple macromolecular structural alignment (Note: The provided
  text contains container build logs and error messages rather than CLI help text;
  therefore, no arguments could be extracted).\n\nTool homepage: https://github.com/theseus-os/Theseus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/theseus:v3.3.0-8-deb_cv1
stdout: theseus_gcc.out
