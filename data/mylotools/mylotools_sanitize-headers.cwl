cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mylotools
  - sanitize-headers
label: mylotools_sanitize-headers
doc: "Sanitize FASTA headers\n\nTool homepage: https://github.com/bluenote-1577/mylotools"
inputs:
  - id: fasta
    type: File
    doc: FASTA file to sanitize (will be modified in place)
    inputBinding:
      position: 101
      prefix: --fasta
  - id: no_backup
    type:
      - 'null'
      - boolean
    doc: 'Do not create a backup file (default: backup is created)'
    inputBinding:
      position: 101
      prefix: --no-backup
outputs:
  - id: sanitized_fasta
    type: File
    doc: The FASTA file with sanitized headers (modified in place)
    outputBinding:
      glob: $(inputs.fasta.basename)
  - id: backup
    type:
      - 'null'
      - File
    doc: Backup of the original FASTA file (not created with --no-backup)
    outputBinding:
      glob: $(inputs.fasta.basename).bak*
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fasta)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mylotools:2.0.0--pyh7e72e81_0
stdout: mylotools_sanitize-headers.out
