cwlVersion: v1.2
class: CommandLineTool
baseCommand: ReferenceOpt.sh
label: ddocent_ReferenceOpt.sh
doc: "Scales similarity parameters for reference-based assembly.\n\nTool homepage:
  https://ddocent.com"
inputs:
  - id: minK1
    type: int
    doc: Minimum value for K1 parameter
    inputBinding:
      position: 1
  - id: maxK1
    type: int
    doc: Maximum value for K1 parameter
    inputBinding:
      position: 2
  - id: minK2
    type: int
    doc: Minimum value for K2 parameter
    inputBinding:
      position: 3
  - id: maxK2
    type: int
    doc: Maximum value for K2 parameter
    inputBinding:
      position: 4
  - id: assembly_type
    type: string
    doc: Type of assembly
    inputBinding:
      position: 5
  - id: num_processors
    type: int
    doc: Number of processors to use
    inputBinding:
      position: 6
  - id: min_similarity
    type:
      - 'null'
      - float
    doc: Minimum similarity value (optional)
    inputBinding:
      position: 7
  - id: max_similarity
    type:
      - 'null'
      - float
    doc: Maximum similarity value (optional)
    inputBinding:
      position: 8
  - id: increment
    type:
      - 'null'
      - float
    doc: Increment for similarity values (optional)
    inputBinding:
      position: 9
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ddocent:2.9.8--hdfd78af_0
stdout: ddocent_ReferenceOpt.sh.out
