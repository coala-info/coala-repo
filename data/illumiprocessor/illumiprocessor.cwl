cwlVersion: v1.2
class: CommandLineTool
baseCommand: illumiprocessor
label: illumiprocessor
doc: "Batch trim Illumina reads for adapter contamination and low quality bases using
  Trimmomatic\n\nTool homepage: https://github.com/faircloth-lab/illumiprocessor"
inputs:
  - id: config
    type: File
    doc: A configuration file containing the tag:sample mapping and renaming 
      options.
    inputBinding:
      position: 101
      prefix: --config
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of compute cores to use.
    inputBinding:
      position: 101
      prefix: --cores
  - id: input
    type: Directory
    doc: The input directory of raw reads to trim.
    inputBinding:
      position: 101
      prefix: --input
  - id: log_path
    type:
      - 'null'
      - Directory
    doc: The path to a directory to hold logs.
    inputBinding:
      position: 101
      prefix: --log-path
  - id: min_len
    type:
      - 'null'
      - int
    doc: The minimum length of reads to keep.
    inputBinding:
      position: 101
      prefix: --min-len
  - id: no_merge
    type:
      - 'null'
      - boolean
    doc: When trimming PE reads, do not merge singleton files.
    inputBinding:
      position: 101
      prefix: --no-merge
  - id: output
    type: Directory
    doc: The output directory of clean reads to create.
    inputBinding:
      position: 101
      prefix: --output
  - id: phred
    type:
      - 'null'
      - string
    doc: The type of fastq encoding used.
    inputBinding:
      position: 101
      prefix: --phred
  - id: r1_pattern
    type:
      - 'null'
      - string
    doc: An optional regex pattern to find R1 reads.
    inputBinding:
      position: 101
      prefix: --r1-pattern
  - id: r2_pattern
    type:
      - 'null'
      - string
    doc: An optional regex pattern to find R2 reads.
    inputBinding:
      position: 101
      prefix: --r2-pattern
  - id: se
    type:
      - 'null'
      - boolean
    doc: Single-end reads.
    inputBinding:
      position: 101
      prefix: --se
  - id: trimmomatic
    type:
      - 'null'
      - File
    doc: The path to the trimmomatic-0.XX.jar file.
    inputBinding:
      position: 101
      prefix: --trimmomatic
  - id: verbosity
    type:
      - 'null'
      - string
    doc: The logging level to use.
    inputBinding:
      position: 101
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/illumiprocessor:2.10--py_0
stdout: illumiprocessor.out
