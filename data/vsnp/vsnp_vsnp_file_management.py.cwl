cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp_file_management.py
label: vsnp_vsnp_file_management.py
doc: "Rename the VCF files (or files of another extension) in the working directory from an\
  \ Excel genotype code file and write name_change_log.txt.\n\nTool homepage: https://github.com/USDA-VS/vSNP"
inputs:
  - id: codes
    type: File
    doc: 'Excel file containing genotype code. Column 1: to match sample name minus everything
      left of first occurring _ or . Column 2: New name'
    inputBinding:
      position: 101
      prefix: -g
  - id: extension
    type:
      - 'null'
      - string
    doc: File extension type to be renamed
    inputBinding:
      position: 101
      prefix: -e
  - id: input_files
    type:
      type: array
      items: File
    doc: Files to rename (staged writable in the working directory)
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: renamed_files
    type:
      type: array
      items: File
    doc: Renamed files
    outputBinding:
      glob: '*.$(inputs.extension || "vcf")'
  - id: name_change_log
    type: File
    doc: Log of the name changes
    outputBinding:
      glob: name_change_log.txt
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_files)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp:2.03--hdfd78af_2
stdout: vsnp_vsnp_file_management.py.out
