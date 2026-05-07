cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - datasets
  - download
  - virus
label: datasets_download_virus
doc: Download a virus genome or SARS-CoV-2 protein data package as a zip file.
inputs:
  - id: subcommand
    type: string
    doc: The subcommand to execute (genome or protein)
    inputBinding:
      position: 1
  - id: api_key
    type:
      - 'null'
      - string
    doc: Specify an NCBI API key
    inputBinding:
      position: 102
      prefix: --api-key
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Emit debugging info
    inputBinding:
      position: 102
      prefix: --debug
  - id: filename
    type: string
    doc: Specify a custom file name for the downloaded data package
    inputBinding:
      position: 102
      prefix: --filename
  - id: no_progressbar
    type:
      - 'null'
      - boolean
    doc: Hide progress bar
    inputBinding:
      position: 102
      prefix: --no-progressbar
outputs:
  - id: output_filename
    type:
      - 'null'
      - File
    doc: Specify a custom file name for the downloaded data package
    outputBinding:
      glob: $(inputs.filename)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbi-datasets-cli:14.26.0
s:url: https://github.com/metagenlab/assembly_finder
$namespaces:
  s: https://schema.org/
