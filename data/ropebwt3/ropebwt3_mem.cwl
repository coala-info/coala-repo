cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ropebwt3
  - mem
label: ropebwt3_mem
doc: "Find maximal exact matches (MEMs) of query sequences in an FMR/FMD index.\n\nTool homepage: https://github.com/lh3/ropebwt3"
inputs:
  - id: idx_fmr
    type: File
    doc: Input FMR or FMD index file (<index>.ssa, the sampled suffix array, and <index>.len.gz, the sequence names and lengths, are used when present)
    secondaryFiles:
      - pattern: .ssa
        required: false
      - pattern: .len.gz
        required: false
    inputBinding:
      position: 1
  - id: seq_fa
    type:
      type: array
      items: File
    doc: Query FASTA/FASTQ file(s)
    inputBinding:
      position: 2
  - id: min_mem_length
    type:
      - 'null'
      - int
    doc: min MEM length
    inputBinding:
      position: 102
      prefix: '-l'
  - id: min_interval_size
    type:
      - 'null'
      - int
    doc: min interval size
    inputBinding:
      position: 102
      prefix: '-c'
  - id: old_mem
    type:
      - 'null'
      - boolean
    doc: use the original MEM algorithm (for testing)
    inputBinding:
      position: 102
      prefix: '--old-mem'
  - id: gap
    type:
      - 'null'
      - int
    doc: output regions >=NUM that are not covered by MEMs
    inputBinding:
      position: 102
      prefix: '--gap='
      separate: false
  - id: coverage
    type:
      - 'null'
      - boolean
    doc: output breadth of coverage
    inputBinding:
      position: 102
      prefix: '--cov'
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 102
      prefix: '-t'
  - id: output_positions
    type:
      - 'null'
      - int
    doc: output up to INT positions
    inputBinding:
      position: 102
      prefix: '-p'
  - id: one_sequence_per_line
    type:
      - 'null'
      - boolean
    doc: one sequence per line in the input
    inputBinding:
      position: 102
      prefix: '-L'
  - id: query_batch_size
    type:
      - 'null'
      - string
    doc: query batch size
    inputBinding:
      position: 102
      prefix: '-K'
  - id: mmap
    type:
      - 'null'
      - boolean
    doc: use mmap to load FMD
    inputBinding:
      position: 102
      prefix: '-M'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
stdout: ropebwt3_mem.out
