cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp_excel_merge_files.py
label: vsnp_vsnp_excel_merge_files.py
doc: "Merge all Excel (.xlsx) files in the working directory into a single combined_excelworksheets-<time>.xlsx\
  \ file. The script has no options; it reads every *.xlsx file in the current folder.\n\n\
  Tool homepage: https://github.com/USDA-VS/vSNP"
inputs:
  - id: excel_files
    type:
      type: array
      items: File
    doc: Excel files to merge (staged in the working directory)
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: combined_excel
    type: File
    doc: Merged Excel workbook
    outputBinding:
      glob: combined_excelworksheets-*.xlsx
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.excel_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp:2.03--hdfd78af_2
stdout: vsnp_vsnp_excel_merge_files.py.out
