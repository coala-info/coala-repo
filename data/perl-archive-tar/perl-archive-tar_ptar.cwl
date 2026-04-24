cwlVersion: v1.2
class: CommandLineTool
baseCommand: ptar
label: perl-archive-tar_ptar
doc: "ptar is a small, tar look-alike program that uses the perl module Archive::Tar
  to extract, create and list tar archives.\n\nTool homepage: https://metacpan.org/pod/Archive::Tar"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files to be added to the archive
    inputBinding:
      position: 1
  - id: archive_file
    type:
      - 'null'
      - File
    doc: Name of the ARCHIVE_FILE to use. Default is './default.tar'
    inputBinding:
      position: 102
      prefix: -f
  - id: compressed
    type:
      - 'null'
      - boolean
    doc: Read/Write zlib compressed ARCHIVE_FILE (not always available)
    inputBinding:
      position: 102
      prefix: -z
  - id: cpan_mode
    type:
      - 'null'
      - boolean
    doc: CPAN mode - drop 022 from permissions
    inputBinding:
      position: 102
      prefix: -C
  - id: create
    type:
      - 'null'
      - boolean
    doc: Create ARCHIVE_FILE or STDOUT (-) from FILE
    inputBinding:
      position: 102
      prefix: -c
  - id: d_option
    type:
      - 'null'
      - boolean
    doc: Boolean (without arguments) option -d
    inputBinding:
      position: 102
      prefix: -d
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Boolean (without arguments) option -D
    inputBinding:
      position: 102
      prefix: -D
  - id: extract
    type:
      - 'null'
      - boolean
    doc: Extract from ARCHIVE_FILE or STDIN (-)
    inputBinding:
      position: 102
      prefix: -x
  - id: files_from
    type:
      - 'null'
      - File
    doc: get names to create from file
    inputBinding:
      position: 102
      prefix: -T
  - id: i_option
    type:
      - 'null'
      - boolean
    doc: Boolean (without arguments) option -I
    inputBinding:
      position: 102
      prefix: -I
  - id: list
    type:
      - 'null'
      - boolean
    doc: List the contents of ARCHIVE_FILE or STDIN (-)
    inputBinding:
      position: 102
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print filenames as they are added or extracted from ARCHIVE_FILE
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-archive-tar:3.04--pl5321hdfd78af_0
stdout: perl-archive-tar_ptar.out
