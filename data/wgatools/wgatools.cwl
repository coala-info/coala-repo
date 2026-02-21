cwlVersion: v1.2
class: CommandLineTool
baseCommand: wgatools
label: wgatools
doc: "A tool for whole-genome alignment (WGA) post-processing and analysis.\n\nTool
  homepage: https://github.com/wjwei-handsome/wgatools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wgatools:1.1.0--hf6a8760_0
stdout: wgatools.out
