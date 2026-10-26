cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vamb
  - recluster
label: vamb_recluster
doc: 'Use marker genes to re-cluster (DBScan) or refine (K-means) clusters.


  Tool homepage: https://github.com/RasmussenLab/vamb'
inputs:
  - id: outdir_path
    type: string
    doc: Output directory to create
    inputBinding:
      position: 101
      prefix: --outdir
  - id: min_contig_length
    type:
      - 'null'
      - int
    doc: Ignore contigs shorter than this [2000]
    inputBinding:
      position: 101
      prefix: -m
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use where customizable [8]
    inputBinding:
      position: 101
      prefix: -p
  - id: norefcheck
    type:
      - 'null'
      - boolean
    doc: Skip reference name hashing check [False]
    inputBinding:
      position: 101
      prefix: --norefcheck
  - id: cuda
    type:
      - 'null'
      - boolean
    doc: Use GPU to train & cluster [False]
    inputBinding:
      position: 101
      prefix: --cuda
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed (determinism not guaranteed)
    inputBinding:
      position: 101
      prefix: --seed
  - id: fasta
    type:
      - 'null'
      - File
    doc: Path to fasta file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: composition
    type:
      - 'null'
      - File
    doc: Path to .npz of composition
    inputBinding:
      position: 101
      prefix: --composition
  - id: bamdir
    type:
      - 'null'
      - Directory
    doc: Dir with .bam files to use
    inputBinding:
      position: 101
      prefix: --bamdir
  - id: abundance_tsv
    type:
      - 'null'
      - File
    doc: Path to TSV file of precomputed abundances with header being "contigname(\t<samplename>)*"
    inputBinding:
      position: 101
      prefix: --abundance_tsv
  - id: abundance
    type:
      - 'null'
      - File
    doc: Path to .npz of abundances
    inputBinding:
      position: 101
      prefix: --abundance
  - id: markers
    type:
      - 'null'
      - File
    doc: Path to the marker .npz file
    inputBinding:
      position: 101
      prefix: --markers
  - id: hmm_path
    type:
      - 'null'
      - File
    doc: Path to the .hmm file of marker gene profiles
    inputBinding:
      position: 101
      prefix: --hmm_path
  - id: minfasta
    type:
      - 'null'
      - int
    doc: Minimum bin size to output as fasta [None = no files]
    inputBinding:
      position: 101
      prefix: --minfasta
  - id: binsplit_separator
    type:
      - 'null'
      - string
    doc: Binsplit separator [C if present] (pass empty string to disable)
    inputBinding:
      position: 101
      prefix: -o
  - id: latent_path
    type:
      - 'null'
      - File
    doc: Path to latent space .npz file
    inputBinding:
      position: 101
      prefix: --latent_path
  - id: clusters_path
    type:
      - 'null'
      - File
    doc: Path to TSV file with clusters
    inputBinding:
      position: 101
      prefix: --clusters_path
  - id: algorithm
    type:
      - 'null'
      - string
    doc: Which reclustering algorithm to use ('kmeans', 'dbscan') [kmeans]
    inputBinding:
      position: 101
      prefix: --algorithm
  - id: taxonomy
    type:
      - 'null'
      - File
    doc: Path to the taxonomy file
    inputBinding:
      position: 101
      prefix: --taxonomy
  - id: no_predictor
    type:
      - 'null'
      - boolean
    doc: Do not complete input taxonomy with Taxometer [False]
    inputBinding:
      position: 101
      prefix: --no_predictor
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: outdir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.outdir_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vamb:5.0.4--pyhdfd78af_0
stdout: vamb_recluster.out
