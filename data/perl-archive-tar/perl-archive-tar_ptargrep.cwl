cwlVersion: v1.2
class: CommandLineTool
baseCommand: ptargrep
label: perl-archive-tar_ptargrep
doc: "Apply pattern matching to the contents of files in a tar archive\n\nTool homepage:
  https://metacpan.org/pod/Archive::Tar"
inputs:
  - id: pattern
    type: string
    doc: The pattern to match, used as a Perl regular expression
    inputBinding:
      position: 1
  - id: tar_files
    type:
      type: array
      items: File
    doc: One or more tar archive filenames to be processed
    inputBinding:
      position: 2
  - id: basename
    type:
      - 'null'
      - boolean
    doc: Ignore directory paths from archive and write to the current directory using
      the basename of the file
    inputBinding:
      position: 103
      prefix: --basename
  - id: ignore_case
    type:
      - 'null'
      - boolean
    doc: Make pattern matching case-insensitive
    inputBinding:
      position: 103
      prefix: --ignore-case
  - id: list_only
    type:
      - 'null'
      - boolean
    doc: List matching filenames rather than extracting matches
    inputBinding:
      position: 103
      prefix: --list-only
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Write debugging messages to STDERR
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-archive-tar:3.04--pl5321hdfd78af_0
stdout: perl-archive-tar_ptargrep.out
