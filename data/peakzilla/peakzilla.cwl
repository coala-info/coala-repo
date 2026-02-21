cwlVersion: v1.2
class: CommandLineTool
baseCommand: peakzilla
label: peakzilla
doc: "The provided text does not contain help information as the executable was not
  found in the environment.\n\nTool homepage: https://github.com/steinmann/peakzilla"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peakzilla:1.0--py36_1
stdout: peakzilla.out
