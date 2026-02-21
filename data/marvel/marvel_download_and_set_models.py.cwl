cwlVersion: v1.2
class: CommandLineTool
baseCommand: marvel_download_and_set_models.py
label: marvel_download_and_set_models.py
doc: "Download and set models for MARVEL\n\nTool homepage: http://github.com/quadram-institute-bioscience/marvel/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/marvel:0.2--py39hdfd78af_4
stdout: marvel_download_and_set_models.py.out
