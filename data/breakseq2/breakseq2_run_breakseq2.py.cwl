cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_breakseq2.py
label: breakseq2_run_breakseq2.py
doc: "BreakSeq2: Ultrafast and accurate nucleotide-resolution analysis of structural
  variants\n\nTool homepage: http://bioinform.github.io/breakseq2"
inputs:
  - id: bams
    type:
      type: array
      items: File
    doc: Alignment BAMs
    inputBinding:
      position: 1
  - id: chromosomes
    type:
      - 'null'
      - type: array
        items: string
    doc: List of chromosomes to process
    inputBinding:
      position: 2
  - id: bplib
    type:
      - 'null'
      - File
    doc: Breakpoint library FASTA
    inputBinding:
      position: 103
      prefix: --bplib
  - id: bplib_gff
    type:
      - 'null'
      - File
    doc: Breakpoint GFF input
    inputBinding:
      position: 103
      prefix: --bplib_gff
  - id: bwa
    type: string
    doc: Path to BWA executable
    inputBinding:
      position: 103
      prefix: --bwa
  - id: format_version
    type:
      - 'null'
      - int
    doc: Version of breakpoint library format to use
    inputBinding:
      position: 103
      prefix: --format_version
  - id: junction_length
    type:
      - 'null'
      - int
    doc: Junction length
    inputBinding:
      position: 103
      prefix: --junction_length
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: Keep temporary files
    inputBinding:
      position: 103
      prefix: --keep_temp
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: Min overlap
    inputBinding:
      position: 103
      prefix: --min_overlap
  - id: min_span
    type:
      - 'null'
      - int
    doc: Minimum span for junction
    inputBinding:
      position: 103
      prefix: --min_span
  - id: nthreads
    type:
      - 'null'
      - int
    doc: Number of processes to use for parallelism
    inputBinding:
      position: 103
      prefix: --nthreads
  - id: reference
    type: File
    doc: Reference FASTA
    inputBinding:
      position: 103
      prefix: --reference
  - id: sample
    type:
      - 'null'
      - string
    doc: Sample name. Leave unspecified to infer sample name from BAMs.
    inputBinding:
      position: 103
      prefix: --sample
  - id: samtools
    type: string
    doc: Path to SAMtools executable
    inputBinding:
      position: 103
      prefix: --samtools
  - id: window
    type:
      - 'null'
      - int
    doc: Window size
    inputBinding:
      position: 103
      prefix: --window
  - id: work
    type:
      - 'null'
      - Directory
    doc: Working directory
    inputBinding:
      position: 103
      prefix: --work
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/breakseq2:2.2--py27_0
stdout: breakseq2_run_breakseq2.py.out
