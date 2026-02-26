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
    type: Directory
    doc: Output directory
    inputBinding:
      position: 2
  - id: chrom_dirs
    type:
      - 'null'
      - boolean
    doc: Split into subdirs of outDir that are distilled from chrom names, e.g. 
      chr3_random -> outDir/3/chr3_random.XXX .
    inputBinding:
      position: 103
      prefix: -chromDirs
  - id: col
    type:
      - 'null'
      - int
    doc: Use the Nth column value
    default: 1
    inputBinding:
      position: 103
      prefix: -col
  - id: ending
    type:
      - 'null'
      - string
    doc: 'Use XXX as the dot-suffix of split files (default: taken from source).'
    inputBinding:
      position: 103
      prefix: -ending
  - id: head
    type:
      - 'null'
      - File
    doc: Put head in front of each output
    inputBinding:
      position: 103
      prefix: -head
  - id: tab
    type:
      - 'null'
      - boolean
    doc: Split by tab characters instead of whitespace.
    inputBinding:
      position: 103
      prefix: -tab
  - id: tail
    type:
      - 'null'
      - File
    doc: Put tail at end of each output
    inputBinding:
      position: 103
      prefix: -tail
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-splitfilebycolumn:482--h0b57e2e_0
stdout: ucsc-splitfilebycolumn_splitFileByColumn.out
