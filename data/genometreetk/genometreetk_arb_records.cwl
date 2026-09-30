cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - genometreetk
  - arb_records
label: genometreetk_arb_records
doc: "Create an ARB records file from GTDB metadata.\n\nTool homepage: http://pypi.python.org/pypi/genometreetk/"
inputs:
  - id: metadata_file
    type: File
    doc: metadata file for all genomes in the GTDB
    inputBinding:
      position: 1
  - id: output_file
    type: string
    doc: output file with ARB records
    inputBinding:
      position: 2
  - id: genome_list
    type:
      - 'null'
      - File
    doc: create ARB records only for genome IDs in file
    inputBinding:
      position: 102
      prefix: --genome_list
  - id: msa_file
    type:
      - 'null'
      - File
    doc: aligned sequences to include in ARB records
    inputBinding:
      position: 102
      prefix: --msa_file
  - id: silent
    type:
      - 'null'
      - boolean
    doc: suppress output
    inputBinding:
      position: 102
      prefix: --silent
  - id: taxonomy_file
    type:
      - 'null'
      - File
    doc: taxonomy information to include in ARB records
    inputBinding:
      position: 102
      prefix: --taxonomy_file
outputs:
  - id: out_output_file
    type: File
    doc: output file with ARB records
    outputBinding:
      glob: '$(inputs.output_file)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genometreetk:0.1.6--py_2
