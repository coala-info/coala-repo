cwlVersion: v1.2
class: CommandLineTool
baseCommand: syngap master
label: syngap_master
doc: "This tool appears to be a master script for processing genomic data, likely
  involving species comparison and annotation.\n\nTool homepage: https://github.com/yanyew/SynGAP"
inputs:
  - id: annotation_key1
    type:
      - 'null'
      - string
    doc: Key in the attributes to extract for species1
    default: ID
    inputBinding:
      position: 101
      prefix: --annoKey1
  - id: annotation_parent_key1
    type:
      - 'null'
      - string
    doc: Parent gene key to group with --primary_only in jcvi
    default: Parent
    inputBinding:
      position: 101
      prefix: --annoparentKey1
  - id: annotation_type1
    type:
      - 'null'
      - string
    doc: Feature type to extract for species1
    default: mRNA
    inputBinding:
      position: 101
      prefix: --annoType1
  - id: coverage_threshold
    type:
      - 'null'
      - float
    doc: Minimum percentage of query gene coverage of the HSP group in the 
      genBlast output
    default: 0.5
    inputBinding:
      position: 101
      prefix: --coverage
  - id: cscore_cutoff
    type:
      - 'null'
      - float
    doc: C-score cutoff for jcvi
    default: 0.7
    inputBinding:
      position: 101
      prefix: --cscore
  - id: data_type
    type:
      - 'null'
      - string
    doc: The type of squences for jcvi, nucl|prot
    default: nucl
    inputBinding:
      position: 101
      prefix: --datatype
  - id: evalue_threshold
    type:
      - 'null'
      - string
    doc: Threshold for evalue in genBlast
    default: '1e-5'
    inputBinding:
      position: 101
      prefix: --evalue
  - id: kmer1_size
    type:
      - 'null'
      - int
    doc: K-mer size for Indexing in miniprot
    default: 5
    inputBinding:
      position: 101
      prefix: --kmer1
  - id: kmer2_size
    type:
      - 'null'
      - int
    doc: K-mer size for the second round of chaining in miniprot
    default: 4
    inputBinding:
      position: 101
      prefix: --kmer2
  - id: max_intron_size
    type:
      - 'null'
      - string
    doc: Max intron size allowed for miniprot output
    default: 40k
    inputBinding:
      position: 101
      prefix: --intron
  - id: miniprot_output_score_threshold
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
  - id: rank_number
    type:
      - 'null'
      - int
    doc: The number of ranks in genBlast output
    default: 5
    inputBinding:
      position: 101
      prefix: --rank
  - id: species1_fasta
    type: File
    doc: The genome squence file (.fasta format) for species1
    inputBinding:
      position: 101
      prefix: --sp1fa
  - id: species1_gff
    type: File
    doc: The genome annotation file (.gff format) for species1
    inputBinding:
      position: 101
      prefix: --sp1gff
  - id: species1_short_name
    type:
      - 'null'
      - string
    doc: The short name for species1, e.g. Ath
    default: sp1
    inputBinding:
      position: 101
      prefix: --sp1
  - id: species_type
    type: string
    doc: The species type of the polished object, plant|animal
    inputBinding:
      position: 101
      prefix: --sp
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
stdout: syngap_master.out
