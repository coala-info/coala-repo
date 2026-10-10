cwlVersion: v1.2
class: CommandLineTool
baseCommand: [convert_external_genome]
label: nasp_convert_external_genome
doc: "Convert an external genome assembly into a NASP frankenfasta by aligning it to the reference with nucmer.\n\nTool homepage: https://github.com/TGenNorth/NASP"
inputs:
  - id: reference
    type: File
    doc: "Path to the reference fasta file."
    inputBinding:
      position: 1
      prefix: --reference
  - id: external
    type: File
    doc: "Path to the external genome fasta file."
    inputBinding:
      position: 1
      prefix: --external
  - id: name
    type: string
    doc: "Name of this external genome."
    inputBinding:
      position: 1
      prefix: --name
  - id: nucmerpath
    type:
      - 'null'
      - string
    doc: "Path to the 'nucmer' executable."
    inputBinding:
      position: 1
      prefix: --nucmerpath
  - id: nucmerargs
    type:
      - 'null'
      - string
    doc: "Optional arguments to pass to the 'nucmer' executable."
    inputBinding:
      position: 1
      prefix: --nucmerargs
  - id: deltafilterpath
    type:
      - 'null'
      - string
    doc: "Path to the 'delta-filter' executable."
    inputBinding:
      position: 1
      prefix: --deltafilterpath
  - id: deltafilterargs
    type:
      - 'null'
      - string
    doc: "Optional arguments to pass to the 'delta-filter' executable."
    inputBinding:
      position: 1
      prefix: --deltafilterargs
outputs:
  - id: frankenfasta
    type: File
    doc: "Frankenfasta of the external genome."
    outputBinding:
      glob: $(inputs.name).frankenfasta
  - id: filtered_delta
    type:
      - 'null'
      - File
    doc: "Filtered nucmer delta file."
    outputBinding:
      glob: $(inputs.name).filtered.delta
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nasp:1.2.1--py37h732b199_1
