cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfainject
label: gfainject
doc: "Injects sequence information from BAM/PAF/GBAM files into a GFA graph.\n\nTool
  homepage: https://github.com/AndreaGuarracino/gfainject"
inputs:
  - id: alt_hits
    type:
      - 'null'
      - int
    doc: Emit up to ALT_HITS alternative alignments (from XA tag, only for 
      BAM/GBAM input)
    inputBinding:
      position: 101
      prefix: --alt-hits
  - id: bam
    type:
      - 'null'
      - File
    doc: Path to input BAM file
    inputBinding:
      position: 101
      prefix: --bam
  - id: gbam
    type:
      - 'null'
      - File
    doc: Path to input GBAM file
    inputBinding:
      position: 101
      prefix: --gbam
  - id: gfa
    type: File
    doc: Path to input GFA file
    inputBinding:
      position: 101
      prefix: --gfa
  - id: paf
    type:
      - 'null'
      - File
    doc: Path to input PAF file
    inputBinding:
      position: 101
      prefix: --paf
  - id: range
    type:
      - 'null'
      - string
    doc: Range query in format "path_name:start-end"
    inputBinding:
      position: 101
      prefix: --range
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfainject:0.2.0--h3ab6199_0
stdout: gfainject.out
