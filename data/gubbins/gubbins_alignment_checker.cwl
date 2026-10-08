cwlVersion: v1.2
class: CommandLineTool
baseCommand: gubbins_alignment_checker.py
label: gubbins_alignment_checker
doc: "Script to evaluate and reformat an alignment prior to Gubbins analysis\n\nTool homepage: https://github.com/nickjcroucher/gubbins"
inputs:
  - id: aln
    type: File
    doc: "Multifasta alignment filename"
    inputBinding:
      position: 101
      prefix: --aln
  - id: out_aln
    type:
      - 'null'
      - string
    doc: "Reformatted alignment filename"
    inputBinding:
      position: 102
      prefix: --out-aln
  - id: out
    type: string
    doc: "Output CSV filename"
    inputBinding:
      position: 103
      prefix: --out
outputs:
  - id: report_csv
    type: File
    doc: "CSV report of the alignment check"
    outputBinding:
      glob: $(inputs.out)
  - id: reformatted_alignment
    type:
      - 'null'
      - File
    doc: "Reformatted alignment"
    outputBinding:
      glob: $(inputs.out_aln)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gubbins:3.4.3--py39h746d604_0
