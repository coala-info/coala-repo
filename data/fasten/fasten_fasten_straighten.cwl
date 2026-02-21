cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fasten
  - straighten
label: fasten_fasten_straighten
doc: "The provided text does not contain help information, but appears to be a system
  error log indicating a failure to build or run the 'fasten' container due to lack
  of disk space. No arguments could be extracted.\n\nTool homepage: https://github.com/lskatz/fasten"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fasten:0.9.0--hc1c3326_0
stdout: fasten_fasten_straighten.out
