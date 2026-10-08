cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - polap
  - assemble1
label: polap_assemble1
doc: "Assemble whole-genome sequences with Flye (first step of the polap organelle assembly).\n\
  \nTool homepage: https://github.com/goshng/polap"
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
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: Minimum read length.
    inputBinding:
      position: 101
      prefix: -m
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU cores.
    inputBinding:
      position: 101
      prefix: -t
  - id: coverage
    type:
      - 'null'
      - int
    doc: Coverage option for the Flye assembly.
    inputBinding:
      position: 101
      prefix: -c
  - id: genomesize
    type:
      - 'null'
      - string
    doc: Genome size (from find-genome-size, or given by the user).
    inputBinding:
      position: 101
      prefix: -g
  - id: reduction_reads
    type:
      - 'null'
      - boolean
    doc: Reduce the data in the whole-genome assembly.
    inputBinding:
      position: 101
      prefix: --reduction-reads
  - id: no_reduction_reads
    type:
      - 'null'
      - boolean
    doc: Do not reduce the data in the whole-genome assembly.
    inputBinding:
      position: 101
      prefix: --no-reduction-reads
  - id: redo
    type:
      - 'null'
      - boolean
    doc: Do not use previously generated intermediate results.
    inputBinding:
      position: 101
      prefix: --redo
  - id: stopafter
    type:
      - 'null'
      - string
    doc: 'Stop after this step: data or flye1.'
    inputBinding:
      position: 101
      prefix: --stopafter
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (log).
  - id: outdir_out
    type: Directory
    doc: Output folder with all polap results.
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/polap:0.5.3.1--py312hdfd78af_0
stdout: polap_assemble1.out
