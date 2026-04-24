cwlVersion: v1.2
class: CommandLineTool
baseCommand: mapsembler2
label: mapsembler2
doc: "Mapsembler2 is a targeted assembly software that takes as input a set of NGS
  raw reads and a set of input sequences (starters). It determines if each starter
  is read-coherent and, if so, outputs its neighborhood as a linear sequence or a
  graph.\n\nTool homepage: https://colibread.inria.fr/software/mapsembler2/"
inputs:
  - id: extension_type
    type:
      - 'null'
      - int
    doc: 'Type of extension: 1 for consensus (linear), 2 for graph.'
    inputBinding:
      position: 101
      prefix: -t
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Size of the kmers used for the assembly.
    inputBinding:
      position: 101
      prefix: -k
  - id: max_nodes
    type:
      - 'null'
      - int
    doc: Maximum number of nodes for each extension.
    inputBinding:
      position: 101
      prefix: -n
  - id: min_abundance
    type:
      - 'null'
      - int
    doc: 'Minimum abundance: kmers with lower abundance are considered as errors.'
    inputBinding:
      position: 101
      prefix: -c
  - id: process_count
    type:
      - 'null'
      - int
    doc: Number of processes to use.
    inputBinding:
      position: 101
      prefix: -p
  - id: reads
    type:
      type: array
      items: File
    doc: Input reads (fasta or fastq format). Multiple files can be provided.
    inputBinding:
      position: 101
      prefix: -r
  - id: search_depth
    type:
      - 'null'
      - int
    doc: Maximum search depth for the extension.
    inputBinding:
      position: 101
      prefix: -d
  - id: starters
    type:
      type: array
      items: File
    doc: Input starters (fasta or fastq format). Multiple files can be provided.
    inputBinding:
      position: 101
      prefix: -s
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Prefix for the output files.
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mapsembler2:2.2.4--2
