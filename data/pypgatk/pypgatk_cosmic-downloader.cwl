cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pypgatk
  - cosmic-downloader
label: pypgatk_cosmic-downloader
doc: "Download mutation data from COSMIC\n\nTool homepage: http://github.com/bigbio/py-pgatk"
inputs:
  - id: token
    type:
      - 'null'
      - string
    doc: COSMIC API token for authentication.
    inputBinding:
      position: 101
      prefix: --token
  - id: url_file
    type: File
    doc: Path to a file containing URLs of mutation data to download.
    inputBinding:
      position: 101
      prefix: --url_file
outputs:
  - id: mutation_output_file
    type:
      - 'null'
      - File
    doc: Path to save the downloaded mutation data.
    outputBinding:
      glob: $(inputs.mutation_output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgatk:0.0.24--pyhdfd78af_0
