cwlVersion: v1.2
class: CommandLineTool
baseCommand: hunspell
label: hunspell-en-med_hunspell
doc: "Hunspell is a spell checker and morphological analyzer. This specific version
  appears to be packaged with medical English dictionaries.\n\nTool homepage: https://github.com/glutanimate/hunspell-en-med-glut"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/hunspell-en-med:v0.0.20140410-1-deb_cv1
stdout: hunspell-en-med_hunspell.out
