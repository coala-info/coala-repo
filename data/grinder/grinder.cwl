cwlVersion: v1.2
class: CommandLineTool
baseCommand: grinder
label: grinder
doc: "A versatile amplicon and shotgun sequence simulator\n\nTool homepage: https://github.com/rcoh/angle-grinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/grinder:v0.5.4-5-deb_cv1
stdout: grinder.out
