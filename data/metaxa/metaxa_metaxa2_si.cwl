cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaxa2_si
label: metaxa_metaxa2_si
doc: "Metaxa2 Diversity Tools species inference from Metaxa2 taxonomy output.\n\nTool homepage: http://microbiology.se/software/metaxa2/"
inputs:
  - id: input
    type: File
    doc: "Input taxonomy file from Metaxa2"
    inputBinding:
      position: 101
      prefix: -i
  - id: output_base
    type: string
    doc: "Output file"
    inputBinding:
      position: 101
      prefix: -o
  - id: level
    type: ['null', int]
    doc: "Taxonomic level for inference (1 = domain to 7 = species), default 7"
    inputBinding:
      position: 101
      prefix: -l
  - id: identity_cutoff
    type: ['null', float]
    doc: "Percent identity cutoff for allowing inference, default 97"
    inputBinding:
      position: 101
      prefix: -c
  - id: list_all
    type: ['null', boolean]
    doc: "List all possibilities for entries with multiple possible inferences (T or F), default F"
    inputBinding:
      position: 101
      prefix: --list_all
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: multiple
    type: ['null', string]
    doc: "Handling of entries with multiple possible inferences (keep, merge, remove, assign), default keep"
    inputBinding:
      position: 101
      prefix: --multiple
  - id: low_identity
    type: ['null', string]
    doc: "Handling of entries with identity below the cutoff (keep, merge, remove), default keep"
    inputBinding:
      position: 101
      prefix: --low_identity
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: "Files written with the output name"
    outputBinding:
      glob: "$(inputs.output_base)*"
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaxa:2.2.3--pl5321hdfd78af_2
stdout: metaxa_metaxa2_si.out
