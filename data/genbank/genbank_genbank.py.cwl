cwlVersion: v1.2
class: CommandLineTool
baseCommand: genbank.py
label: genbank_genbank.py
doc: "Processes genbank files.\n\nTool homepage: https://github.com/deprekate/genbank"
inputs:
  - id: infile
    type: File
    doc: input file in genbank format
    inputBinding:
      position: 1
  - id: add
    type:
      - 'null'
      - string
    doc: This adds features the shell input via < features.txt
    inputBinding:
      position: 102
      prefix: --add
  - id: compare
    type:
      - 'null'
      - string
    doc: Compares the CDS of two genbank files
    inputBinding:
      position: 102
      prefix: --compare
  - id: divvy
    type:
      - 'null'
      - boolean
    doc: used to divvy a File with multiple loci into individual files
    inputBinding:
      position: 102
      prefix: --divvy
  - id: edit
    type:
      - 'null'
      - string
    doc: This edits the given feature key with the value from the shell input 
      via < new_keys.txt
    inputBinding:
      position: 102
      prefix: --edit
  - id: format
    type:
      - 'null'
      - string
    doc: Output the features in the specified format
    inputBinding:
      position: 102
      prefix: --format
  - id: get
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --get
  - id: key
    type:
      - 'null'
      - string
    doc: Print the given keys [and qualifiers]
    inputBinding:
      position: 102
      prefix: --key
  - id: revcomp
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --revcomp
  - id: slice
    type:
      - 'null'
      - string
    doc: 'This slices the infile at the specified coordinates. The range can be in
      one of three different formats: -s 0-99 (zero based string indexing) -s 1..100
      (one based GenBank indexing) -s 50:+10 (an index and size of slice)'
    inputBinding:
      position: 102
      prefix: --slice
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: where to write output
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genbank:0.121--py312h247cb63_2
