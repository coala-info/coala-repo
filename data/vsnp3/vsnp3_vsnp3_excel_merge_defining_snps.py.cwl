cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp3_excel_merge_defining_snps.py
label: vsnp3_vsnp3_excel_merge_defining_snps.py
doc: "Merge two defining SNP Excel files and report the differences.\n\nTool homepage: https://github.com/USDA-VS/vsnp3"
inputs:
  - id: file1
    type:
      - 'null'
      - File
    doc: merge 1 file
    inputBinding:
      position: 101
      prefix: -f1
      valueFrom: $(self.basename)
  - id: file2
    type:
      - 'null'
      - File
    doc: merge 2 file
    inputBinding:
      position: 101
      prefix: -f2
      valueFrom: $(self.basename)
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: merged
    type:
      type: array
      items: File
    doc: Merged and difference workbooks
    outputBinding:
      glob:
        - merge_differences_*.xlsx
        - merge_auto_*.xlsx
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.file1)
      - entry: $(inputs.file2)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
stdout: vsnp3_vsnp3_excel_merge_defining_snps.py.stdout.txt
