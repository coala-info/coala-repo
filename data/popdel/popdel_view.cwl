cwlVersion: v1.2
class: CommandLineTool
baseCommand: [popdel, view]
label: popdel_view
doc: "Displays a profile file in human readable format or unzips it.\n\nTool homepage: https://github.com/kehrlab/PopDel"
inputs:
  - id: header
    type:
      - 'null'
      - boolean
    doc: "Write the header."
    inputBinding:
      position: 1
      prefix: --header
  - id: only_header
    type:
      - 'null'
      - boolean
    doc: "Only write the header."
    inputBinding:
      position: 1
      prefix: --onlyHeader
  - id: histograms
    type:
      - 'null'
      - boolean
    doc: "Write insert size histograms."
    inputBinding:
      position: 1
      prefix: --histograms
  - id: out_path
    type:
      - 'null'
      - string
    doc: "Output file name for the unzipped profile."
    inputBinding:
      position: 1
      prefix: --out
  - id: region
    type:
      - 'null'
      - string
    doc: "Limit view to this genomic region (CHR:BEGIN-END)."
    inputBinding:
      position: 1
      prefix: --region
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: "Partition the output profile into chunks of the given size in bp. The output file name is extended by the generated regions."
    inputBinding:
      position: 1
      prefix: --chunk-size
  - id: padding
    type:
      - 'null'
      - int
    doc: "Add the given number of padding bases to the end of each chunk, so that they overlap by that amount. In range [0..inf]. Default: 0."
    inputBinding:
      position: 1
      prefix: --padding
  - id: uncompressed_in
    type:
      - 'null'
      - boolean
    doc: "Read uncompressed binary profile."
    inputBinding:
      position: 1
      prefix: --uncompressed-in
  - id: index_region_size
    type:
      - 'null'
      - int
    doc: "Index region size for output profile. Default: Same as input profile."
    inputBinding:
      position: 1
      prefix: --index-region-size
  - id: profile_file
    type: File
    doc: "PopDel profile file"
    inputBinding:
      position: 100
outputs:
  - id: stdout
    type: stdout
    doc: "Profile in human readable format (empty when --out is used)"
  - id: out_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Output file(s) written with --out"
    outputBinding:
      glob: "$(inputs.out_path)*"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popdel:1.5.0--h6b13edd_1
stdout: popdel_view.out
