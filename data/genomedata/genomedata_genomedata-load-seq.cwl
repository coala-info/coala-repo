cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomedata-load-seq
label: genomedata_genomedata-load-seq
doc: "Start a Genomedata archive at GENOMEDATAFILE with the provided sequences.\n\
  SEQFILEs should be in fasta format, and a separate Chromosome will be created\n\
  for each definition line.\n\nTool homepage: http://genomedata.hoffmanlab.org"
inputs:
  - id: gdarchive
    type: string
    doc: genomedata archive
    inputBinding:
      position: 1
  - id: seqfiles
    type:
      type: array
      items: File
    doc: sequences in FASTA format
    inputBinding:
      position: 2
  - id: assembly
    type:
      - 'null'
      - boolean
    doc: "SEQFILE contains assembly (AGP) files instead of\nsequence"
    inputBinding:
      position: 103
      prefix: --assembly
  - id: assembly_report
    type:
      - 'null'
      - File
    doc: "Tab-delimited file with columnar mappings between\nchromosome naming styles."
    inputBinding:
      position: 103
      prefix: --assembly-report
  - id: directory_mode
    type:
      - 'null'
      - boolean
    doc: "If specified, the Genomedata archive will be\nimplemented as a directory,
      with a separate file for\neach Chromosome. This is recommended if there are
      a\nsmall number of Chromosomes. The default behavior is\nto use a directory
      if there are fewer than 100\nChromosomes being added."
    inputBinding:
      position: 103
      prefix: --directory-mode
  - id: file_mode
    type:
      - 'null'
      - boolean
    doc: "If specified, the Genomedata archive will be\nimplemented as a single file,
      with a separate h5 group\nfor each Chromosome. This is recommended if there
      are\na large number of Chromosomes. The default behavior is\nto use a single
      file if there are at least 100\nChromosomes being added."
    inputBinding:
      position: 103
      prefix: --file-mode
  - id: name_style
    type:
      - 'null'
      - string
    doc: "Chromsome naming style to use based on ASSEMBLY-\nREPORT. Default: UCSC-style-name"
    default: UCSC-style-name
    inputBinding:
      position: 103
      prefix: --name-style
  - id: sizes
    type:
      - 'null'
      - boolean
    doc: SEQFILE contains list of sizes instead of sequence
    inputBinding:
      position: 103
      prefix: --sizes
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print status updates and diagnostic messages
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomedata:1.7.4--py311h87bb1fd_0
stdout: genomedata_genomedata-load-seq.out
