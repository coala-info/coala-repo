cwlVersion: v1.2
class: CommandLineTool
baseCommand: flanker
label: flanker
doc: "Flanker (version 0.1.5). If you use Flanker in your work, please cite us: Matlock
  W, Lipworth S, Constantinides B, Peto TEA, Walker AS, Crook D, Hopkins S, Shaw LP,
  Stoesser N.Flanker: a tool for comparative genomics of gene flanking regions.BioRxiv.
  2021. doi: https://doi.org/10.1101/2021.02.22.432255\n\nTool homepage: https://github.com/wtmatlock/flanker"
inputs:
  - id: circ
    type:
      - 'null'
      - boolean
    doc: Is sequence circularised
    default: false
    inputBinding:
      position: 101
      prefix: --circ
  - id: closest_match
    type:
      - 'null'
      - boolean
    doc: Find closest match to query
    default: false
    inputBinding:
      position: 101
      prefix: --closest_match
  - id: cluster
    type:
      - 'null'
      - boolean
    doc: Turn on clustering mode?
    default: false
    inputBinding:
      position: 101
      prefix: --cluster
  - id: database
    type:
      - 'null'
      - string
    doc: Choose Abricate database e.g. NCBI, resfinder
    default: ncbi
    inputBinding:
      position: 101
      prefix: --database
  - id: fasta_file
    type: File
    doc: Input fasta file
    inputBinding:
      position: 101
      prefix: --fasta_file
  - id: flank
    type:
      - 'null'
      - string
    doc: Choose which side(s) of the gene to extract (upstream/downstream/both)
    default: both
    inputBinding:
      position: 101
      prefix: --flank
  - id: gene
    type:
      - 'null'
      - type: array
        items: string
    doc: Gene(s) of interest (escape any special characters). Use space 
      seperation for multipe genes
    inputBinding:
      position: 101
      prefix: --gene
  - id: include_gene
    type:
      - 'null'
      - boolean
    doc: Include the gene of interest
    default: false
    inputBinding:
      position: 101
      prefix: --include_gene
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: kmer length for Mash
    default: 21
    inputBinding:
      position: 101
      prefix: --kmer_length
  - id: list_of_genes
    type:
      - 'null'
      - File
    doc: Line separated file containing genes of interest
    inputBinding:
      position: 101
      prefix: --list_of_genes
  - id: mode
    type:
      - 'null'
      - string
    doc: One of "default" - normal mode, "mm" - multi-allelic cluster, or "sm" -
      salami-mode
    default: default
    inputBinding:
      position: 101
      prefix: --mode
  - id: outfile
    type:
      - 'null'
      - string
    doc: Prefix for the clustering file
    default: out
    inputBinding:
      position: 101
      prefix: --outfile
  - id: sketch_size
    type:
      - 'null'
      - int
    doc: sketch size for mash
    default: 1000
    inputBinding:
      position: 101
      prefix: --sketch_size
  - id: threads
    type:
      - 'null'
      - int
    doc: threads for mash to use
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: threshold
    type:
      - 'null'
      - float
    doc: mash distance threshold for clustering
    default: 0.001
    inputBinding:
      position: 101
      prefix: --threshold
  - id: verbose
    type:
      - 'null'
      - int
    doc: 'Increase verbosity: 0 = only warnings, 1 = info, 2 = debug. No number means
      info. Default is no verbosity.'
    default: 0
    inputBinding:
      position: 101
      prefix: --verbose
  - id: window
    type:
      - 'null'
      - int
    doc: Length of flanking sequence/first window length
    default: 1000
    inputBinding:
      position: 101
      prefix: --window
  - id: window_step
    type:
      - 'null'
      - int
    doc: Step in window sequence
    inputBinding:
      position: 101
      prefix: --window_step
  - id: window_stop
    type:
      - 'null'
      - int
    doc: Final window length
    inputBinding:
      position: 101
      prefix: --window_stop
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flanker:0.1.5--py_0
stdout: flanker.out
