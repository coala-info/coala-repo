cwlVersion: v1.2
class: CommandLineTool
baseCommand: chewieSnake_join
label: chewiesnake_chewieSnake_join
doc: "A tool within the chewieSnake pipeline, likely used for joining or aggregating
  results.\n\nTool homepage: https://gitlab.com/bfr_bioinformatics/chewieSnake"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chewiesnake:3.0.0--hdfd78af_2
stdout: chewiesnake_chewieSnake_join.out
