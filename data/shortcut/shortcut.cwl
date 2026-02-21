cwlVersion: v1.2
class: CommandLineTool
baseCommand: shortcut
label: shortcut
doc: "The provided text appears to be a system log or error message from a container
  build process (Apptainer/Singularity) rather than the help text for the 'shortcut'
  tool itself. Consequently, no arguments or tool descriptions could be extracted.\n
  \nTool homepage: https://github.com/Aez35/ShortCut"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shortcut:1.0--hdfd78af_0
stdout: shortcut.out
