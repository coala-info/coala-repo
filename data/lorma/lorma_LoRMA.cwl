cwlVersion: v1.2
class: CommandLineTool
baseCommand: LoRMA
label: lorma_LoRMA
doc: "LoRMA corrects long reads using only the long reads themselves (k-mer based multiple alignment of reads sharing k-mers).\n\nTool homepage: https://www.cs.helsinki.fi/u/lmsalmel/LoRMA/"
inputs:
  - id: reads_files
    type:
      type: array
      items: File
      inputBinding:
        itemSeparator: ','
    doc: file(s) of long reads
    inputBinding:
      position: 1
      prefix: -reads
  - id: output_file_path
    type: string
    doc: output file for corrected reads
    inputBinding:
      position: 2
      prefix: -output
  - id: discarded_reads_file_path
    type: string
    doc: output file for discarded reads
    inputBinding:
      position: 3
      prefix: -discarded
  - id: bestfriends
    type:
      - 'null'
      - int
    doc: Number of best friends [default '3']
    inputBinding:
      position: 4
      prefix: -bestfriends
  - id: friends
    type:
      - 'null'
      - int
    doc: Number of friends [default '7']
    inputBinding:
      position: 5
      prefix: -friends
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: kmer length [default '31']
    inputBinding:
      position: 6
      prefix: -k
  - id: nb_cores
    type:
      - 'null'
      - int
    doc: number of cores [default '1']
    inputBinding:
      position: 7
      prefix: -nb-cores
  - id: verbosity_level
    type:
      - 'null'
      - int
    doc: verbosity level [default '1']
    inputBinding:
      position: 8
      prefix: -verbose
outputs:
  - id: output_file
    type: File
    doc: output file for corrected reads
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: discarded_reads_file
    type: File
    doc: output file for discarded reads
    outputBinding:
      glob: $(inputs.discarded_reads_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lorma:0.4--2
