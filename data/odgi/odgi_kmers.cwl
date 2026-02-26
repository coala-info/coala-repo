cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi kmers
label: odgi_kmers
doc: "Display and characterize the kmer space of a graph.\n\nTool homepage: https://github.com/vgteam/odgi"
inputs:
  - id: idx
    type: File
    doc: Load the succinct variation graph in ODGI format from this *FILE*. The 
      file name usually ends with *.og*. It also accepts GFAv1, but the 
      on-the-fly conversion to the ODGI format requires additional time!
    inputBinding:
      position: 101
      prefix: --idx
  - id: kmer_length
    type: int
    doc: The kmer length to generate kmers from.
    inputBinding:
      position: 101
      prefix: --kmer-length
  - id: max_degree
    type:
      - 'null'
      - int
    doc: Don't take nodes into account that have a degree greater than N.
    inputBinding:
      position: 101
      prefix: --max-degree
  - id: max_furcations
    type:
      - 'null'
      - int
    doc: Break at edges that would be induce this many furcations in a kmer.
    inputBinding:
      position: 101
      prefix: --max-furcations
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Write the current progress to stderr.
    inputBinding:
      position: 101
      prefix: --progress
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: Write the kmers to stdout. Kmers are line-separated.
    inputBinding:
      position: 101
      prefix: --stdout
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
stdout: odgi_kmers.out
