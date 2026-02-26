cwlVersion: v1.2
class: CommandLineTool
baseCommand: gbintk evaluate
label: gbintk_evaluate
doc: "Evaluate the binning results given a ground truth\n\nTool homepage: https://github.com/metagentools/gbintk"
inputs:
  - id: binned
    type: File
    doc: path to the .csv file with the initial binning output from an existing 
      tool
    inputBinding:
      position: 101
      prefix: --binned
  - id: delimiter
    type:
      - 'null'
      - string
    doc: delimiter for input/output results. Supports a comma and a tab.
    default: comma
    inputBinding:
      position: 101
      prefix: --delimiter
  - id: groundtruth
    type: File
    doc: path to the .csv file with the ground truth
    inputBinding:
      position: 101
      prefix: --groundtruth
  - id: output
    type: Directory
    doc: path to the output folder
    inputBinding:
      position: 101
      prefix: --output
  - id: prefix
    type:
      - 'null'
      - string
    doc: prefix for the output file
    default: ''
    inputBinding:
      position: 101
      prefix: --prefix
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gbintk:1.0.3--py310h9ee0642_0
stdout: gbintk_evaluate.out
