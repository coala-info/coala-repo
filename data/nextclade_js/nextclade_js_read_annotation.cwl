cwlVersion: v1.2
class: CommandLineTool
baseCommand: [nextclade, read-annotation]
label: nextclade_js_read_annotation
doc: "Read genome annotation and convert it to Nextclade internal JSON/YAML format.

Tool homepage: https://github.com/nextstrain/nextclade"
inputs:
  - id: input_annotation
    type:
      - 'null'
      - File
    doc: "Genome annotation file in GFF3 format."
    inputBinding:
      position: 100
  - id: output
    type:
      - 'null'
      - string
    doc: "Path to output JSON or YAML file."
    inputBinding:
      position: 10
      prefix: --output
  - id: feature_tree
    type:
      - 'null'
      - boolean
    doc: "Present features in 'feature tree' format. This format is a precursor of genome annotation format - it contains all genetic features, even the ones that Nextclade does not use, but also less information about each feature"
    inputBinding:
      position: 11
      prefix: --feature-tree
  - id: json
    type:
      - 'null'
      - boolean
    doc: "Print console output in JSON format, rather than human-readable table"
    inputBinding:
      position: 12
      prefix: --json
outputs:
  - id: annotation_output
    type:
      - 'null'
      - File
    doc: Output JSON or YAML file.
    outputBinding:
      glob: |-
        ${ return inputs.output ? inputs.output : null; }
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextclade:3.18.1--h9ee0642_0
stdout: nextclade_js_read_annotation.out
