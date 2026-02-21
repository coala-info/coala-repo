cwlVersion: v1.2
class: CommandLineTool
baseCommand: wordcloud
label: wordcloud
doc: "A tool for generating word clouds\n\nTool homepage: https://github.com/timdream/wordcloud2.js"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wordcloud:1.9.4
stdout: wordcloud.out
