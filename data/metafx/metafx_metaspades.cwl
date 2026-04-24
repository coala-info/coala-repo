cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metafx
  - metaspades
label: metafx_metaspades
doc: "MetaFX metaspades module – unsupervised feature extraction and distance estimation
  via metaSpades (https://cab.spbu.ru/software/meta-spades/)\n\nTool homepage: https://github.com/ctlab/metafx"
inputs:
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
      [optional, if set '-i' can be omitted]
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
    doc: list of PAIRED-END reads files from single environment. FASTQ, FASTA, 
      gzip-compressed
    inputBinding:
      position: 101
      prefix: --reads
  - id: separate
    type:
      - 'null'
      - boolean
    doc: if TRUE use every spades contig as a separate feature (do not combine 
      them in components; -l, -b1, -b2 ignored)
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
stdout: metafx_metaspades.out
