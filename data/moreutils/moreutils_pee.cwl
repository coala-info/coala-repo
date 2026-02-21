cwlVersion: v1.2
class: CommandLineTool
baseCommand: pee
label: moreutils_pee
doc: "Pipes standard input to the specified commands. It is similar to tee, but for
  pipes.\n\nTool homepage: https://github.com/madx/moreutils"
inputs:
  - id: commands
    type:
      type: array
      items: string
    doc: List of commands to which the standard input will be piped.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moreutils:0.5.7--1
stdout: moreutils_pee.out
