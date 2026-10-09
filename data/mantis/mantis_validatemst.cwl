cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mantis
  - validatemst
label: mantis_validatemst
doc: 'Check that the MST color encoding of a mantis index agrees with the original
  color classes.


  Tool homepage: https://github.com/splatlab/mantis'
inputs:
  - id: index_prefix
    type: Directory
    doc: The directory where the index is stored (with the MST made by mantis mst)
    inputBinding:
      position: 2
      prefix: -p
      valueFrom: $(self.path)/
  - id: num_experiments
    type: int
    doc: Number of experiments (samples) in the index
    inputBinding:
      position: 3
      prefix: -n
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mantis:0.2--h4a1dfb3_4
stdout: mantis_validatemst.out
