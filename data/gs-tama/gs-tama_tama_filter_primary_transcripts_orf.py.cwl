cwlVersion: v1.2
class: CommandLineTool
baseCommand: gs-tama_tama_filter_primary_transcripts_orf.py
label: gs-tama_tama_filter_primary_transcripts_orf.py
doc: "A tool for filtering primary transcripts based on Open Reading Frame (ORF) information.
  (Note: The provided help text contained only system error messages regarding container
  execution and did not list specific command-line arguments).\n\nTool homepage: https://github.com/sguizard/gs-tama"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
stdout: gs-tama_tama_filter_primary_transcripts_orf.py.out
