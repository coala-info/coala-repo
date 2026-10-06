cwlVersion: v1.2
class: CommandLineTool
baseCommand: bmtagger.sh
label: bmtagger_bmtagger.sh
doc: "Identify and tag sequences that match a reference genome.\n\nTool homepage:
  https://github.com/movingpictures83/BMTagger"
inputs:
  - id: accession
    type:
      - 'null'
      - string
    doc: Accession identifier
    inputBinding:
      position: 101
      prefix: -A
  - id: blacklist
    type:
      - 'null'
      - string
    doc: Output blacklist file
    inputBinding:
      position: 101
      prefix: -o
  - id: config
    type:
      - 'null'
      - File
    doc: Configuration file
    inputBinding:
      position: 101
      prefix: -C
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Leave temporary data on exit
    inputBinding:
      position: 101
      prefix: --debug
  - id: extract
    type:
      - 'null'
      - boolean
    doc: Generate fasta or fastq files which will NOT contain tagged sequences
    inputBinding:
      position: 101
      prefix: -X
  - id: genome_seqdb
    type:
      - 'null'
      - File
    doc: Reference genome sequence database (the FASTA file given to makeblastdb, with its BLAST database files beside it)
    secondaryFiles:
      - .nhr
      - .nin
      - .nsq
    inputBinding:
      position: 101
      prefix: -d
  - id: genome_wbm
    type:
      - 'null'
      - File
    doc: Reference genome in WBM format
    inputBinding:
      position: 101
      prefix: -b
  - id: input_fa
    type: File
    doc: First input FASTA file
    inputBinding:
      position: 101
      prefix: '-1'
  - id: matepairs_fa
    type:
      - 'null'
      - File
    doc: Mate pairs FASTA file
    inputBinding:
      position: 101
      prefix: '-2'
  - id: old_srprism
    type:
      - 'null'
      - boolean
    doc: Use options for older version of srprism (interferes with config file)
    inputBinding:
      position: 101
      prefix: --old-srprism
  - id: quality_score
    type:
      - 'null'
      - int
    doc: Quality score setting (0 or 1)
    inputBinding:
      position: 101
      prefix: -q
  - id: srindex
    type:
      - 'null'
      - File
    doc: srprism index (the <prefix>.idx file made by 'srprism mkindex -o <prefix>'; the other index files must sit beside it)
    secondaryFiles:
      - ^.amp
      - ^.imp
      - ^.map
      - ^.pmp
      - ^.rmp
      - ^.ss
      - ^.ssa
      - ^.ssd
    inputBinding:
      position: 101
      prefix: -x
      valueFrom: $(self.path.replace(/\.idx$/, ''))
  - id: tmpdir
    type:
      - 'null'
      - string
    doc: Temporary directory
    inputBinding:
      position: 101
      prefix: -T
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: blacklist_out
    type:
      - 'null'
      - File
    doc: Output blacklist file
    outputBinding:
      glob: $(inputs.blacklist)
  - id: extracted_reads
    type:
      type: array
      items: File
    doc: Reads without the tagged (host) sequences, written with -X as <blacklist>.fa/.fastq or <blacklist>_1/_2.fa/.fastq
    outputBinding:
      glob: '$(inputs.blacklist ? [inputs.blacklist + ".f*", inputs.blacklist + "_1.f*", inputs.blacklist + "_2.f*"] : [])'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bmtagger:3.101--3
stdout: bmtagger_bmtagger.sh.out
