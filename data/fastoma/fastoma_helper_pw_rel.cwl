cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastoma-helper
  - pw-rel
label: fastoma_helper_pw_rel
doc: "Extract pairwise orthologous or paralogous relations from a FastOMA OrthoXML file.\n\nTool homepage: https://github.com/DessimozLab/FastOMA"
inputs:
  - id: orthoxml
    type: File
    doc: Path to input orthoxml file
    inputBinding:
      position: 1
      prefix: --orthoxml
  - id: out
    type: string
    doc: Path to output file
    inputBinding:
      position: 2
      prefix: --out
  - id: type
    type:
      - 'null'
      - type: enum
        symbols:
          - ortholog
          - paralog
    doc: Type of relations to extract, either 'ortholog' or 'paralog'
    inputBinding:
      position: 3
      prefix: --type
outputs:
  - id: relations
    type:
      - 'null'
      - File
    doc: Pairwise relations file.
    outputBinding:
      glob: $(inputs.out)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastoma:0.5.1--pyhdfd78af_0
stdout: fastoma_helper_pw_rel.out
