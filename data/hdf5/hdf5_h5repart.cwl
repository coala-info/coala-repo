cwlVersion: v1.2
class: CommandLineTool
baseCommand: h5repart
label: hdf5_h5repart
doc: "Repartitions a file or family of files into a family of files with a different member size, or converts a family of files into a single file.\n\nTool homepage: https://github.com/HDFGroup/hdf5"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Produce verbose output
    inputBinding:
      position: 101
      prefix: -v
  - id: block_size
    type:
      - 'null'
      - string
    doc: The I/O block size, defaults to 1kB. Sizes may be suffixed with g for GB, m for MB or k for kB.
    inputBinding:
      position: 102
      prefix: -b
  - id: member_size
    type:
      - 'null'
      - string
    doc: The destination member size or 1GB. Sizes may be suffixed with g for GB, m for MB or k for kB.
    inputBinding:
      position: 103
      prefix: -m
  - id: family_to_sec2
    type:
      - 'null'
      - boolean
    doc: Change file driver from family to sec2
    inputBinding:
      position: 104
      prefix: -family_to_sec2
  - id: source_file
    type: File
    doc: The name of the source file
    inputBinding:
      position: 201
  - id: destination_name
    type: string
    doc: The name of the destination files. File family names include an integer printf format such as %d.
    inputBinding:
      position: 202
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Destination file or family of files
    outputBinding:
      glob: $(inputs.destination_name.replace(/%[0-9]*d/, '*'))
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hdf5:1.10.4
stdout: hdf5_h5repart.out
