cwlVersion: v1.2
class: CommandLineTool
baseCommand: art_df
label: art_df
doc: "Display information about the amount of available disk space on file systems.\n
  \nTool homepage: https://github.com/jlevy/the-art-of-command-line"
inputs:
  - id: file
    type:
      - 'null'
      - type: array
        items: File
    doc: Optional file or directory to check the disk space usage for the file system
      containing it.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/art:2016.06.05--h0704011_13
stdout: art_df.out
