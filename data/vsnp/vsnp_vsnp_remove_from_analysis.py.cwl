cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp_remove_from_analysis.py
label: vsnp_vsnp_remove_from_analysis.py
doc: "Delete the VCF files (or files of another extension) listed in an Excel file from the\
  \ working directory.\n\nTool homepage: https://github.com/USDA-VS/vSNP"
inputs:
  - id: codes
    type: File
    doc: 'Excel file containing samples to remove from analysis. Column 1: to match sample
      name minus extension. No header allowed'
    inputBinding:
      position: 101
      prefix: -r
  - id: working_directory
    type:
      - 'null'
      - string
    doc: 'Optional: absolute path to the VCF files (default: current folder)'
    inputBinding:
      position: 101
      prefix: --cwd
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
    doc: Files to check (staged writable in the working directory)
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: remaining_files
    type:
      type: array
      items: File
    doc: Files left after the removal
    outputBinding:
      glob: '*.$(inputs.extension || "vcf")'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_files)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp:2.03--hdfd78af_2
stdout: vsnp_vsnp_remove_from_analysis.py.out
