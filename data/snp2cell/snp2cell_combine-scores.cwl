cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - snp2cell
  - combine-scores
label: snp2cell_combine-scores
doc: "Assuming that both a SNP score and DE scores have been added to the s2c object,
  combine SNP score with DE scores and compute statistics.\n\nTool homepage: https://github.com/Teichlab/snp2cell"
inputs:
  - id: s2c_obj
    type: File
    doc: path to SNP2CELL object
    inputBinding:
      position: 1
  - id: groupby
    type:
      - 'null'
      - string
    doc: '`ad.obs` column with annotation used for DE scores'
    inputBinding:
      position: 2
  - id: snp_score_key
    type:
      - 'null'
      - string
    doc: key for accessing saved snp scores in object
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snp2cell:0.3.0--pyhdfd78af_0
stdout: snp2cell_combine-scores.out
