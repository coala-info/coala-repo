cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rampler
  - subsample
label: rampler_subsample
doc: 'Subsamples sequences (FASTA/FASTQ, optionally gzipped) to the requested coverage
  of a reference of given length.


  Tool homepage: https://github.com/rvaser/rampler'
inputs:
  - id: sequences
    type: File
    doc: input file in FASTA/FASTQ format (can be compressed with gzip)
    inputBinding:
      position: 2
  - id: reference_length
    type: int
    doc: integer denoting length of the reference genome (or assembly) from which
      the sequences originate
    inputBinding:
      position: 3
  - id: coverage
    type:
      type: array
      items: int
    doc: integer(s) denoting desired coverage of the subsampled sequences
    inputBinding:
      position: 4
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
stdout: rampler_subsample.out
