cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - akt
  - relatives
label: akt_relatives
doc: "Derive a set of pedigrees from the akt kin output.\n\nTool homepage: https://github.com/Illumina/akt"
inputs:
  - id: iterations
    type:
      - 'null'
      - int
    doc: number of iterations to find unrelated
    inputBinding:
      position: 102
      prefix: --its
  - id: kmin
    type:
      - 'null'
      - float
    doc: threshold for relatedness
    inputBinding:
      position: 102
      prefix: --kmin
  - id: graph_out
    type:
      - 'null'
      - boolean
    doc: if present output pedigree graph files
    inputBinding:
      position: 103
      prefix: -g
  - id: prefix_path
    type:
      - 'null'
      - string
    doc: output file prefix (out)
    inputBinding:
      position: 104
      prefix: --prefix
  - id: ibd_file
    type: File
    doc: akt kin output file
    inputBinding:
      position: 105
outputs:
  - id: stdout
    type: stdout
    doc: Families, duplicates and relationship types found
  - id: fam
    type: File
    doc: Pedigrees in plink .fam format (<prefix>.fam)
    outputBinding:
      glob: '$(inputs.prefix_path ? inputs.prefix_path : "out").fam'
  - id: graph_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Pedigree graph files (<prefix>.allgraph and <prefix>.<family>.graph) 
      written with graph_out
    outputBinding:
      glob:
        - '$(inputs.prefix_path ? inputs.prefix_path : "out").allgraph'
        - '$(inputs.prefix_path ? inputs.prefix_path : "out").*.graph'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/akt:0.3.3--h5ca1c30_7
stdout: akt_relatives.out
