cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - polap
  - disassemble
label: polap_disassemble
doc: "Assemble a plastid genome by subsampling long-read data without references (stages of\
  \ subsampled Flye assemblies and short-read polishing).\n\nTool homepage: https://github.com/goshng/polap"
inputs:
  - id: long_reads
    type: File
    doc: Long-read data file in FASTQ format.
    inputBinding:
      position: 101
      prefix: -l
  - id: short_read1
    type:
      - 'null'
      - File
    doc: Short-read FASTQ file 1.
    inputBinding:
      position: 101
      prefix: -a
  - id: short_read2
    type:
      - 'null'
      - File
    doc: Short-read FASTQ file 2.
    inputBinding:
      position: 101
      prefix: -b
  - id: outdir
    type: string
    doc: Output folder name.
    default: o
    inputBinding:
      position: 101
      prefix: -o
  - id: inum
    type:
      - 'null'
      - int
    doc: Index of the source assembly (folder <outdir>/<inum>); default 0.
    inputBinding:
      position: 101
      prefix: -i
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU cores.
    inputBinding:
      position: 101
      prefix: -t
  - id: downsample
    type:
      - 'null'
      - int
    doc: Maximum genome coverage to downsample to.
    inputBinding:
      position: 101
      prefix: --downsample
  - id: disassemble_i
    type:
      - 'null'
      - string
    doc: Index (any string) of this disassemble run.
    inputBinding:
      position: 101
      prefix: --disassemble-i
  - id: disassemble_a
    type:
      - 'null'
      - string
    doc: Smallest base pairs of the subsampling range (int for base pairs or .float for rate).
    inputBinding:
      position: 101
      prefix: --disassemble-a
  - id: disassemble_b
    type:
      - 'null'
      - string
    doc: Largest base pairs of the subsampling range (int for base pairs or .float for rate).
    inputBinding:
      position: 101
      prefix: --disassemble-b
  - id: disassemble_p
    type:
      - 'null'
      - float
    doc: Maximum percent of long-read data (percentile of the largest long read).
    inputBinding:
      position: 101
      prefix: --disassemble-p
  - id: disassemble_n
    type:
      - 'null'
      - int
    doc: Number of steps in stage 1.
    inputBinding:
      position: 101
      prefix: --disassemble-n
  - id: disassemble_m
    type:
      - 'null'
      - string
    doc: Upper bound for a Flye assembly.
    inputBinding:
      position: 101
      prefix: --disassemble-m
  - id: disassemble_memory
    type:
      - 'null'
      - int
    doc: Maximum memory in Gb.
    inputBinding:
      position: 101
      prefix: --disassemble-memory
  - id: disassemble_alpha
    type:
      - 'null'
      - float
    doc: Starting Flye's disjointig coverage.
    inputBinding:
      position: 101
      prefix: --disassemble-alpha
  - id: disassemble_delta
    type:
      - 'null'
      - float
    doc: Move size of alpha (0.1 - 1.0).
    inputBinding:
      position: 101
      prefix: --disassemble-delta
  - id: disassemble_c
    type:
      - 'null'
      - File
    doc: A single reference sequence in FASTA (check case).
    inputBinding:
      position: 101
      prefix: --disassemble-c
  - id: disassemble_align_reference
    type:
      - 'null'
      - boolean
    doc: Align the result to the reference given by --disassemble-c.
    inputBinding:
      position: 101
      prefix: --disassemble-align-reference
  - id: disassemble_simple_polishing
    type:
      - 'null'
      - boolean
    doc: Use short-read polishing without subsampling.
    inputBinding:
      position: 101
      prefix: --disassemble-simple-polishing
  - id: random_seed
    type:
      - 'null'
      - int
    doc: 5-digit number, or 0 for a random seed.
    inputBinding:
      position: 101
      prefix: --random-seed
  - id: disassemble_r
    type:
      - 'null'
      - int
    doc: Number of replicates in stages 2 and 3.
    inputBinding:
      position: 101
      prefix: --disassemble-r
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (log).
  - id: outdir_out
    type: Directory
    doc: Output folder with all polap results.
    outputBinding:
      glob: $(inputs.outdir)
  - id: ptdna_fasta
    type:
      type: array
      items: File
    doc: Plastid genome assembly <outdir>/ptdna.<inum>.fa.
    outputBinding:
      glob: $(inputs.outdir)/ptdna.*.fa
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/polap:0.5.3.1--py312hdfd78af_0
stdout: polap_disassemble.out
