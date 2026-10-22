cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxonkit
  - cami-filter
label: taxonkit_cami-filter
doc: "Remove taxa of given TaxIds and their descendants in CAMI metagenomic profile\n\nTool homepage: https://github.com/shenwei356/taxonkit"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: 'CAMI profile file(s)'
    inputBinding:
      position: 1
  - id: field_percentage
    type:
      - 'null'
      - int
    doc: 'Field index of PERCENTAGE (default 5)'
    inputBinding:
      position: 101
      prefix: --field-percentage
  - id: field_rank
    type:
      - 'null'
      - int
    doc: 'Field index of RANK (default 2)'
    inputBinding:
      position: 101
      prefix: --field-rank
  - id: field_taxid
    type:
      - 'null'
      - int
    doc: 'Field index of TAXID (default 1)'
    inputBinding:
      position: 101
      prefix: --field-taxid
  - id: field_taxpath
    type:
      - 'null'
      - int
    doc: 'Field index of TAXPATH (default 3)'
    inputBinding:
      position: 101
      prefix: --field-taxpath
  - id: field_taxpathsn
    type:
      - 'null'
      - int
    doc: 'Field index of TAXPATHSN (default 4)'
    inputBinding:
      position: 101
      prefix: --field-taxpathsn
  - id: leaf_ranks
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Only consider leaves at these ranks (default species, strain, no rank)'
    inputBinding:
      position: 101
      prefix: --leaf-ranks
      itemSeparator: ','
  - id: show_rank
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Only show TaxIds and names of these ranks (default superkingdom, phylum, class, order, family, genus, species, strain)'
    inputBinding:
      position: 101
      prefix: --show-rank
      itemSeparator: ','
  - id: taxid_sep
    type:
      - 'null'
      - string
    doc: 'Separator of taxid in TAXPATH and TAXPATHSN (default ''|'')'
    inputBinding:
      position: 101
      prefix: --taxid-sep
  - id: taxids
    type:
      - 'null'
      - type: array
        items: string
    doc: 'The parent taxid(s) to filter out'
    inputBinding:
      position: 101
      prefix: --taxids
      itemSeparator: ','
  - id: taxids_file
    type:
      - 'null'
      - type: array
        items: File
    doc: 'File(s) for the parent taxid(s) to filter out, one taxid per line'
    inputBinding:
      position: 101
      prefix: --taxids-file
      itemSeparator: ','
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: 'Directory containing nodes.dmp and names.dmp (NCBI taxdump files)'
    inputBinding:
      position: 101
      prefix: --data-dir
  - id: line_buffered
    type:
      - 'null'
      - boolean
    doc: 'Use line buffering on output, i.e., immediately writing to stdin/file for every line of output'
    inputBinding:
      position: 101
      prefix: --line-buffered
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of CPUs. 4 is enough'
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Print verbose information'
    inputBinding:
      position: 101
      prefix: --verbose
  - id: out_file_path
    type: string
    doc: 'Output file name (suffix .gz for gzipped output)'
    inputBinding:
      position: 102
      prefix: --out-file
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.out_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxonkit:0.20.0--h9ee0642_1
