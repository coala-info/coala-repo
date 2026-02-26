cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ggcat
  - matches
label: ggcat_matches
doc: "ggcat-matches 2.0.0\n\nTool homepage: https://github.com/algbio/ggcat"
inputs:
  - id: input_file
    type: File
    doc: Input fasta file with associated colors file (in the same folder)
    inputBinding:
      position: 1
  - id: match_color
    type: string
    doc: Debug print matches of a color index (in hexadecimal)
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ggcat:2.0.0--ha96b9cd_0
stdout: ggcat_matches.out
