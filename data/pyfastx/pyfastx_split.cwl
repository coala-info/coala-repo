cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfastx split
label: pyfastx_split
doc: "Split a fasta or fastq file into multiple smaller files.\n\nTool homepage: https://github.com/lmdu/pyfastx"
inputs:
  - id: fastx
    type: File
    doc: fasta or fastq file, gzip support
    inputBinding:
      position: 1
  - id: num_files
    type:
      - 'null'
      - int
    doc: split a fasta/q file into N new files with even size
    inputBinding:
      position: 102
      prefix: -n
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: output directory, default is current folder
    inputBinding:
      position: 102
      prefix: --out-dir
  - id: seq_count
    type:
      - 'null'
      - int
    doc: split a fasta/q file into multiple files containing the same sequence 
      counts
    inputBinding:
      position: 102
      prefix: -c
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastx:2.3.0--py312h4711d71_1
stdout: pyfastx_split.out
