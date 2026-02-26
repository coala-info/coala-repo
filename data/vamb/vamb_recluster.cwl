cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vamb
  - recluster
label: vamb_recluster
doc: "Use marker genes to re-cluster (DBScan) or refine (K-means) clusters.\n\nTool
  homepage: https://github.com/RasmussenLab/vamb"
inputs:
  - id: abundance_input
    type:
      - 'null'
      - File
    doc: Path to .npz of abundances
    inputBinding:
      position: 101
      prefix: --abundance
  - id: abundance_tsv_input
    type:
      - 'null'
      - File
    doc: Path to TSV file of precomputed abundances with header being 
      "contigname(<samplename>)*"
    inputBinding:
      position: 101
      prefix: --abundance_tsv
  - id: algorithm
    type:
      - 'null'
      - string
    doc: Which reclustering algorithm to use ('kmeans', 'dbscan')
    default: kmeans
    inputBinding:
      position: 101
      prefix: --algorithm
  - id: bamdir_input
    type:
      - 'null'
      - Directory
    doc: Dir with .bam files to use
    inputBinding:
      position: 101
      prefix: --bamdir
  - id: binsplit_separator
    type:
      - 'null'
      - string
    doc: Binsplit separator
    default: C if present
    inputBinding:
      position: 101
      prefix: -o
  - id: clusters_path
    type: File
    doc: Path to TSV file with clusters
    inputBinding:
      position: 101
      prefix: --clusters_path
  - id: composition_input
    type:
      - 'null'
      - File
    doc: Path to .npz of composition
    inputBinding:
      position: 101
      prefix: --composition
  - id: cuda
    type:
      - 'null'
      - boolean
    doc: Use GPU to train & cluster
    default: false
    inputBinding:
      position: 101
      prefix: --cuda
  - id: fasta_input
    type:
      - 'null'
      - File
    doc: Path to fasta file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: hmm_path_input
    type:
      - 'null'
      - File
    doc: Path to the .hmm file of marker gene profiles
    inputBinding:
      position: 101
      prefix: --hmm_path
  - id: latent_path
    type: File
    doc: Path to latent space .npz file
    inputBinding:
      position: 101
      prefix: --latent_path
  - id: markers_input
    type: File
    doc: Path to the marker .npz file
    inputBinding:
      position: 101
      prefix: --markers
  - id: min_contig_length
    type:
      - 'null'
      - int
    doc: Ignore contigs shorter than this
    default: 2000
    inputBinding:
      position: 101
      prefix: -m
  - id: min_fasta_output
    type:
      - 'null'
      - int
    doc: Minimum bin size to output as fasta
    default: None = no files
    inputBinding:
      position: 101
      prefix: --minfasta
  - id: no_predictor
    type:
      - 'null'
      - boolean
    doc: Do not complete input taxonomy with Taxometer
    default: false
    inputBinding:
      position: 101
      prefix: --no_predictor
  - id: norefcheck
    type:
      - 'null'
      - boolean
    doc: Skip reference name hashing check
    default: false
    inputBinding:
      position: 101
      prefix: --norefcheck
  - id: outdir
    type: Directory
    doc: Output directory to create
    inputBinding:
      position: 101
      prefix: --outdir
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed (determinism not guaranteed)
    inputBinding:
      position: 101
      prefix: --seed
  - id: taxonomy_input
    type: File
    doc: Path to the taxonomy file
    inputBinding:
      position: 101
      prefix: --taxonomy
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use where customizable
    default: 8
    inputBinding:
      position: 101
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vamb:5.0.4--pyhdfd78af_0
stdout: vamb_recluster.out
