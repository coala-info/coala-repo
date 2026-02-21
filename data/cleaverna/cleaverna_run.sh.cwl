cwlVersion: v1.2
class: CommandLineTool
baseCommand: cleaverna_run.sh
label: cleaverna_run.sh
doc: "CleaveRNA tool (Note: The provided text is a container build error log and does
  not contain usage information or argument definitions).\n\nTool homepage: https://github.com/reyhaneh-tavakoli/CleaveRNA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cleaverna:1.0.0--pyhdfd78af_0
stdout: cleaverna_run.sh.out
