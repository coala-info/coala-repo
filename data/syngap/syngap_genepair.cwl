cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - syngap
  - genepair
label: syngap_genepair
doc: "Compares gene pairs between two species.\n\nTool homepage: https://github.com/yanyew/SynGAP"
inputs:
  - id: anno_key1
    type:
      - 'null'
      - string
    doc: Key in the attributes to extract for species1
    inputBinding:
      position: 101
      prefix: --annoKey1
  - id: anno_key2
    type:
      - 'null'
      - string
    doc: Key in the attributes to extract for species2
    inputBinding:
      position: 101
      prefix: --annoKey2
  - id: anno_type1
    type:
      - 'null'
      - string
    doc: Feature type to extract for species1
    inputBinding:
      position: 101
      prefix: --annoType1
  - id: anno_type2
    type:
      - 'null'
      - string
    doc: Feature type to extract for species2
    inputBinding:
      position: 101
      prefix: --annoType2
  - id: annoparent_key1
    type:
      - 'null'
      - string
    doc: Parent gene key to group with --primary_only in jcvi
    inputBinding:
      position: 101
      prefix: --annoparentKey1
  - id: annoparent_key2
    type:
      - 'null'
      - string
    doc: Parent gene key to group with --primary_only in jcvi
    inputBinding:
      position: 101
      prefix: --annoparentKey2
  - id: cscore
    type:
      - 'null'
      - float
    doc: C-score cutoff for jcvi
    inputBinding:
      position: 101
      prefix: --cscore
  - id: datatype
    type:
      - 'null'
      - string
    doc: The type of squences for jcvi, nucl|prot
    inputBinding:
      position: 101
      prefix: --datatype
  - id: evalue
    type:
      - 'null'
      - string
    doc: Threshold for evalue in two-way blast
    inputBinding:
      position: 101
      prefix: --evalue
  - id: itak
    type:
      - 'null'
      - string
    doc: Perform iTAK to identify TFs and kinases (only for plants), yse|no
    inputBinding:
      position: 101
      prefix: --iTAK
  - id: sp1
    type:
      - 'null'
      - string
    doc: The short name for species1, e.g. Ath
    inputBinding:
      position: 101
      prefix: --sp1
  - id: sp1fa
    type: File
    doc: The squence file (.fasta format) for species1
    inputBinding:
      position: 101
      prefix: --sp1fa
  - id: sp1gff
    type: File
    doc: The annotation file (.gff format) for species1
    inputBinding:
      position: 101
      prefix: --sp1gff
  - id: sp2
    type:
      - 'null'
      - string
    doc: The short name for species2, e.g. Ath
    inputBinding:
      position: 101
      prefix: --sp2
  - id: sp2fa
    type: File
    doc: The squence file (.fasta format) for species2
    inputBinding:
      position: 101
      prefix: --sp2fa
  - id: sp2gff
    type: File
    doc: The annotation file (.gff format) for species2
    inputBinding:
      position: 101
      prefix: --sp2gff
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/syngap:1.2.5--py312hdfd78af_0
stdout: syngap_genepair.out
