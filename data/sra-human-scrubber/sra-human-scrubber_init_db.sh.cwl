cwlVersion: v1.2
class: CommandLineTool
baseCommand: sra-human-scrubber_init_db.sh
label: sra-human-scrubber_init_db.sh
doc: "Initialize the database for SRA Human Scrubber. Note: The provided text appears
  to be a system log/error message rather than help text, so no arguments could be
  extracted.\n\nTool homepage: https://github.com/ncbi/sra-human-scrubber"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sra-human-scrubber:2.2.1--hdfd78af_0
stdout: sra-human-scrubber_init_db.sh.out
