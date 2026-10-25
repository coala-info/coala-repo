cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslSplitOnTarget
label: ucsc-pslsplitontarget
doc: "Split a PSL file into one file per target sequence.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_psl
    type: File
    doc: Input PSL file to be split.
    inputBinding:
      position: 10
  - id: out_dir
    type: string
    doc: Output directory name; one PSL file per target is written there.
    inputBinding:
      position: 11
  - id: max_target_count
    type:
      - 'null'
      - int
    doc: Maximum allowed targets (default is 300). This implementation keeps an
      open file handle for each target.
    inputBinding:
      position: 1
      prefix: -maxTargetCount=
      separate: false
  - id: lump
    type:
      - 'null'
      - boolean
    doc: Useful with scaffolds, hashes on the target name to lump targets together
      (creates maxTargetCount lumps off the scaffold name hash).
    inputBinding:
      position: 2
      prefix: -lump
outputs:
  - id: out_dir_files
    type: Directory
    doc: Directory with one PSL file per target.
    outputBinding:
      glob: $(inputs.out_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslsplitontarget:482--h0b57e2e_0
