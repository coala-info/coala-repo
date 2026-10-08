cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - enasearch
  - get_download_options
label: enasearch_get_download_options
doc: "Get the options for download of data from ENA.\n\nEach option is described.\n\nTool homepage: http://bebatut.fr/enasearch/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enasearch:0.2.2--py27_0
stdout: enasearch_get_download_options.out
