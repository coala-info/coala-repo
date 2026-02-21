cwlVersion: v1.2
class: CommandLineTool
baseCommand: STAR
label: rna-star
doc: "Spliced Transcripts Alignment to a Reference (RNA-seq aligner)\n\nTool homepage:
  https://github.com/alexdobin/STAR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rna-star:v2.7.0adfsg-1-deb_cv1
stdout: rna-star.out
