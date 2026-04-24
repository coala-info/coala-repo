cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - snp2cell
  - add-score
label: snp2cell_add-score
doc: "Add scores for network nodes to the s2c object and propagate the scores across
  the network.\n\nTool homepage: https://github.com/Teichlab/snp2cell"
inputs:
  - id: s2c_obj
    type: File
    doc: path to SNP2CELL object
    inputBinding:
      position: 1
  - id: score_file
    type: File
    doc: Path to tsv file with scores for network nodes. Assuming there is no 
      header and the first column contains the node names, the second column the
      scores.
    inputBinding:
      position: 2
  - id: n_cpu
    type:
      - 'null'
      - int
    doc: number of cpus to use
    inputBinding:
      position: 103
      prefix: --n-cpu
  - id: pos2gene
    type:
      - 'null'
      - File
    doc: csv file with no header and location (chrX:XXX-XXX) to gene symbol 
      mapping. If not provided, no mapping will be done. If a path is provided 
      the mapping will be read from the file. If a URL is provided, the mapping 
      will be queried from biomart.
    inputBinding:
      position: 103
      prefix: --pos2gene
  - id: save_key
    type:
      - 'null'
      - string
    doc: name for saving scores in object
    inputBinding:
      position: 103
      prefix: --save-key
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snp2cell:0.3.0--pyhdfd78af_0
stdout: snp2cell_add-score.out
