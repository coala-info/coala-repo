cwlVersion: v1.2
class: CommandLineTool
baseCommand: java -jar GOSlimmer.jar
label: goslimmer
doc: "converts a set of annotations from GO to a given GOslim version\n\nTool homepage:
  https://github.com/DanFaria/GOSlimmer"
inputs:
  - id: annotation_file
    type: File
    doc: Path to the tabular annotation file (GAF, BLAST2GO or 2-column table 
      format
    inputBinding:
      position: 101
      prefix: --annotation
  - id: go_file
    type: File
    doc: Path to the full Gene Ontology OBO or OWL file
    inputBinding:
      position: 101
      prefix: --go
  - id: slim_file
    type: File
    doc: Path to the GOslim OBO or OWL file
    inputBinding:
      position: 101
      prefix: --slim
outputs:
  - id: output_file
    type: File
    doc: Path to the output GOslim annotation file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/goslimmer:1.0--0
