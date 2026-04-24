cwlVersion: v1.2
class: CommandLineTool
baseCommand: panorama write
label: panorama_write
doc: "Write annotation/metadata assigned to gene families in pangenomes\n\nTool homepage:
  https://github.com/labgem/panorama"
inputs:
  - id: annotations
    type:
      - 'null'
      - boolean
    doc: Write all the annotations from families for the given sources
    inputBinding:
      position: 101
      prefix: --annotations
  - id: disable_prog_bar
    type:
      - 'null'
      - boolean
    doc: disables the progress bars
    inputBinding:
      position: 101
      prefix: --disable_prog_bar
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force writing in output directory and in pangenome output file.
    inputBinding:
      position: 101
      prefix: --force
  - id: hmm
    type:
      - 'null'
      - boolean
    doc: Write an hmm for each gene families in pangenomes
    inputBinding:
      position: 101
      prefix: --hmm
  - id: log
    type:
      - 'null'
      - File
    doc: log output file
    inputBinding:
      position: 101
      prefix: --log
  - id: msa
    type:
      - 'null'
      - File
    doc: To create a HMM profile for families, you can give a msa of each gene 
      in families.This msa could be get from ppanggolin (See ppanggolin msa). 
      Should be a 2 column tsv file with pangenome name in first and path to MSA
      in second
    inputBinding:
      position: 101
      prefix: --msa
  - id: msa_format
    type:
      - 'null'
      - string
    doc: Format of the input MSA.
    inputBinding:
      position: 101
      prefix: --msa_format
  - id: pangenomes
    type:
      type: array
      items: File
    doc: A list of pangenome .h5 files in .tsv file
    inputBinding:
      position: 101
      prefix: --pangenomes
  - id: sources
    type:
      - 'null'
      - type: array
        items: string
    doc: Name of the annotation source where panorama as to select in pangenomes
    inputBinding:
      position: 101
      prefix: --sources
  - id: threads
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - int
    doc: Indicate verbose level (0 for warning and errors only, 1 for info, 2 
      for debug)
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panorama:1.0.0--pyhdfd78af_0
