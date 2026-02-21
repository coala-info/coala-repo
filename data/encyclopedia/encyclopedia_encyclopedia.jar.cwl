cwlVersion: v1.2
class: CommandLineTool
baseCommand: encyclopedia
label: encyclopedia_encyclopedia.jar
doc: "Encyclopedia is a library-based search engine for DIA (Data-Independent Acquisition)
  mass spectrometry data.\n\nTool homepage: https://bitbucket.org/searleb/encyclopedia/wiki/Home"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/encyclopedia:2.12.30--hdfd78af_0
stdout: encyclopedia_encyclopedia.jar.out
