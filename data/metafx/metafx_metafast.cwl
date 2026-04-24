cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metafx
  - metafast
label: metafx_metafast
doc: "MetaFX metafast module – unsupervised feature extraction and distance estimation
  via MetaFast (https://github.com/ctlab/metafast/)\n\nTool homepage: https://github.com/ctlab/metafx"
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
  - id: max_comp_size
    type:
      - 'null'
      - int
    doc: maximum size of extracted components (features) in k-mers
    inputBinding:
      position: 101
      prefix: --max-comp-size
  - id: memory
    type:
      - 'null'
      - string
    doc: 'memory to use (values with suffix: 1500M, 4G, etc.)'
    inputBinding:
      position: 101
      prefix: --memory
  - id: min_comp_size
    type:
      - 'null'
      - int
    doc: minimum size of extracted components (features) in k-mers
    inputBinding:
      position: 101
      prefix: --min-comp-size
  - id: min_seq_len
    type:
      - 'null'
      - int
    doc: minimal sequence length to be added to a component (in nucleotides)
    inputBinding:
      position: 101
      prefix: --min-seq-len
  - id: reads
    type:
      type: array
      items: File
    doc: list of reads files from single environment. FASTQ, FASTA, gzip- or 
      bzip2-compressed
    inputBinding:
      position: 101
      prefix: --reads
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
stdout: metafx_metafast.out
