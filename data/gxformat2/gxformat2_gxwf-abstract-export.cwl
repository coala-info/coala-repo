cwlVersion: v1.2
class: CommandLineTool
baseCommand: gxwf-abstract-export
label: gxformat2_gxwf-abstract-export
doc: "This script converts an executable Galaxy workflow (in either format - Format
  2 or native .ga) into an abstract CWL representation. In order to represent Galaxy
  tool executions in the Common Workflow Language workflow language, they are serialized
  as v1.2+ abstract 'Operation' classes. Because abstract 'Operation' classes are
  used, the resulting CWL workflow is not executable - either in Galaxy or by CWL
  implementations. The resulting CWL file should be thought of more as a common metadata
  specification describing the workflow structure.\n\nTool homepage: https://github.com/jmchilton/gxformat2"
inputs:
  - id: input
    type: File
    doc: input workflow path (.ga/gxwf.yml)
    inputBinding:
      position: 1
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output workflow path (.cwl)
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gxformat2:0.22.0--pyhdfd78af_0
