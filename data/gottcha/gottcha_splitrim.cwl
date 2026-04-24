cwlVersion: v1.2
class: CommandLineTool
baseCommand: splitrim
label: gottcha_splitrim
doc: "Splits a FASTA/FASTQ file into smaller files based on sequence names.\n\nTool
  homepage: https://github.com/poeli/GOTTCHA"
inputs:
  - id: input_file
    type: File
    doc: Input FASTA or FASTQ file
    inputBinding:
      position: 1
  - id: case_insensitive
    type:
      - 'null'
      - boolean
    doc: Treat sequence names case-insensitively when splitting
    inputBinding:
      position: 102
      prefix: --case-insensitive
  - id: lines_per_file
    type:
      - 'null'
      - int
    doc: Number of lines per output file (for FASTQ)
    inputBinding:
      position: 102
      prefix: --lines-per-file
  - id: num_files
    type:
      - 'null'
      - int
    doc: Number of output files to create
    inputBinding:
      position: 102
      prefix: --num-files
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory to write output files to
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files
    inputBinding:
      position: 102
      prefix: --prefix
  - id: split_by_name
    type:
      - 'null'
      - boolean
    doc: Split sequences based on their names (e.g., 'seq1_part1', 'seq1_part2')
    inputBinding:
      position: 102
      prefix: --split-by-name
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gottcha:1.0--pl526_2
stdout: gottcha_splitrim.out
