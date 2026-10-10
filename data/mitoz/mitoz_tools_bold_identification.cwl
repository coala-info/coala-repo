cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mitoz-tools
  - bold_identification
label: mitoz_tools_bold_identification
doc: "Identify taxa of given sequences from BOLD (http://www.boldsystems.org/). Sequences that time out are written to '*.TimeoutException.fasta' and sequences without BOLD matches to '*.NoBoldMatchError.fasta'. Needs network access to the BOLD server.\n\nTool homepage: https://github.com/linzhi2013/MitoZ"
inputs:
  - id: input_file
    type: File
    doc: "input file name"
    inputBinding:
      position: 1
      prefix: -i
  - id: input_format
    type:
      - 'null'
      - string
    doc: "input file format [fasta]"
    inputBinding:
      position: 2
      prefix: -f
  - id: output_prefix
    type: string
    doc: "outfile prefix"
    inputBinding:
      position: 3
      prefix: -o
  - id: database
    type:
      - 'null'
      - string
    doc: "database to search (COX1, COX1_SPECIES, COX1_SPECIES_PUBLIC, COX1_L640bp, ITS or MATK_RBCL) [COX1]"
    inputBinding:
      position: 4
      prefix: -d
  - id: top_hits
    type:
      - 'null'
      - int
    doc: "how many first top hits will be output. [1]"
    inputBinding:
      position: 5
      prefix: -n
  - id: max_submissions
    type:
      - 'null'
      - int
    doc: "Maximum submission time for a sequence, useful for handling TimeOutException. [4]"
    inputBinding:
      position: 6
      prefix: -r
  - id: continuous
    type:
      - 'null'
      - boolean
    doc: "continuous mode, jump over the ones already in the '-o' file, will resubmit all the remained."
    inputBinding:
      position: 7
      prefix: -c
  - id: chimera_check
    type:
      - 'null'
      - boolean
    doc: "For chimera check purpose. If set, for each sequence, the BOLD database is queried using the subsequences from 5'- and 3'-ends with a length of '-q <int>' bp, respectively"
    inputBinding:
      position: 8
      prefix: -C
  - id: chimera_length
    type:
      - 'null'
      - int
    doc: "The length of subsequences for chimera check [400]"
    inputBinding:
      position: 9
      prefix: -q
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "debug mode output [False]"
    inputBinding:
      position: 10
      prefix: -D
outputs:
  - id: results
    type:
      type: array
      items: File
    doc: "Identification table and the TimeoutException / NoBoldMatchError FASTA files."
    outputBinding:
      glob: $(inputs.output_prefix)*
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mitoz:3.6--pyhdfd78af_1
