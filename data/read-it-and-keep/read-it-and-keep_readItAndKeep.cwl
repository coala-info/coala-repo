cwlVersion: v1.2
class: CommandLineTool
baseCommand: readItAndKeep
label: read-it-and-keep_readItAndKeep
doc: "Read-it-and-keep is a tool to filter reads based on mapping information.\n\n\
  Tool homepage: https://github.com/GenomePathogenAnalysisService/read-it-and-keep"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug mode. More verbose and writes debugging files
    inputBinding:
      position: 101
      prefix: --debug
  - id: enumerate_names
    type:
      - 'null'
      - boolean
    doc: Rename the reads 1,2,3,... (for paired reads, will also add /1 or /2 on
      the end of names)
    inputBinding:
      position: 101
      prefix: --enumerate_names
  - id: min_map_length
    type:
      - 'null'
      - int
    doc: Minimum length of match required to keep a read in bp
    inputBinding:
      position: 101
      prefix: --min_map_length
  - id: min_map_length_percent
    type:
      - 'null'
      - float
    doc: Minimum length of match required to keep a read, as a percent of the 
      read length
    inputBinding:
      position: 101
      prefix: --min_map_length_pc
  - id: output_prefix
    type: string
    doc: Prefix of output files
    inputBinding:
      position: 101
      prefix: --outprefix
  - id: reads1
    type: File
    doc: Name of first reads file
    inputBinding:
      position: 101
      prefix: --reads1
  - id: reads2
    type:
      - 'null'
      - File
    doc: Name of second reads file, ie mates file for paired reads
    inputBinding:
      position: 101
      prefix: --reads2
  - id: reference_fasta
    type: File
    doc: Reference genome FASTA filename
    inputBinding:
      position: 101
      prefix: --ref_fasta
  - id: sequencing_technology
    type:
      - 'null'
      - string
    doc: Sequencing technology, must be 'illumina' or 'ont'
    inputBinding:
      position: 101
      prefix: --tech
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/read-it-and-keep:0.3.0--h5ca1c30_3
stdout: read-it-and-keep_readItAndKeep.out
