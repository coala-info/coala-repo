cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ra_consensus
label: ra_ra_consensus
doc: "Builds consensus sequences from AFG reads and AFG contigs (transcripts), written\
  \ to standard output or --out.\n\nTool homepage: https://github.com/mariokostelac/ra"
inputs:
  - id: reads
    type: File
    doc: input afg reads file
    inputBinding:
      position: 1
      prefix: -i
  - id: contigs
    type: File
    doc: input afg contigs file
    inputBinding:
      position: 2
      prefix: -j
  - id: threads
    type:
      - 'null'
      - int
    doc: 'number of threads used (default: number of cores)'
    inputBinding:
      position: 102
      prefix: -t
  - id: out
    type:
      - 'null'
      - string
    doc: 'output fasta transcripts file name (default: standard output)'
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_fasta
    type:
      - 'null'
      - File
    doc: FASTA transcripts written with the out option
    outputBinding:
      glob: $(inputs.out || '__none__')
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ra:0.9--h503566f_8
stdout: ra_ra_consensus.out
