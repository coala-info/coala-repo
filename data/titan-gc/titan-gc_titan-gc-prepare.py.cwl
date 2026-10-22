cwlVersion: v1.2
class: CommandLineTool
baseCommand: titan-gc-prepare.py
label: titan-gc_titan-gc-prepare.py
doc: "titan-gc-prepare - Read a directory and prepare a JSON for input to Titan GC\n\nTool homepage: https://github.com/theiagen/public_health_viral_genomics"
inputs:
  - id: fastq_path
    type: Directory
    doc: Directory where FASTQ files are stored
    inputBinding:
      position: 1
  - id: workflow
    type: string
    doc: "The Titan-GC workflow to use for analysis. Options: clearlabs, illumina_pe, illumina_se, ont"
    inputBinding:
      position: 2
  - id: primer
    type: File
    doc: A file containing primers (bed format) used during sequencing.
    inputBinding:
      position: 3
  - id: fastq_ext
    type:
      - 'null'
      - string
    doc: "Extension of the FASTQs. Default: .fastq.gz"
    inputBinding:
      position: 101
      prefix: --fastq_ext
  - id: fastq_separator
    type:
      - 'null'
      - string
    doc: "Split FASTQ name on the last occurrence of the separator. Default: _"
    inputBinding:
      position: 101
      prefix: --fastq_separator
  - id: fastq_pattern
    type:
      - 'null'
      - string
    doc: "Glob pattern to match FASTQs. Default: *.fastq.gz"
    inputBinding:
      position: 101
      prefix: --fastq_pattern
  - id: pe1_pattern
    type:
      - 'null'
      - string
    doc: "Designates difference first set of paired-end reads. Default: ([Aa]|[Rr]1|1) (R1, r1, 1, A, a)"
    inputBinding:
      position: 101
      prefix: --pe1_pattern
  - id: pe2_pattern
    type:
      - 'null'
      - string
    doc: "Designates difference second set of paired-end reads. Default: ([Bb]|[Rr]2|2) (R2, r2, 2, AB b)"
    inputBinding:
      position: 101
      prefix: --pe2_pattern
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Directories will be traversed recursively
    inputBinding:
      position: 101
      prefix: --recursive
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Replace the absolute path with a given string. Default: Use absolute path"
    inputBinding:
      position: 101
      prefix: --prefix
  - id: tsv
    type:
      - 'null'
      - boolean
    doc: Output FOFN as a TSV (Default JSON)
    inputBinding:
      position: 101
      prefix: --tsv
  - id: pangolin_docker
    type:
      - 'null'
      - string
    doc: Docker image used to run Pangolin (takes priority over --params)
    inputBinding:
      position: 101
      prefix: --pangolin_docker
  - id: params
    type:
      - 'null'
      - File
    doc: A JSON file containing parameter values
    inputBinding:
      position: 101
      prefix: --params
outputs:
  - id: stdout
    type: stdout
    doc: Titan GC input JSON (or TSV with --tsv) written to standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/titan-gc:1.5.3--hdfd78af_1
stdout: titan-gc_titan-gc-prepare.py.out
