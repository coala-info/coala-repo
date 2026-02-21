cwlVersion: v1.2
class: CommandLineTool
baseCommand: validate-fasta-database
label: validate-fasta-database
doc: "A tool to validate FASTA database files. (Note: The provided text contains only
  system logs and error messages; no specific command-line arguments or usage instructions
  were found in the input.)\n\nTool homepage: https://github.com/caleb-easterly/validate_fasta_database"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/validate-fasta-database:1.0--hdfd78af_2
stdout: validate-fasta-database.out
