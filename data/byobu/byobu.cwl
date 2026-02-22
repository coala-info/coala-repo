cwlVersion: v1.2
class: CommandLineTool
baseCommand: byobu
label: byobu
doc: "Byobu is a text-based window manager and terminal multiplexer.\n\nTool homepage:
  https://github.com/dustinkirkland/byobu"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/byobu:5.98--hb42da9c_2
stdout: byobu.out
