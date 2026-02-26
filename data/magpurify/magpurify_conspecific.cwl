cwlVersion: v1.2
class: CommandLineTool
baseCommand: magpurify conspecific
label: magpurify_conspecific
doc: "Find contigs that fail to align to closely related genomes.\n\nTool homepage:
  https://github.com/snayfach/MAGpurify"
inputs:
  - id: fna
    type: File
    doc: Path to input genome in FASTA format
    inputBinding:
      position: 1
  - id: out
    type: Directory
    doc: Output directory to store results and intermediate files
    inputBinding:
      position: 2
  - id: mash_sketch
    type: File
    doc: Path to Mash sketch of reference genomes
    inputBinding:
      position: 3
  - id: contig_aln
    type:
      - 'null'
      - float
    doc: Minimum fraction of contig aligned to reference
    default: 0.5
    inputBinding:
      position: 104
      prefix: --contig-aln
  - id: contig_pid
    type:
      - 'null'
      - float
    doc: Minimum percent identity of contig aligned to reference
    default: 95.0
    inputBinding:
      position: 104
      prefix: --contig-pid
  - id: exclude
    type:
      - 'null'
      - type: array
        items: string
    doc: List of references to exclude
    default: ''
    inputBinding:
      position: 104
      prefix: --exclude
  - id: hit_rate
    type:
      - 'null'
      - float
    doc: Hit rate for flagging contigs
    default: 0.0
    inputBinding:
      position: 104
      prefix: --hit-rate
  - id: mash_dist
    type:
      - 'null'
      - float
    doc: Mash distance to reference genomes
    default: 0.05
    inputBinding:
      position: 104
      prefix: --mash-dist
  - id: max_genomes
    type:
      - 'null'
      - int
    doc: Max number of genomes to use
    default: 25
    inputBinding:
      position: 104
      prefix: --max-genomes
  - id: min_genomes
    type:
      - 'null'
      - int
    doc: Min number of genomes to use
    default: 1
    inputBinding:
      position: 104
      prefix: --min-genomes
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPUs to use
    default: 1
    inputBinding:
      position: 104
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/magpurify:2.1.2--pyhdfd78af_2
stdout: magpurify_conspecific.out
