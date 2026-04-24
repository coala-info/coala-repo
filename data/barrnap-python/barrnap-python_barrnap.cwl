cwlVersion: v1.2
class: CommandLineTool
baseCommand: barrnap
label: barrnap-python_barrnap
doc: "This is barrnap 0.9\n\nTool homepage: https://github.com/nickp60/barrnap-python"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input file to scan for rRNA genes
    inputBinding:
      position: 1
  - id: database
    type:
      - 'null'
      - File
    doc: 'Using database: /usr/local/lib/barrnap/bin/../db/bac.hmm'
    inputBinding:
      position: 102
  - id: evalue_cutoff
    type:
      - 'null'
      - float
    doc: Setting evalue cutoff to 1e-06
    inputBinding:
      position: 102
  - id: reject_genes_short
    type:
      - 'null'
      - float
    doc: Will reject genes < 0.25 of expected length.
    inputBinding:
      position: 102
  - id: tag_genes_short
    type:
      - 'null'
      - float
    doc: Will tag genes < 0.8 of expected length.
    inputBinding:
      position: 102
  - id: threads
    type:
      - 'null'
      - int
    doc: Will use 1 threads
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/barrnap-python:0.0.5--py36_1
stdout: barrnap-python_barrnap.out
