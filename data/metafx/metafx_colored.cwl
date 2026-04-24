cwlVersion: v1.2
class: CommandLineTool
baseCommand: metafx colored
label: metafx_colored
doc: "supervised feature extraction using group-colored de Bruijn graph\n\nTool homepage:
  https://github.com/ctlab/metafx"
inputs:
  - id: bad_frequency
    type:
      - 'null'
      - int
    doc: maximal frequency for a k-mer to be assumed erroneous
    inputBinding:
      position: 101
      prefix: --bad-frequency
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
  - id: linear
    type:
      - 'null'
      - boolean
    doc: if TRUE extract only linear components choosing best path on each graph
      fork
    inputBinding:
      position: 101
      prefix: --linear
  - id: memory
    type:
      - 'null'
      - string
    doc: 'memory to use (values with suffix: 1500M, 4G, etc.)'
    inputBinding:
      position: 101
      prefix: --memory
  - id: n_comps
    type:
      - 'null'
      - int
    doc: select not more than <int> components for each category
    inputBinding:
      position: 101
      prefix: --n-comps
  - id: perc
    type:
      - 'null'
      - float
    doc: relative abundance of k-mer in category to be considered color-specific
    inputBinding:
      position: 101
      prefix: --perc
  - id: reads_file
    type: File
    doc: "tab-separated file with 2 values in each row: <path_to_file>\t<category>"
    inputBinding:
      position: 101
      prefix: --reads-file
  - id: separate
    type:
      - 'null'
      - boolean
    doc: if TRUE use only color-specific k-mers in components (does not work in 
      linear mode)
    inputBinding:
      position: 101
      prefix: --separate
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
  - id: total_coverage
    type:
      - 'null'
      - boolean
    doc: if TRUE count k-mers occurrences in colored graph as total coverage in 
      samples, otherwise as number of samples
    inputBinding:
      position: 101
      prefix: --total-coverage
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
stdout: metafx_colored.out
