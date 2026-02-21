cwlVersion: v1.2
class: CommandLineTool
baseCommand: hunspell-en-med
label: hunspell-en-med
doc: "English medical dictionary for Hunspell (Note: The provided text contained only
  system error logs and no CLI help information).\n\nTool homepage: https://github.com/glutanimate/hunspell-en-med-glut"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/hunspell-en-med:v0.0.20140410-1-deb_cv1
stdout: hunspell-en-med.out
