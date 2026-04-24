cwlVersion: v1.2
class: CommandLineTool
baseCommand: pilea profile
label: pilea_profile
doc: "Profile genomes from fasta or fastq files.\n\nTool homepage: https://github.com/xinehc/pilea"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: Input fasta <*.fa|*.fasta> or fastq <*.fq|*.fastq> file(s), gzip 
      optional <*.gz>.
    inputBinding:
      position: 1
  - id: components
    type:
      - 'null'
      - int
    doc: Number of mixture components.
    inputBinding:
      position: 102
      prefix: --components
  - id: database_dir
    type: Directory
    doc: Database directory.
    inputBinding:
      position: 102
      prefix: --database
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force counting.
    inputBinding:
      position: 102
      prefix: --force
  - id: max_disp
    type:
      - 'null'
      - float
    doc: Max. median per-window dispersion of k-mers' counts.
    inputBinding:
      position: 102
      prefix: --max-disp
  - id: max_iter
    type:
      - 'null'
      - int
    doc: Terminal condition for EM - max. number of iterations.
    inputBinding:
      position: 102
      prefix: --max-iter
  - id: min_cont
    type:
      - 'null'
      - float
    doc: Min. containment of reference genomes' sketches after reassignment of 
      shared k-mers.
    inputBinding:
      position: 102
      prefix: --min-cont
  - id: min_cove
    type:
      - 'null'
      - float
    doc: Min. median per-window coverage of k-mers.
    inputBinding:
      position: 102
      prefix: --min-cove
  - id: min_frac
    type:
      - 'null'
      - float
    doc: Min. fraction of reference genomes' windows covered by k-mers.
    inputBinding:
      position: 102
      prefix: --min-frac
  - id: output_dir
    type: Directory
    doc: Output directory.
    inputBinding:
      position: 102
      prefix: --outdir
  - id: single
    type:
      - 'null'
      - boolean
    doc: Files are single-end. If not given then merge forward|reward files with
      <_(1|2)>, <_(R1|R2)> or <_(fwd|rev)>.
    inputBinding:
      position: 102
      prefix: --single
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads.
    inputBinding:
      position: 102
      prefix: --threads
  - id: tol
    type:
      - 'null'
      - float
    doc: Terminal condition for EM - tolerance.
    inputBinding:
      position: 102
      prefix: --tol
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pilea:1.3.7--py312h4711d71_0
stdout: pilea_profile.out
