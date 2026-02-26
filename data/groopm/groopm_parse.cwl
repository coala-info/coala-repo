cwlVersion: v1.2
class: CommandLineTool
baseCommand: groopm_parse
label: groopm_parse
doc: "Parse raw data and save to disk\n\nTool homepage: https://ecogenomics.github.io/GroopM/"
inputs:
  - id: dbname
    type: string
    doc: name of the database being created
    inputBinding:
      position: 1
  - id: reference
    type: File
    doc: fasta file containing bam reference sequences
    inputBinding:
      position: 2
  - id: bamfiles
    type:
      type: array
      items: File
    doc: bam files to parse
    inputBinding:
      position: 3
  - id: cutoff
    type:
      - 'null'
      - int
    doc: cutoff contig size during parsing
    default: 500
    inputBinding:
      position: 104
      prefix: --cutoff
  - id: force
    type:
      - 'null'
      - boolean
    doc: overwrite existing DB file without prompting
    default: false
    inputBinding:
      position: 104
      prefix: --force
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use during BAM parsing
    default: 1
    inputBinding:
      position: 104
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/groopm:0.3.4--pyhdfd78af_2
stdout: groopm_parse.out
