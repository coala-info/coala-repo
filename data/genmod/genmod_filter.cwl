cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - genmod
  - filter
label: genmod_filter
doc: "Filter vcf variants.\n\nTool homepage: http://github.com/moonso/genmod"
inputs:
  - id: vcf_file
    type: File
    doc: Input VCF file or '-' for stdin
    inputBinding:
      position: 1
  - id: annotation
    type:
      - 'null'
      - string
    doc: Specify the info annotation to search for.
    inputBinding:
      position: 102
      prefix: --annotation
  - id: discard
    type:
      - 'null'
      - boolean
    doc: If variants without the annotation should be discarded
    inputBinding:
      position: 102
      prefix: --discard
  - id: greater
    type:
      - 'null'
      - boolean
    doc: If greater than threshold should be used instead of less thatn 
      threshold.
    inputBinding:
      position: 102
      prefix: --greater
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Do not print the variants.
    inputBinding:
      position: 102
      prefix: --silent
  - id: threshold
    type:
      - 'null'
      - float
    doc: Threshold for filter variants.
    inputBinding:
      position: 102
      prefix: --threshold
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Specify the path to a file where results should be stored.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genmod:3.10.2--pyh7e72e81_0
