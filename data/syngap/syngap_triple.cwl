cwlVersion: v1.2
class: CommandLineTool
baseCommand: syngap triple
label: syngap_triple
doc: "Compare three species genomes and their annotations.\n\nTool homepage: https://github.com/yanyew/SynGAP"
inputs:
  - id: anno_key1
    type:
      - 'null'
      - string
    doc: Key in the attributes to extract for species1
    default: ID
    inputBinding:
      position: 101
      prefix: --annoKey1
  - id: anno_key2
    type:
      - 'null'
      - string
    doc: Key in the attributes to extract for species2
    default: ID
    inputBinding:
      position: 101
      prefix: --annoKey2
  - id: anno_key3
    type:
      - 'null'
      - string
    doc: Key in the attributes to extract for species3
    default: ID
    inputBinding:
      position: 101
      prefix: --annoKey3
  - id: anno_type1
    type:
      - 'null'
      - string
    doc: Feature type to extract for species1
    default: mRNA
    inputBinding:
      position: 101
      prefix: --annoType1
  - id: anno_type2
    type:
      - 'null'
      - string
    doc: Feature type to extract for species2
    default: mRNA
    inputBinding:
      position: 101
      prefix: --annoType2
  - id: anno_type3
    type:
      - 'null'
      - string
    doc: Feature type to extract for species3
    default: mRNA
    inputBinding:
      position: 101
      prefix: --annoType3
  - id: annoparent_key1
    type:
      - 'null'
      - string
    doc: Parent gene key to group with --primary_only in jcvi
    default: Parent
    inputBinding:
      position: 101
      prefix: --annoparentKey1
  - id: annoparent_key2
    type:
      - 'null'
      - string
    doc: Parent gene key to group with --primary_only in jcvi
    default: Parent
    inputBinding:
      position: 101
      prefix: --annoparentKey2
  - id: annoparent_key3
    type:
      - 'null'
      - string
    doc: Parent gene key to group with --primary_only in jcvi
    default: Parent
    inputBinding:
      position: 101
      prefix: --annoparentKey3
  - id: coverage
    type:
      - 'null'
      - float
    doc: Minimum percentage of query gene coverage of the HSP group in the 
      genBlast output
    default: 0.5
    inputBinding:
      position: 101
      prefix: --coverage
  - id: cscore
    type:
      - 'null'
      - float
    doc: C-score cutoff for jcvi
    default: 0.7
    inputBinding:
      position: 101
      prefix: --cscore
  - id: datatype
    type:
      - 'null'
      - string
    doc: The type of squences for jcvi, nucl|prot
    default: nucl
    inputBinding:
      position: 101
      prefix: --datatype
  - id: evalue
    type:
      - 'null'
      - float
    doc: Threshold for evalue in genBlast
    default: '1e-5'
    inputBinding:
      position: 101
      prefix: --evalue
  - id: intron
    type:
      - 'null'
      - string
    doc: Max intron size allowed for miniprot output
    default: 40k
    inputBinding:
      position: 101
      prefix: --intron
  - id: kmer1
    type:
      - 'null'
      - int
    doc: K-mer size for Indexing in miniprot
    default: 5
    inputBinding:
      position: 101
      prefix: --kmer1
  - id: kmer2
    type:
      - 'null'
      - int
    doc: K-mer size for the second round of chaining in miniprot
    default: 4
    inputBinding:
      position: 101
      prefix: --kmer2
  - id: outs
    type:
      - 'null'
      - float
    doc: Threshold of Score for miniprot output
    default: 0.95
    inputBinding:
      position: 101
      prefix: --outs
  - id: process
    type:
      - 'null'
      - string
    doc: Process for gapanno, genblastg|miniprot
    default: genblastg
    inputBinding:
      position: 101
      prefix: --process
  - id: rank
    type:
      - 'null'
      - int
    doc: The number of ranks in genBlast output
    default: 5
    inputBinding:
      position: 101
      prefix: --rank
  - id: sp1
    type:
      - 'null'
      - string
    doc: The short name for species1, e.g. Ath
    default: sp1
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
    default: sp2
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
  - id: sp3
    type:
      - 'null'
      - string
    doc: The short name for species2, e.g. Ath
    default: sp3
    inputBinding:
      position: 101
      prefix: --sp3
  - id: sp3fa
    type: File
    doc: The genome squence file (.fasta format) for species3
    inputBinding:
      position: 101
      prefix: --sp3fa
  - id: sp3gff
    type: File
    doc: The genome annotation file (.gff format) for species3
    inputBinding:
      position: 101
      prefix: --sp3gff
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 8
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
stdout: syngap_triple.out
