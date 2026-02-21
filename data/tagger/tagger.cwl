cwlVersion: v1.2
class: CommandLineTool
baseCommand: tagger
label: tagger
doc: "The provided text is an error log from a container build process and does not
  contain help documentation or usage instructions for the 'tagger' tool.\n\nTool
  homepage: https://bitbucket.org/larsjuhljensen/tagger"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tagger:1.1--py312hf731ba3_2
stdout: tagger.out
