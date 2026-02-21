cwlVersion: v1.2
class: CommandLineTool
baseCommand: tar
label: perl-archive-tar-wrapper_tar
doc: "Create, extract, or list files from a tar file\n\nTool homepage: http://metacpan.org/pod/Archive::Tar::Wrapper"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files to operate on
    inputBinding:
      position: 1
  - id: create
    type:
      - 'null'
      - boolean
    doc: Create
    inputBinding:
      position: 102
      prefix: -c
  - id: directory
    type:
      - 'null'
      - Directory
    doc: Change to DIR before operation
    inputBinding:
      position: 102
      prefix: -C
  - id: exclude
    type:
      - 'null'
      - string
    doc: File to exclude
    inputBinding:
      position: 102
      prefix: --exclude
  - id: exclude_file_list
    type:
      - 'null'
      - File
    doc: File with names to exclude
    inputBinding:
      position: 102
      prefix: -X
  - id: extract
    type:
      - 'null'
      - boolean
    doc: Extract
    inputBinding:
      position: 102
      prefix: -x
  - id: extract_to_stdout
    type:
      - 'null'
      - boolean
    doc: Extract to stdout
    inputBinding:
      position: 102
      prefix: -O
  - id: follow_symlinks
    type:
      - 'null'
      - boolean
    doc: Follow symlinks
    inputBinding:
      position: 102
      prefix: -h
  - id: include_file_list
    type:
      - 'null'
      - File
    doc: File with names to include
    inputBinding:
      position: 102
      prefix: -T
  - id: list
    type:
      - 'null'
      - boolean
    doc: List
    inputBinding:
      position: 102
      prefix: -t
  - id: tarfile
    type:
      - 'null'
      - File
    doc: Name of TARFILE ('-' for stdin/out)
    inputBinding:
      position: 102
      prefix: -f
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-archive-tar-wrapper:0.33--pl526_0
stdout: perl-archive-tar-wrapper_tar.out
