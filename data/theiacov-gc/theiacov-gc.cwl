cwlVersion: v1.2
class: CommandLineTool
baseCommand: theiacov-gc
label: theiacov-gc
doc: "TheiaCoV GC content calculation tool (Note: The provided text is a container
  execution error log and does not contain help documentation or argument definitions).\n
  \nTool homepage: https://github.com/theiagen/public_health_viral_genomics"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/theiacov-gc:2.3.2--hdfd78af_0
stdout: theiacov-gc.out
