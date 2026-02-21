cwlVersion: v1.2
class: CommandLineTool
baseCommand: prepare_transcripts
label: ribocode_prepare_transcripts
doc: "The provided text is a container execution error log and does not contain CLI
  help information or argument definitions.\n\nTool homepage: https://github.com/xryanglab/RiboCode"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribocode:1.2.15--pyhdc42f0e_1
stdout: ribocode_prepare_transcripts.out
