cwlVersion: v1.2
class: CommandLineTool
baseCommand: lissero
label: lissero
doc: "In silico serogroup prediction for L. monocytogenes. Alleles: lmo1118, lmo0737,
  ORF2819, ORF2110, Prs\n\nTool homepage: https://github.com/MDU-PHL/lissero"
inputs:
  - id: fasta_files
    type:
      type: array
      items: File
    doc: FASTA files to process
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debug mode
    inputBinding:
      position: 102
      prefix: --debug
  - id: logfile
    type:
      - 'null'
      - File
    doc: Save log to a file instead of printing to stderr
    inputBinding:
      position: 102
      prefix: --logfile
  - id: min_cov
    type:
      - 'null'
      - float
    doc: Minimum coverage of the gene to accept a match. [0-100]
    inputBinding:
      position: 102
      prefix: --min_cov
  - id: min_id
    type:
      - 'null'
      - float
    doc: Minimum percent identity to accept a match. [0-100]
    inputBinding:
      position: 102
      prefix: --min_id
  - id: serotype_db
    type:
      - 'null'
      - Directory
    doc: Serotype database path
    inputBinding:
      position: 102
      prefix: --serotype_db
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lissero:0.4.10--pyhdfd78af_0
stdout: lissero.out
