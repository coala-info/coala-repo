cwlVersion: v1.2
class: CommandLineTool
baseCommand: vamb taxometer
label: vamb_taxometer
doc: "Refine taxonomy using composition and abundance information.\n\nTool homepage:
  https://github.com/RasmussenLab/vamb"
inputs:
  - id: abundance
    type: File
    doc: Path to .npz of abundances
    inputBinding:
      position: 101
      prefix: --abundance
  - id: abundance_tsv
    type: File
    doc: Path to TSV file of precomputed abundances with header being 
      "contigname(<samplename>)*"
    inputBinding:
      position: 101
      prefix: --abundance_tsv
  - id: bamdir
    type: Directory
    doc: Dir with .bam files to use
    inputBinding:
      position: 101
      prefix: --bamdir
  - id: composition
    type: File
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
  - id: fasta
    type: File
    doc: Path to fasta file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: min_contig_length
    type:
      - 'null'
      - int
    doc: Ignore contigs shorter than this
    default: 2000
    inputBinding:
      position: 101
      prefix: -m
  - id: norefcheck
    type:
      - 'null'
      - boolean
    doc: Skip reference name hashing check
    default: false
    inputBinding:
      position: 101
      prefix: --norefcheck
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed (determinism not guaranteed)
    inputBinding:
      position: 101
      prefix: --seed
  - id: taxonomy
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
  - id: outdir
    type: Directory
    doc: Output directory to create
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vamb:5.0.4--pyhdfd78af_0
