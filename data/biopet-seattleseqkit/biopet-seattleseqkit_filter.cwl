cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet-seattleseqkit
  - filter
label: biopet-seattleseqkit_filter
doc: "Filters a SeattleSeq annotation file. A bed file selects only variants inside
  its regions; filtering on specific fields is also possible. The input must have
  the columns 'chromosome', 'position' and 'geneList'.\n\nTool homepage: https://github.com/biopet/seattleseqkit"
inputs:
  - id: input_file
    type: File
    doc: Seattle seq input file (plain text or gzipped)
    inputBinding:
      position: 101
      prefix: --inputFile
  - id: output_file_name
    type: string
    doc: Seattle seq output file
    inputBinding:
      position: 101
      prefix: --outputFile
  - id: gene_colapse_output
    type:
      - 'null'
      - string
    doc: Output file to count per gene hits
    inputBinding:
      position: 101
      prefix: --geneColapseOutput
  - id: intervals
    type:
      - 'null'
      - File
    doc: Intervals bed file
    inputBinding:
      position: 101
      prefix: --intervals
  - id: field_must_contain
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --fieldMustContain
    doc: Field must contain given text, given as <field>=<text>
    inputBinding:
      position: 101
  - id: field_must_be_below
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --fieldMustBeBelow
    doc: Field must be below given numeric value, given as <field>=<double>
    inputBinding:
      position: 101
  - id: field_must_be_above
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --fieldMustBeAbove
    doc: Field must be above given numeric value, given as <field>=<double>
    inputBinding:
      position: 101
  - id: log_level
    type:
      - 'null'
      - string
    doc: "Level of log information printed. Possible levels: 'debug', 'info', 'warn',
      'error'"
    inputBinding:
      position: 101
      prefix: --log_level
outputs:
  - id: output_file
    type: File
    doc: Filtered Seattle seq file
    outputBinding:
      glob: $(inputs.output_file_name)
  - id: gene_counts
    type:
      - 'null'
      - File
    doc: Hit counts per gene
    outputBinding:
      glob: $(inputs.gene_colapse_output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet-seattleseqkit:0.2--0
