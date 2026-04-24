cwlVersion: v1.2
class: CommandLineTool
baseCommand: ogs_merge
label: gogstools_ogs_merge
doc: "Merges two GFF files to create a new OGS annotation.\n\nTool homepage: https://github.com/genouest/ogs-tools"
inputs:
  - id: genome
    type: File
    doc: Genome file (fasta)
    inputBinding:
      position: 1
  - id: ogs_name
    type: string
    doc: Name of the new OGS
    inputBinding:
      position: 2
  - id: id_regex
    type: string
    doc: Regex with a capturing group around the incremental part of gene ids, 
      and a second one around the version suffix (e.g. 
      'GSSPF[GPT]([0-9]{8})[0-9]{3}(\.[0-9]+)?')
    inputBinding:
      position: 3
  - id: id_syntax
    type: string
    doc: String representing a gene id, with {id} where the incremental part of 
      the id should be placed (e.g. 'GSSPFG{id}001')
    inputBinding:
      position: 4
  - id: base_gff
    type: File
    doc: The gff from the base annotation (usually automatic annotation)
    inputBinding:
      position: 5
  - id: apollo_gff
    type: File
    doc: The gff from the new Apollo valid annotation
    inputBinding:
      position: 6
  - id: deleted
    type:
      - 'null'
      - File
    doc: File containing a list of mRNAs to remove
    inputBinding:
      position: 107
      prefix: --deleted
  - id: out_prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files
    inputBinding:
      position: 107
      prefix: --out_prefix
  - id: previous_gff
    type:
      - 'null'
      - File
    doc: The gff from the previous annotation version (if different than 
      <base_gff>)
    inputBinding:
      position: 107
      prefix: --previous_gff
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gogstools:0.1.2--py310hdfd78af_0
stdout: gogstools_ogs_merge.out
