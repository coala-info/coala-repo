cwlVersion: v1.2
class: CommandLineTool
baseCommand: mOTUconverts.py
label: motulizer_mOTUconvert.py
doc: "Converts output of diverse software generatig COGs, or genetically encoded traits
  into a genome2gene_clusters-JSON file useable by mOTUpan\n\nTool homepage: https://github.com/moritzbuck/mOTUlizer/"
inputs:
  - id: input
    type:
      - 'null'
      - string
    doc: input file(s), check '--list' for specifics
    inputBinding:
      position: 1
  - id: count
    type:
      - 'null'
      - boolean
    doc: count the occurences of COG/trait
    inputBinding:
      position: 102
      prefix: --count
  - id: gene2genome
    type:
      - 'null'
      - File
    doc: if gene names not '${genome_name}_[0-9]*', a tab separated file with id
      of gene in the fist column and a semi-column separated second column 
      containing genomes_id of genomes containing it
    inputBinding:
      position: 102
      prefix: --gene2genome
  - id: in_type
    type:
      - 'null'
      - string
    doc: software generating the input
    inputBinding:
      position: 102
      prefix: --in_type
  - id: list
    type:
      - 'null'
      - boolean
    doc: list tools available and exit
    inputBinding:
      position: 102
      prefix: --list
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: send output to this file defaults to stdout
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/motulizer:0.3.2--pyhdfd78af_0
