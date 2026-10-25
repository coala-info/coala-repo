cwlVersion: v1.2
class: CommandLineTool
baseCommand: splitFileByColumn
label: ucsc-splitfilebycolumn_splitFileByColumn
doc: "Split text input into files named by column value\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: source
    type: File
    doc: Source file to split
    inputBinding:
      position: 1
  - id: out_dir
    type: string
    doc: Output directory (created by the tool)
    inputBinding:
      position: 2
  - id: col
    type:
      - 'null'
      - int
    doc: Use the Nth column value (default 1)
    inputBinding:
      position: 0
      prefix: -col=
      separate: false
  - id: head
    type:
      - 'null'
      - File
    doc: Put head in front of each output
    inputBinding:
      position: 0
      prefix: -head=
      separate: false
  - id: tail
    type:
      - 'null'
      - File
    doc: Put tail at end of each output
    inputBinding:
      position: 0
      prefix: -tail=
      separate: false
  - id: chrom_dirs
    type:
      - 'null'
      - boolean
    doc: Split into subdirs of outDir that are distilled from chrom names, e.g. chr3_random -> outDir/3/chr3_random.XXX .
    inputBinding:
      position: 0
      prefix: -chromDirs
  - id: ending
    type:
      - 'null'
      - string
    doc: 'Use XXX as the dot-suffix of split files (default: taken from source).'
    inputBinding:
      position: 0
      prefix: -ending=
      separate: false
  - id: tab
    type:
      - 'null'
      - boolean
    doc: Split by tab characters instead of whitespace.
    inputBinding:
      position: 0
      prefix: -tab
outputs:
  - id: out_dir_dir
    type: Directory
    doc: Output directory with one file per column value
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-splitfilebycolumn:482--h0b57e2e_0
