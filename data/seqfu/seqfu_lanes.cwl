cwlVersion: v1.2
class: CommandLineTool
baseCommand: lanes
label: seqfu_lanes
doc: "This tool supports up to 8 lanes of Illumina-formatted output files.\nMerged
  lane output files will be in an uncompressed format.\n\nTool homepage: http://github.com/quadram-institute-bioscience/seqfu/"
inputs:
  - id: input_directory
    type: Directory
    doc: Input directory
    inputBinding:
      position: 1
  - id: comment_separator
    type:
      - 'null'
      - string
    doc: String separating sequence name and its comment
    inputBinding:
      position: 102
      prefix: --comment-separator
  - id: extension
    type:
      - 'null'
      - string
    doc: File extension
    inputBinding:
      position: 102
      prefix: --extension
  - id: file_separator
    type:
      - 'null'
      - string
    doc: Field separator in filenames
    inputBinding:
      position: 102
      prefix: --file-separator
  - id: outdir
    type: Directory
    doc: Output directory
    inputBinding:
      position: 102
      prefix: --outdir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
stdout: seqfu_lanes.out
