cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rampler
  - split
label: rampler_split
doc: 'Splits sequences (FASTA/FASTQ, optionally gzipped) into smaller chunks of about
  the given size in bytes.


  Tool homepage: https://github.com/rvaser/rampler'
inputs:
  - id: sequences
    type: File
    doc: input file in FASTA/FASTQ format (can be compressed with gzip)
    inputBinding:
      position: 2
  - id: chunk_size
    type: int
    doc: integer denoting the desired chunk size in bytes
    inputBinding:
      position: 3
  - id: out_directory
    type:
      - 'null'
      - string
    doc: 'path in which sampled files will be created (default: current directory)'
    default: rampler_out
    inputBinding:
      position: 101
      prefix: --out-directory
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_dir
    type: Directory
    doc: Directory with the written sequence files
    outputBinding:
      glob: $(inputs.out_directory)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.out_directory)
        entry: '$({"class": "Directory", "listing": []})'
        writable: true
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rampler:v1.1.0-1-deb_cv1
stdout: rampler_split.out
