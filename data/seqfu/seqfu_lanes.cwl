cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqfu
  - lanes
label: seqfu_lanes
doc: "Merge Illumina lanes. This tool supports up to 8 lanes of Illumina-formatted\noutput files. Merged\
  \ lane output files will be in an uncompressed format.\n\nTool homepage: http://github.com/quadram-institute-bioscience/seqfu/"
inputs:
  - id: input_directory
    type: Directory
    doc: Input directory
    inputBinding:
      position: 1
  - id: outdir
    type: string
    doc: Output directory
    inputBinding:
      position: 102
      prefix: --outdir
  - id: extension
    type:
      - 'null'
      - string
    doc: 'File extension [default: .fastq]'
    inputBinding:
      position: 102
      prefix: --extension
  - id: file_separator
    type:
      - 'null'
      - string
    doc: 'Field separator in filenames [default: _]'
    inputBinding:
      position: 102
      prefix: --file-separator
  - id: comment_separator
    type:
      - 'null'
      - string
    doc: 'String separating sequence name and its comment [default: TAB]'
    inputBinding:
      position: 102
      prefix: --comment-separator
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
  - id: merged_dir
    type:
      - 'null'
      - Directory
    doc: Directory with merged lane files
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.outdir)
        entry: '$({class: ''Directory'', basename: inputs.outdir, listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
stdout: seqfu_lanes.out
