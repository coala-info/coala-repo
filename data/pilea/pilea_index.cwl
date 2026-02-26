cwlVersion: v1.2
class: CommandLineTool
baseCommand: pilea_index
label: pilea_index
doc: "Index fasta files for Pilea.\n\nTool homepage: https://github.com/xinehc/pilea"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: Input fasta <*.fa|*.fna|*.fasta> file(s), gzip optional <*.gz>, file 
      list optional <.txt>.
    inputBinding:
      position: 1
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Compress the database by creating a tar archive.
    default: false
    inputBinding:
      position: 102
      prefix: --compress
  - id: database_dir
    type:
      - 'null'
      - Directory
    doc: Database directory. If given then extend it, otherwise build a new one.
    default: None
    inputBinding:
      position: 102
      prefix: --database
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: K-mer size.
    default: 31
    inputBinding:
      position: 102
      prefix: --kmer
  - id: outdir
    type: Directory
    doc: Output directory.
    inputBinding:
      position: 102
      prefix: --outdir
  - id: scale
    type:
      - 'null'
      - int
    doc: Scale for downsampling.
    default: 250
    inputBinding:
      position: 102
      prefix: --scale
  - id: taxonomy_file
    type:
      - 'null'
      - File
    doc: Path to GTDB-Tk's <gtdbtk.bac120.summary.tsv> or GTDB's 
      <bac120_taxonomy.tsv>. If not given then ignore taxonomy mapping.
    default: None
    inputBinding:
      position: 102
      prefix: --taxonomy
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads.
    default: 20
    inputBinding:
      position: 102
      prefix: --threads
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size for k-mer grouping.
    default: 25000
    inputBinding:
      position: 102
      prefix: --window
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pilea:1.3.7--py312h4711d71_0
stdout: pilea_index.out
