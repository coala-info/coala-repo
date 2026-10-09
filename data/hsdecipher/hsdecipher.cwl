cwlVersion: v1.2
class: CommandLineTool
baseCommand: hsdecipher
label: hsdecipher
doc: "Generate a heatmap from HSD and KO file folders with specified dimensions.\n\
  \nTool homepage: https://github.com/zx0223winner/HSDecipher"
inputs:
  - id: col_size
    type: int
    doc: length/height of output heatmap
    inputBinding:
      position: 101
      prefix: --col_size
  - id: hsd_files_path
    type: Directory
    doc: HSD file folder
    inputBinding:
      position: 101
      prefix: --hsd_files_path
  - id: ko_files_path
    type: Directory
    doc: KO file folder
    inputBinding:
      position: 101
      prefix: --ko_files_path
  - id: row_size
    type: int
    doc: width of output heatmap
    inputBinding:
      position: 101
      prefix: --row_size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: heatmap_eps
    type:
      - 'null'
      - File
    doc: heatmap figure (EPS), named <HSD folder name>.output_heatmap.eps
    outputBinding:
      glob: '*.output_heatmap.eps'
  - id: heatmap_table
    type:
      - 'null'
      - File
    doc: table behind the heatmap, named <HSD folder name>.output_heatmap.tsv
    outputBinding:
      glob: '*.output_heatmap.tsv'
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: MPLCONFIGDIR
        envValue: $(runtime.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hsdecipher:1.1.2--hdfd78af_0
stdout: hsdecipher.out
