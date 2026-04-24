cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxonkit
  - cami-filter
label: taxonkit_cami-filter
doc: "Remove taxa of given TaxIds and their descendants in CAMI metagenomic profile\n\
  \nTool homepage: https://github.com/shenwei356/taxonkit"
inputs:
  - id: input_profile
    type: File
    doc: CAMI profile file
    inputBinding:
      position: 1
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: directory containing nodes.dmp and names.dmp
    inputBinding:
      position: 102
      prefix: --data-dir
  - id: field_percentage
    type:
      - 'null'
      - int
    doc: field index of PERCENTAGE
    inputBinding:
      position: 102
      prefix: --field-percentage
  - id: field_rank
    type:
      - 'null'
      - int
    doc: field index of taxid
    inputBinding:
      position: 102
      prefix: --field-rank
  - id: field_taxid
    type:
      - 'null'
      - int
    doc: field index of taxid
    inputBinding:
      position: 102
      prefix: --field-taxid
  - id: field_taxpath
    type:
      - 'null'
      - int
    doc: field index of TAXPATH
    inputBinding:
      position: 102
      prefix: --field-taxpath
  - id: field_taxpathsn
    type:
      - 'null'
      - int
    doc: field index of TAXPATHSN
    inputBinding:
      position: 102
      prefix: --field-taxpathsn
  - id: leaf_ranks
    type:
      - 'null'
      - type: array
        items: string
    doc: only consider leaves at these ranks
      - species
      - strain
      - no rank
    inputBinding:
      position: 102
      prefix: --leaf-ranks
  - id: line_buffered
    type:
      - 'null'
      - boolean
    doc: use line buffering on output, i.e., immediately writing to stdin/file 
      for every line of output
    inputBinding:
      position: 102
      prefix: --line-buffered
  - id: show_rank
    type:
      - 'null'
      - type: array
        items: string
    doc: only show TaxIds and names of these ranks
      - superkingdom
      - phylum
      - class
      - order
      - family
      - genus
      - species
      - strain
    inputBinding:
      position: 102
      prefix: --show-rank
  - id: taxid_sep
    type:
      - 'null'
      - string
    doc: separator of taxid in TAXPATH and TAXPATHSN
    inputBinding:
      position: 102
      prefix: --taxid-sep
  - id: taxids
    type:
      - 'null'
      - type: array
        items: string
    doc: the parent taxid(s) to filter out
    inputBinding:
      position: 102
      prefix: --taxids
  - id: taxids_file
    type:
      - 'null'
      - type: array
        items: File
    doc: file(s) for the parent taxid(s) to filter out, one taxid per line
    inputBinding:
      position: 102
      prefix: --taxids-file
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPUs. 4 is enough
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print verbose information
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: out file ("-" for stdout, suffix .gz for gzipped out)
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxonkit:0.20.0--h9ee0642_1
