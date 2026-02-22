cwlVersion: v1.2
class: CommandLineTool
baseCommand: bmtagger
label: bmtagger
doc: "BMTagger (Best Match Tagger) is a tool used to filter out specific DNA sequences
  (e.g., human contamination) from genomic datasets.\n\nTool homepage: https://github.com/movingpictures83/BMTagger"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bmtagger:3.101--h470a237_4
stdout: bmtagger.out
