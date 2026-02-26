cwlVersion: v1.2
class: CommandLineTool
baseCommand: pHierCC
label: phiercc_pHierCC
doc: "pHierCC takes a file containing allelic profiles (as in https://pubmlst.org/data/)
  and works out hierarchical clusters of the full dataset based on a minimum-spanning
  tree.\n\nTool homepage: https://github.com/zheminzhou/pHierCC"
inputs:
  - id: allowed_missing
    type:
      - 'null'
      - float
    doc: Allowed proportion of missing genes in pairwise comparisons
    default: 0.03
    inputBinding:
      position: 101
      prefix: --allowed_missing
  - id: append
    type:
      - 'null'
      - File
    doc: The NPZ output of a previous pHierCC run
    default: None
    inputBinding:
      position: 101
      prefix: --append
  - id: n_proc
    type:
      - 'null'
      - int
    doc: Number of processes (CPUs) to use
    default: 4
    inputBinding:
      position: 101
      prefix: --n_proc
  - id: profile
    type: File
    doc: name of a profile file consisting of a table of columns of the ST 
      numbers and the allelic numbers, separated by tabs. Can be GZIPped.
    inputBinding:
      position: 101
      prefix: --profile
outputs:
  - id: output
    type: File
    doc: Prefix for the output files consisting of a NUMPY and a TEXT version of
      the clustering result.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phiercc:1.24--pyhdfd78af_0
