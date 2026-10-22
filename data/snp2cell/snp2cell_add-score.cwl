cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - snp2cell
  - add-score
label: snp2cell_add-score
doc: "Add scores for network nodes to the s2c object and propagate the scores across the network.\n\nTool homepage: https://github.com/Teichlab/snp2cell"
inputs:
  - id: s2c_obj
    type: File
    doc: "path to SNP2CELL object (staged writable; the command updates it in place)"
    inputBinding:
      position: 1
  - id: score_file
    type: File
    doc: "Path to tsv file with scores for network nodes. Assuming there is no header and the first column contains the node names, the second column the scores."
    inputBinding:
      position: 2
  - id: save_key
    type:
      - 'null'
      - string
    doc: "name for saving scores in object (default snp_score)"
    inputBinding:
      position: 3
      prefix: --save-key
  - id: pos2gene
    type:
      - 'null'
      - File
    doc: "csv file with no header and location (chrX:XXX-XXX) to gene symbol mapping. If not provided, no mapping will be done. If a path is provided the mapping will be read from the file. If a URL is provided, the mapping will be queried from biomart."
    inputBinding:
      position: 3
      prefix: --pos2gene
  - id: n_cpu
    type:
      - 'null'
      - int
    doc: "number of cpus to use"
    inputBinding:
      position: 3
      prefix: --n-cpu
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Standard error (log messages)
  - id: s2c_obj_out
    type: File
    doc: The SNP2CELL object after the command
    outputBinding:
      glob: $(inputs.s2c_obj.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.s2c_obj)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snp2cell:0.3.0--pyhdfd78af_0
stdout: snp2cell_add-score.out
stderr: snp2cell_add-score.err
