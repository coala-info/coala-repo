cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vamb
  - taxometer
label: vamb_taxometer
doc: 'Refine taxonomy using composition and abundance information.


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
  - id: taxonomy
    type:
      - 'null'
      - File
    doc: Path to the taxonomy file
    inputBinding:
      position: 101
      prefix: --taxonomy
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
stdout: vamb_taxometer.out
