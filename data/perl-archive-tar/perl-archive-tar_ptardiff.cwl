cwlVersion: v1.2
class: CommandLineTool
baseCommand: ptardiff
label: perl-archive-tar_ptardiff
doc: "ptardiff is a small program that diffs an extracted archive against an unextracted
  one, using the perl module Archive::Tar. It lets you view changes made to an archive's
  contents by comparing files in the archive with files in the current working directory.\n
  \nTool homepage: https://metacpan.org/pod/Archive::Tar"
inputs:
  - id: archive_file
    type: File
    doc: The archive file to diff against the current working directory
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-archive-tar:3.04--pl5321hdfd78af_0
stdout: perl-archive-tar_ptardiff.out
