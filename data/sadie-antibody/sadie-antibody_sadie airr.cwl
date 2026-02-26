cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sadie
  - airr
label: sadie-antibody_sadie airr
doc: "Run the AIRR annotation pipeline from the command line on a single file or a
  directory of abi files.\n\n  if you give a directory of abi files, it will combine
  all the records into a\n  single file and annotate that.\n\n  if you do not provide
  an output, the default is airr .tsv file\n\nTool homepage: https://sadie.jordanrwillis.com"
inputs:
  - id: input_path
    type: File
    doc: Input path (file or directory of abi files)
    inputBinding:
      position: 1
  - id: skip_igl
    type:
      - 'null'
      - boolean
    doc: Skip the igl assignment
    inputBinding:
      position: 102
      prefix: --skip-igl
  - id: skip_mutation
    type:
      - 'null'
      - boolean
    doc: Skip the somewhat time instansive mutational analysis
    inputBinding:
      position: 102
      prefix: --skip-mutation
  - id: species
    type:
      - 'null'
      - string
    doc: Species to annotate
    inputBinding:
      position: 102
      prefix: --name
outputs:
  - id: output_path
    type:
      - 'null'
      - File
    doc: Output path (default is airr .tsv file)
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sadie-antibody:2.0.0--pyhdfd78af_0
