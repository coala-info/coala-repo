cwlVersion: v1.2
class: CommandLineTool
baseCommand: ASCIIGenome
label: asciigenome_ASCIIGenome
doc: "Genome browser at the command line.\n\nTool homepage: https://github.com/dariober/ASCIIGenome"
inputs:
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Input files to be displayed: bam, bed, gtf, bigwig, bedgraph, etc.'
    inputBinding:
      position: 1
  - id: batch_file
    type:
      - 'null'
      - File
    doc: Bed or gff file of regions to process in batch. Use - to read from 
      stdin. ASCIIGenome will iterate through the regions in this file
    inputBinding:
      position: 102
      prefix: --batchFile
  - id: config
    type:
      - 'null'
      - string
    doc: "Source of configuration settings. It can be a local file or a tag matching
      a built-in configuration: 'black_on_white', 'white_on_black', 'metal'. If null,
      first try to read configuration from file '~/.asciigenome_config'. If this file
      is missing use a built-in setting. For examples of configuration files see https://github.com/dariober/ASCIIGenome/tree/master/src/main/resources/config"
    inputBinding:
      position: 102
      prefix: --config
  - id: debug
    type:
      - 'null'
      - int
    doc: 'Set debugging mode. 0: off; 1: print exception stack traces; 2: print stack
      traces and exit.'
    default: 0
    inputBinding:
      position: 102
      prefix: --debug
  - id: exec
    type:
      - 'null'
      - string
    doc: Commands to be executed at the prompt. Either a file with one command 
      per line a single string of commands, e.g. 'goto chr1 && next && seqRegex 
      ACTG'
    inputBinding:
      position: 102
      prefix: --exec
  - id: fasta
    type:
      - 'null'
      - File
    doc: Optional reference fasta file. If null, ASCIIGenome will check whether 
      the input file list contains a suitable fasta.
    inputBinding:
      position: 102
      prefix: --fasta
  - id: no_format
    type:
      - 'null'
      - boolean
    doc: Do not format output with non ascii chars (colour, bold, etc.)
    default: false
    inputBinding:
      position: 102
      prefix: --noFormat
  - id: non_interactive
    type:
      - 'null'
      - boolean
    doc: 'Non interactive mode: Exit after having processed cmd line args'
    default: false
    inputBinding:
      position: 102
      prefix: --nonInteractive
  - id: region
    type:
      - 'null'
      - string
    doc: Go to region. Format 1-based as 'chrom:start-end' or 'chrom:start' or 
      'chrom'. E.g. chr1:1-1000
    inputBinding:
      position: 102
      prefix: --region
  - id: show_mem_time
    type:
      - 'null'
      - boolean
    doc: Show memory usage and time spent to process input. Typically used for 
      debugging only
    default: false
    inputBinding:
      position: 102
      prefix: --showMemTime
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/asciigenome:1.20.0--hdfd78af_1
stdout: asciigenome_ASCIIGenome.out
