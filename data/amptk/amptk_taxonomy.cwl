cwlVersion: v1.2
class: CommandLineTool
baseCommand: amptk-assign_taxonomy.py
label: amptk_taxonomy
doc: "assign taxonomy to OTUs\n\nTool homepage: https://github.com/nextgenusfs/amptk"
inputs:
  - id: add2db
    type:
      - 'null'
      - File
    doc: Custom FASTA database to add to DB on the fly
    inputBinding:
      position: 101
      prefix: --add2db
  - id: cpus
    type:
      - 'null'
      - string
    doc: 'Number of CPUs. Default: auto'
    inputBinding:
      position: 101
      prefix: --cpus
  - id: db
    type:
      - 'null'
      - string
    doc: 'Pre-installed Databases: [ITS,ITS1,ITS2,16S,LSU,COI]'
    inputBinding:
      position: 101
      prefix: --db
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Remove Intermediate Files
    inputBinding:
      position: 101
      prefix: --debug
  - id: fasta
    type: File
    doc: FASTA input
    inputBinding:
      position: 101
      prefix: --fasta
  - id: fasta_db
    type:
      - 'null'
      - File
    doc: Alternative database of fasta sequences
    inputBinding:
      position: 101
      prefix: --fasta_db
  - id: local_blast
    type:
      - 'null'
      - File
    doc: Path to local Blast DB
    inputBinding:
      position: 101
      prefix: --local_blast
  - id: mapping_file
    type:
      - 'null'
      - File
    doc: 'Mapping file: QIIME format can have extra meta data columns'
    inputBinding:
      position: 101
      prefix: --mapping_file
  - id: method
    type:
      - 'null'
      - string
    doc: Taxonomy method
    inputBinding:
      position: 101
      prefix: --method
  - id: otu_table
    type:
      - 'null'
      - File
    doc: Append Taxonomy to OTU table
    inputBinding:
      position: 101
      prefix: --otu_table
  - id: rdp
    type:
      - 'null'
      - File
    doc: Path to RDP Classifier
    inputBinding:
      position: 101
      prefix: --rdp
  - id: rdp_cutoff
    type:
      - 'null'
      - float
    doc: RDP confidence value threshold
    inputBinding:
      position: 101
      prefix: --rdp_cutoff
  - id: rdp_db
    type:
      - 'null'
      - string
    doc: Training set for RDP Classifier
    inputBinding:
      position: 101
      prefix: --rdp_db
  - id: sintax_cutoff
    type:
      - 'null'
      - float
    doc: SINTAX threshold.
    inputBinding:
      position: 101
      prefix: --sintax_cutoff
  - id: sintax_db
    type:
      - 'null'
      - File
    doc: VSEARCH SINTAX Reference Database
    inputBinding:
      position: 101
      prefix: --sintax_db
  - id: tax_filter
    type:
      - 'null'
      - string
    doc: Retain only OTUs with match in OTU table
    inputBinding:
      position: 101
      prefix: --tax_filter
  - id: taxonomy
    type:
      - 'null'
      - File
    doc: Incorporate taxonomy calculated elsewhere, 2 column file
    inputBinding:
      position: 101
      prefix: --taxonomy
  - id: usearch
    type:
      - 'null'
      - string
    doc: USEARCH8 EXE
    inputBinding:
      position: 101
      prefix: --usearch
  - id: usearch_cutoff
    type:
      - 'null'
      - float
    doc: USEARCH percent ID threshold.
    inputBinding:
      position: 101
      prefix: --usearch_cutoff
  - id: usearch_db
    type:
      - 'null'
      - File
    doc: VSEARCH Reference Database
    inputBinding:
      position: 101
      prefix: --usearch_db
  - id: utax
    type:
      - 'null'
      - boolean
    doc: Run UTAX (requires usearch9)
    inputBinding:
      position: 101
      prefix: --utax
  - id: utax_cutoff
    type:
      - 'null'
      - float
    doc: UTAX confidence value threshold.
    inputBinding:
      position: 101
      prefix: --utax_cutoff
  - id: utax_db
    type:
      - 'null'
      - File
    doc: UTAX Reference Database
    inputBinding:
      position: 101
      prefix: --utax_db
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Output file (FASTA)
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
