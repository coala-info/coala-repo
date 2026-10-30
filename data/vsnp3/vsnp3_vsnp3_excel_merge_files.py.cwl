cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp3_excel_merge_files.py
label: vsnp3_vsnp3_excel_merge_files.py
doc: "Merge multiple Excel files into a single file in the same directory.\n\nTool homepage:\
  \ https://github.com/USDA-VS/vsnp3"
inputs:
  - id: input_dir
    type:
      - 'null'
      - string
    doc: 'Directory containing input Excel files (default: .)'
    inputBinding:
      position: 101
      prefix: --input-dir
  - id: pattern
    type:
      - 'null'
      - string
    doc: 'File pattern to match Excel files (e.g., ''*.xlsx'', ''data_*.xls'') (default: *.xlsx)'
    inputBinding:
      position: 101
      prefix: --pattern
  - id: index_col
    type:
      - 'null'
      - string
    doc: 'Column to use as index (use ''None'' for no index) (default: sample)'
    inputBinding:
      position: 101
      prefix: --index-col
  - id: log_level
    type:
      - 'null'
      - type: enum
        symbols:
          - DEBUG
          - INFO
          - WARNING
          - ERROR
          - CRITICAL
        name: log_level
    doc: 'Set the logging level (default: INFO)'
    inputBinding:
      position: 101
      prefix: --log-level
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
      glob: combined_excel_*.xlsx
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.excel_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
stdout: vsnp3_vsnp3_excel_merge_files.py.stdout.txt
