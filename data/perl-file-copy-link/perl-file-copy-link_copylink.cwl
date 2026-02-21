cwlVersion: v1.2
class: CommandLineTool
baseCommand: copylink
label: perl-file-copy-link_copylink
doc: "Replace symbolic links with a copy of the linked file\n\nTool homepage: https://metacpan.org/pod/File::Copy::Link"
inputs:
  - id: links
    type:
      - 'null'
      - type: array
        items: File
    doc: Symbolic links to be replaced by copies of their target files
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-file-copy-link:0.200--pl5321h7b50bb2_0
stdout: perl-file-copy-link_copylink.out
