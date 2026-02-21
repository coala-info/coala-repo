cwlVersion: v1.2
class: CommandLineTool
baseCommand: svclone
label: svclone
doc: "Structural variant clonal reconstruction tool (Note: The provided text is a
  container build log and does not contain help documentation or argument definitions).\n
  \nTool homepage: https://github.com/mcmero/SVclone"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svclone:1.1.4--pyr44hdfd78af_0
stdout: svclone.out
