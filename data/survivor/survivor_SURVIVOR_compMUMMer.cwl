cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - SURVIVOR
  - compMUMMer
label: survivor_compMUMMer
doc: "Annotates a VCF file with the breakpoints found with MUMMer (Show-diff)\n\nTool homepage: https://github.com/fritzsedlazeck/SURVIVOR"
inputs:
  - id: svs_vcf
    type: File
    doc: "SVs VCF file."
    inputBinding:
      position: 1
  - id: mummer_file_list
    type: File
    doc: "Text file listing the MUMMer show-diff output files, one file name per
      line. The names must match the staged files in mummer_files."
    inputBinding:
      position: 2
  - id: mummer_files
    type:
      type: array
      items: File
    doc: "Output files of MUMMer show-diff named in the list file (staged in the
      working directory so the names resolve)."
  - id: max_distance
    type: int
    doc: "Allowed distance (e.g. 100bp)."
    inputBinding:
      position: 3
  - id: output
    type: string
    doc: "Output: annotated vcf file."
    inputBinding:
      position: 4
outputs:
  - id: vcf
    type: File
    doc: "Annotated VCF file."
    outputBinding:
      glob: '$(inputs.output)'
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.mummer_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/survivor:1.0.7--h077b44d_7
stdout: survivor_compMUMMer.out
