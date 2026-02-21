cwlVersion: v1.2
class: CommandLineTool
baseCommand: viral_consensus
label: viral_consensus
doc: "A tool for viral consensus sequence generation (Note: The provided text appears
  to be a container build error log rather than help text, so no arguments could be
  extracted).\n\nTool homepage: https://github.com/niemasd/ViralConsensus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-host-hunter:0.2.0--pyhdfd78af_1
stdout: viral_consensus.out
