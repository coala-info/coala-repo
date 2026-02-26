cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamdam_krona
label: bamdam_krona
doc: "Generate Krona plots from BAM data.\n\nTool homepage: https://github.com/bdesanctis/bamdam"
inputs:
  - id: aggregate_to
    type:
      - 'null'
      - string
    doc: The deepest internal taxonomic level to show in the krona plots. Will 
      aggregate if this level is deeper than the taxonomic level the input tsv 
      goes up to.
    default: superkingdom
    inputBinding:
      position: 101
      prefix: --aggregate_to
  - id: in_tsv
    type:
      - 'null'
      - type: array
        items: File
    doc: Path to tsv file(s)
    inputBinding:
      position: 101
      prefix: --in_tsv
  - id: in_tsv_list
    type:
      - 'null'
      - File
    doc: Path to a text file containing paths to input tsv files, one per line
    inputBinding:
      position: 101
      prefix: --in_tsv_list
  - id: maxdamage
    type:
      - 'null'
      - float
    doc: Force a maximum value for the 5' C-to-T damage color scale. If not 
      provided, the maximum value is determined from the data, with a minimum 
      threshold of 0.3. (not recommended by default)
    inputBinding:
      position: 101
      prefix: --maxdamage
  - id: minreads
    type:
      - 'null'
      - int
    doc: Minimum reads across samples to include taxa
    default: 100
    inputBinding:
      position: 101
      prefix: --minreads
outputs:
  - id: out_xml
    type:
      - 'null'
      - File
    doc: Path to output xml file name
    outputBinding:
      glob: $(inputs.out_xml)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamdam:0.4.3--pyhdfd78af_0
