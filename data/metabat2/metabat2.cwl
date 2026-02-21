cwlVersion: v1.2
class: CommandLineTool
baseCommand: metabat2
label: metabat2
doc: "MetaBAT: Metagenome Binning based on Abundance and Tetranucleotide frequency.\n
  \nTool homepage: https://bitbucket.org/berkeleylab/metabat"
inputs:
  - id: abundance_file
    type:
      - 'null'
      - File
    doc: A file having abundance information for each contig (optional)
    inputBinding:
      position: 101
      prefix: --abdFile
  - id: input_file
    type: File
    doc: Input genome contigs in (multi-)fasta format
    inputBinding:
      position: 101
      prefix: --inFile
  - id: max_edges
    type:
      - 'null'
      - int
    doc: Maximum number of edges per node
    default: 200
    inputBinding:
      position: 101
      prefix: --maxEdges
  - id: max_p
    type:
      - 'null'
      - int
    doc: Percentage of 'N's in a contig to ignore it
    default: 95
    inputBinding:
      position: 101
      prefix: --maxP
  - id: min_contig
    type:
      - 'null'
      - int
    doc: Minimum size of a contig for binning (should be >=1500)
    default: 2500
    inputBinding:
      position: 101
      prefix: --minContig
  - id: min_s
    type:
      - 'null'
      - int
    doc: Minimum score of a edge for binning
    default: 60
    inputBinding:
      position: 101
      prefix: --minS
  - id: num_threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use (0: use all cores)'
    default: 0
    inputBinding:
      position: 101
      prefix: --numThreads
  - id: p_bf
    type:
      - 'null'
      - int
    doc: Probability of being a bin
    default: 0
    inputBinding:
      position: 101
      prefix: --pBF
  - id: unbinned
    type:
      - 'null'
      - boolean
    doc: Generate a file for unbinned contigs
    inputBinding:
      position: 101
      prefix: --unbinned
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type: File
    doc: Output file prefix for bins
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabat2:2.18--h6f16272_0
