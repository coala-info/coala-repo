cwlVersion: v1.2
class: CommandLineTool
baseCommand: PopDel
label: popdel_view
doc: "Displays a profile file in human readable format or unzips it.\n\nTool homepage:
  https://github.com/kehrlab/PopDel"
inputs:
  - id: profile_file
    type: File
    doc: Popdel profile file
    inputBinding:
      position: 1
  - id: full_help
    type:
      - 'null'
      - boolean
    doc: Displays full list of options.
    inputBinding:
      position: 102
      prefix: --fullHelp
  - id: only_write_header
    type:
      - 'null'
      - boolean
    doc: Only write the header.
    inputBinding:
      position: 102
      prefix: --onlyHeader
  - id: region
    type:
      - 'null'
      - string
    doc: Limit view to this genomic region.
    inputBinding:
      position: 102
      prefix: --region
  - id: write_header
    type:
      - 'null'
      - boolean
    doc: Write the header.
    inputBinding:
      position: 102
      prefix: --header
  - id: write_histograms
    type:
      - 'null'
      - boolean
    doc: Write insert size histograms.
    inputBinding:
      position: 102
      prefix: --histograms
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name for the unzipped profile.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popdel:1.5.0--h6b13edd_1
