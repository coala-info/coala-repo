cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - magcluster
  - mgc_screen
label: magcluster_mgc_screen
doc: "Analyzes .gbk/.gbf files to identify potential MGCs based on magnetosome gene
  content within specified windows.\n\nTool homepage: https://github.com/runjiaji/magcluster"
inputs:
  - id: gbkfile
    type:
      type: array
      items: File
    doc: .gbk/.gbf files to be analyzed. Multiple files or files-containing 
      folder is acceptable.
    inputBinding:
      position: 1
  - id: contiglength
    type:
      - 'null'
      - int
    doc: The minimum length of contigs to be considered
    default: '2000'
    inputBinding:
      position: 102
      prefix: --contiglength
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output folder
    default: mgc_screen
    inputBinding:
      position: 102
      prefix: --outdir
  - id: threshold
    type:
      - 'null'
      - int
    doc: The minimum number of magnetosome genes in a given contig and a given 
      length of screening window
    default: 3
    inputBinding:
      position: 102
      prefix: --threshold
  - id: windowsize
    type:
      - 'null'
      - int
    doc: The length of MGCs screening window
    default: '10000'
    inputBinding:
      position: 102
      prefix: --windowsize
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/magcluster:0.2.5--pyhdfd78af_0
stdout: magcluster_mgc_screen.out
