cwlVersion: v1.2
class: CommandLineTool
baseCommand: pypgatk blast_get_position
label: pypgatk_blast_get_position
doc: "Get the position of peptides in a reference database.\n\nTool homepage: http://github.com/bigbio/py-pgatk"
inputs:
  - id: config_file
    type:
      - 'null'
      - File
    doc: Configuration file for the fdr peptides pipeline.
    inputBinding:
      position: 101
      prefix: --config_file
  - id: input_psm_to_blast
    type:
      - 'null'
      - File
    doc: The file name of the input PSM table to blast.
    inputBinding:
      position: 101
      prefix: --input_psm_to_blast
  - id: input_reference_database
    type:
      - 'null'
      - File
    doc: The file name of the refence protein database to blast. The reference 
      database includes Uniprot Proteomes with isoforms, ENSEMBL, RefSeq, etc.
    inputBinding:
      position: 101
      prefix: --input_reference_database
  - id: number_of_processes
    type:
      - 'null'
      - int
    doc: Used to specify the number of processes.
    default: 40
    inputBinding:
      position: 101
      prefix: --number_of_processes
outputs:
  - id: output_psm
    type:
      - 'null'
      - File
    doc: The file name of the output PSM table.
    outputBinding:
      glob: $(inputs.output_psm)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgatk:0.0.24--pyhdfd78af_0
