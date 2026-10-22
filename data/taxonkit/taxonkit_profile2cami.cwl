cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxonkit
  - profile2cami
label: taxonkit_profile2cami
doc: "Convert metagenomic profile table to CAMI format\n\nTool homepage: https://github.com/shenwei356/taxonkit"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: 'Profile table file(s), tab-separated (taxid and abundance columns)'
    inputBinding:
      position: 1
  - id: abundance_field
    type:
      - 'null'
      - int
    doc: 'Field index of abundance. Input data should be tab-separated (default 2)'
    inputBinding:
      position: 101
      prefix: --abundance-field
  - id: keep_zero
    type:
      - 'null'
      - boolean
    doc: 'Keep taxons with abundance of zero'
    inputBinding:
      position: 101
      prefix: --keep-zero
  - id: no_sum_up
    type:
      - 'null'
      - boolean
    doc: 'Do not sum up abundance from child to parent TaxIds'
    inputBinding:
      position: 101
      prefix: --no-sum-up
  - id: percentage
    type:
      - 'null'
      - boolean
    doc: 'Abundance is in percentage'
    inputBinding:
      position: 101
      prefix: --percentage
  - id: recompute_abd
    type:
      - 'null'
      - boolean
    doc: 'Recompute abundance if some TaxIds are deleted in current taxonomy version'
    inputBinding:
      position: 101
      prefix: --recompute-abd
  - id: sample_id
    type:
      - 'null'
      - string
    doc: 'Sample ID in result file'
    inputBinding:
      position: 101
      prefix: --sample-id
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
  - id: taxid_field
    type:
      - 'null'
      - int
    doc: 'Field index of taxid. Input data should be tab-separated (default 1)'
    inputBinding:
      position: 101
      prefix: --taxid-field
  - id: taxonomy_id
    type:
      - 'null'
      - string
    doc: 'Taxonomy ID in result file'
    inputBinding:
      position: 101
      prefix: --taxonomy-id
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
