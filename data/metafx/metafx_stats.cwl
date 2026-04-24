cwlVersion: v1.2
class: CommandLineTool
baseCommand: metafx stats
label: metafx_stats
doc: "supervised feature extraction using statistically significant k-mers\n\nTool
  homepage: https://github.com/ctlab/metafx"
inputs:
  - id: bad_frequency
    type:
      - 'null'
      - int
    doc: maximal frequency for a k-mer to be assumed erroneous
    inputBinding:
      position: 101
      prefix: --bad-frequency
  - id: depth
    type:
      - 'null'
      - int
    doc: Depth of de Bruijn graph traversal from pivot k-mers in number of 
      branches
    inputBinding:
      position: 101
      prefix: --depth
  - id: k
    type: int
    doc: k-mer size (in nucleotides, maximum value is 31)
    inputBinding:
      position: 101
      prefix: --k
  - id: kmers_dir
    type:
      - 'null'
      - Directory
    doc: directory with pre-computed k-mers for samples in binary format
    inputBinding:
      position: 101
      prefix: --kmers-dir
  - id: memory
    type:
      - 'null'
      - string
    doc: 'memory to use (values with suffix: 1500M, 4G, etc.)'
    inputBinding:
      position: 101
      prefix: --memory
  - id: pchi2
    type:
      - 'null'
      - float
    doc: p-value for chi-squared test
    inputBinding:
      position: 101
      prefix: --pchi2
  - id: pmw
    type:
      - 'null'
      - float
    doc: p-value for Mann–Whitney test
    inputBinding:
      position: 101
      prefix: --pmw
  - id: reads_file
    type: File
    doc: 'tab-separated file with 2 values in each row: <path_to_file>\t<category>'
    inputBinding:
      position: 101
      prefix: --reads-file
  - id: skip_graph
    type:
      - 'null'
      - boolean
    doc: if TRUE skip de Bruijn graph and fasta construction from components
    inputBinding:
      position: 101
      prefix: --skip-graph
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: work_dir
    type:
      - 'null'
      - Directory
    doc: working directory
    inputBinding:
      position: 101
      prefix: --work-dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metafx:1.1.0--hdfd78af_0
stdout: metafx_stats.out
