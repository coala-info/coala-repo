cwlVersion: v1.2
class: CommandLineTool
baseCommand: capcruncher alignments
label: capcruncher_alignments
doc: "Alignment annotation, identification and deduplication.\n\nTool homepage: https://github.com/sims-lab/CapCruncher.git"
inputs:
  - id: annotate
    type:
      - 'null'
      - boolean
    doc: Annotates a bed file with other bed files using bedtools...
    inputBinding:
      position: 101
      prefix: annotate
  - id: filter
    type:
      - 'null'
      - boolean
    doc: Removes unwanted aligned slices and identifies reporters.
    inputBinding:
      position: 101
      prefix: filter
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capcruncher:0.3.14--pyhdfd78af_1
stdout: capcruncher_alignments.out
