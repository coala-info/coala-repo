cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslSplitOnTarget
label: ucsc-pslsplitontarget
doc: "Split a PSL file into multiple files, one for each target sequence.\n\nTool
  homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: psl_in
    type: File
    doc: Input PSL file to be split.
    inputBinding:
      position: 1
outputs:
  - id: out_dir
    type: Directory
    doc: Output directory where the split PSL files will be written.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslsplitontarget:482--h0b57e2e_0
