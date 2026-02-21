cwlVersion: v1.2
class: CommandLineTool
baseCommand: htsfile
label: htslib_htsfile
doc: "Identify file formats and check hashes of genomic data files.\n\nTool homepage:
  https://github.com/samtools/htslib"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: One or more files to identify or check
    inputBinding:
      position: 1
  - id: check_hash
    type:
      - 'null'
      - boolean
    doc: Check the hash of the file
    inputBinding:
      position: 102
      prefix: --chkhash
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
    dockerPull: quay.io/biocontainers/htslib:1.23--h566b1c6_0
stdout: htslib_htsfile.out
