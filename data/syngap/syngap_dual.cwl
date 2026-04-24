cwlVersion: v1.2
class: CommandLineTool
baseCommand: syngap dual
label: syngap_dual
doc: "Compare two species' genomes and annotations.\n\nTool homepage: https://github.com/yanyew/SynGAP"
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
  - id: coverage
    type:
      - 'null'
      - float
    doc: Minimum percentage of query gene coverage of the HSP group in the 
      genBlast output
    inputBinding:
      position: 101
      prefix: --coverage
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
      - float
    doc: Threshold for evalue in genBlast
    inputBinding:
      position: 101
      prefix: --evalue
  - id: intron
    type:
      - 'null'
      - string
    doc: Max intron size allowed for miniprot output
    inputBinding:
      position: 101
      prefix: --intron
  - id: kmer1
    type:
      - 'null'
      - int
    doc: K-mer size for Indexing in miniprot
    inputBinding:
      position: 101
      prefix: --kmer1
  - id: kmer2
    type:
      - 'null'
      - int
    doc: K-mer size for the second round of chaining in miniprot
    inputBinding:
      position: 101
      prefix: --kmer2
  - id: outs
    type:
      - 'null'
      - float
    doc: Threshold of Score for miniprot output
    inputBinding:
      position: 101
      prefix: --outs
  - id: process
    type:
      - 'null'
      - string
    doc: Process for gapanno, genblastg|miniprot
    inputBinding:
      position: 101
      prefix: --process
  - id: rank
    type:
      - 'null'
      - int
    doc: The number of ranks in genBlast output
    inputBinding:
      position: 101
      prefix: --rank
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
    doc: The genome squence file (.fasta format) for species1
    inputBinding:
      position: 101
      prefix: --sp1fa
  - id: sp1gff
    type: File
    doc: The genome annotation file (.gff format) for species1
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
    doc: The genome squence file (.fasta format) for species2
    inputBinding:
      position: 101
      prefix: --sp2fa
  - id: sp2gff
    type: File
    doc: The genome annotation file (.gff format) for species2
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
stdout: syngap_dual.out
