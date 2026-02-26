cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pypgatk
  - ensembl-check
label: pypgatk_ensembl-check
doc: "Perform Ensembl database check\n\nTool homepage: http://github.com/bigbio/py-pgatk"
inputs:
  - id: add_stop_codons
    type:
      - 'null'
      - boolean
    doc: If a stop codons is found, add a new protein with suffix (_Codon_{num})
    inputBinding:
      position: 101
      prefix: --add_stop_codons
  - id: config_file
    type:
      - 'null'
      - string
    doc: Configuration to perform Ensembl database check
    inputBinding:
      position: 101
      prefix: --config_file
  - id: input_fasta
    type:
      - 'null'
      - File
    doc: input_fasta file to perform the translation
    inputBinding:
      position: 101
      prefix: --input_fasta
  - id: num_aa
    type:
      - 'null'
      - int
    doc: Minimun number of aminoacids for a protein to be included in the 
      database
    inputBinding:
      position: 101
      prefix: --num_aa
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output File
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgatk:0.0.24--pyhdfd78af_0
