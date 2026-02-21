cwlVersion: v1.2
class: CommandLineTool
baseCommand: art_ps
label: art_ps
doc: "A tool that displays a list of currently running processes, including PID, user,
  time, and command information.\n\nTool homepage: https://github.com/jlevy/the-art-of-command-line"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/art:2016.06.05--h0704011_13
stdout: art_ps.out
