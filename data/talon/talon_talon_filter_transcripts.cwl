cwlVersion: v1.2
class: CommandLineTool
baseCommand: talon_filter_transcripts
label: talon_talon_filter_transcripts
doc: "The provided text does not contain help information for the tool. It appears
  to be a container execution error log.\n\nTool homepage: https://github.com/mortazavilab/TALON"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/talon:6.0.1--pyhdfd78af_0
stdout: talon_talon_filter_transcripts.out
