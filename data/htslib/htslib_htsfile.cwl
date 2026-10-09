cwlVersion: v1.2
class: CommandLineTool
baseCommand: htsfile
label: htslib_htsfile
doc: "Identify file formats and check hashes of genomic data files.\n\nTool homepage: https://github.com/samtools/htslib"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: One or more files to identify or view; with --copy this is the single source file
    inputBinding:
      position: 200
  - id: dest_file
    type:
      - 'null'
      - string
    doc: Destination file name, required with --copy
    inputBinding:
      position: 201
  - id: view
    type:
      - 'null'
      - boolean
    doc: Write textual form of FILEs to standard output
    inputBinding:
      position: 101
      prefix: --view
  - id: copy
    type:
      - 'null'
      - boolean
    doc: Copy the exact contents of FILE to DESTFILE
    inputBinding:
      position: 102
      prefix: --copy
  - id: header_only
    type:
      - 'null'
      - boolean
    doc: Display only headers in view mode, not records
    inputBinding:
      position: 103
      prefix: --header-only
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: Suppress header display in view mode
    inputBinding:
      position: 104
      prefix: --no-header
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase verbosity of warnings and diagnostics
    inputBinding:
      position: 105
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: copied_file
    type:
      - 'null'
      - File
    doc: Copy of the input file written with --copy
    outputBinding:
      glob: $(inputs.dest_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/htslib:1.23--h566b1c6_0
stdout: htslib_htsfile.out
