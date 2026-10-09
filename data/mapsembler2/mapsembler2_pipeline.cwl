cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_mapsembler2_pipeline.sh
label: mapsembler2_pipeline
doc: "Runs mapsembler2_extremities, mapsembler2_extend and kissreads on starters and
  reads.\n\nTool homepage: https://colibread.inria.fr/software/mapsembler2/"
inputs:
  - id: starters
    type: File
    doc: file containing starters (fasta)
    inputBinding:
      position: 1
      prefix: -s
  - id: reads
    type:
      type: array
      items: File
    doc: reads (fasta or fastq, gzipped or not), passed as one quoted space-separated
      string
    inputBinding:
      position: 2
      prefix: -r
      itemSeparator: ' '
  - id: assembly_kind
    type: int
    doc: 'kind of assembly: 1 unitig (fasta), 2 contig (fasta), 3 unitig (graph),
      4 contig (graph)'
    inputBinding:
      position: 3
      prefix: -t
  - id: prefix
    type: string
    default: res
    doc: all output files start with this prefix
    inputBinding:
      position: 4
      prefix: -p
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: length of used kmers (default 31)
    inputBinding:
      position: 5
      prefix: -k
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: minimal coverage (default 5)
    inputBinding:
      position: 5
      prefix: -c
  - id: substitutions
    type:
      - 'null'
      - int
    doc: number of authorized substitutions used while mapping reads on found SNPs
      (default 1)
    inputBinding:
      position: 5
      prefix: -d
  - id: genome_size
    type:
      - 'null'
      - long
    doc: estimated genome size, only used to control memory usage
    inputBinding:
      position: 5
      prefix: -g
  - id: search_process
    type:
      - 'null'
      - int
    doc: process of search in the graph (1 breadth, 2 depth)
    inputBinding:
      position: 5
      prefix: -f
  - id: max_node_length
    type:
      - 'null'
      - int
    doc: maximal nodes length (default 40)
    inputBinding:
      position: 5
      prefix: -x
  - id: max_graph_depth
    type:
      - 'null'
      - int
    doc: maximal graph depth (default 10000)
    inputBinding:
      position: 5
      prefix: -y
outputs:
  - id: results
    type:
      type: array
      items: File
    doc: result files starting with the prefix
    outputBinding:
      glob: $(inputs.prefix)*
  - id: starter_extremities
    type:
      - 'null'
      - File
    doc: extremities of the starters
    outputBinding:
      glob: starter_extremities.fa
  - id: stdout
    type: stdout
    doc: Standard output
stdout: mapsembler2_pipeline.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mapsembler2:2.2.4--2
