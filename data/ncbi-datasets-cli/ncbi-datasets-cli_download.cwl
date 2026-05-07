cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - datasets
  - download
label: ncbi-datasets-cli_download
doc: Download genome, gene and virus data packages, including sequence, 
  annotation, and metadata, as a zip file.
inputs:
  - id: command
    type: string
    doc: The specific data package type to download (gene, genome, or virus)
    inputBinding:
      position: 1
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
