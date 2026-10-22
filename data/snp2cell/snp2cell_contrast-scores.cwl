cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - snp2cell
  - contrast-scores
label: snp2cell_contrast-scores
doc: "Add a new score that is a contrast of two scores, propagate it across the network and calculate statistics based on random permutations.\n\nTool homepage: https://github.com/Teichlab/snp2cell"
inputs:
  - id: s2c_obj
    type: File
    doc: "path to SNP2CELL object (staged writable; the command updates it in place)"
    inputBinding:
      position: 1
  - id: score_key1
    type: string
    doc: "key for scores stored in object (main)"
    inputBinding:
      position: 2
  - id: score_key2
    type: string
    doc: "key for scores stored in object (reference)"
    inputBinding:
      position: 3
  - id: save_key
    type:
      - 'null'
      - string
    doc: "name for saving scores in object; default: (score_key1 - score_key2)"
    inputBinding:
      position: 4
      prefix: --save-key
  - id: n_cpu
    type:
      - 'null'
      - int
    doc: "number of cpus to use"
    inputBinding:
      position: 4
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
stdout: snp2cell_contrast-scores.out
stderr: snp2cell_contrast-scores.err
