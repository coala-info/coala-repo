cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi unitig
label: odgi_unitig
doc: "Output unitigs of the graph.\n\nTool homepage: https://github.com/vgteam/odgi"
inputs:
  - id: fake_fastq
    type:
      - 'null'
      - boolean
    doc: Write the unitigs in FASTQ format to stdout with a fixed quality value 
      of *I*.
    inputBinding:
      position: 101
      prefix: --fake-fastq
  - id: idx
    type: File
    doc: Load the succinct variation graph in ODGI format from this *FILE*. The 
      file name usually ends with *.og*. It also accepts GFAv1, but the 
      on-the-fly conversion to the ODGI format requires additional time!
    inputBinding:
      position: 101
      prefix: --idx
  - id: min_begin_node_length
    type:
      - 'null'
      - int
    doc: Only begin unitigs collection from nodes which have at least length 
      *N*.
    inputBinding:
      position: 101
      prefix: --min-begin-node-length
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Write the current progress to stderr.
    inputBinding:
      position: 101
      prefix: --progress
  - id: sample_plus
    type:
      - 'null'
      - int
    doc: Continue unitigs with a random walk in the graph by *N* past their 
      natural end.
    inputBinding:
      position: 101
      prefix: --sample-plus
  - id: sample_to
    type:
      - 'null'
      - int
    doc: Continue unitigs with a random walk in the graph so that they have at 
      least the given *N* length.
    inputBinding:
      position: 101
      prefix: --sample-to
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel operations.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
stdout: odgi_unitig.out
