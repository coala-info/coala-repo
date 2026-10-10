cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mGEMS
  - extract
label: mgems_extract
doc: "Extract the binned reads from the original mixed samples (mGEMS extract), using
  the .bin files written by mGEMS bin.\n\nTool homepage: https://github.com/PROBIC/mGEMS"
inputs:
  - id: input_reads
    type:
      type: array
      items: File
    doc: Comma-separated list of input read(s).
    inputBinding:
      position: 101
      prefix: -r
      itemSeparator: ','
  - id: bins
    type:
      type: array
      items: File
    doc: Comma-separated list of bins (.bin files from mGEMS bin) to extract from
      the input reads.
    inputBinding:
      position: 101
      prefix: --bins
      itemSeparator: ','
  - id: compress
    type:
      - 'null'
      - boolean
    doc: 'Toggle compression of the output files. Compression is on by default; giving this flag turns it off (writes plain text).'
    inputBinding:
      position: 101
      prefix: --compress
  - id: output_directory_path
    type: string
    doc: Output directory (created before the run).
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output_directory
    type: Directory
    doc: Output directory with the extracted reads
    outputBinding:
      glob: $(inputs.output_directory_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.output_directory_path)
        entry: '$({"class": "Directory", "basename": inputs.output_directory_path, "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgems:1.3.3--h13024bc_2
