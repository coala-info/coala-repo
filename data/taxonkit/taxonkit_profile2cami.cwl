cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxonkit profile2cami
label: taxonkit_profile2cami
doc: "Convert metagenomic profile table to CAMI format\n\nTool homepage: https://github.com/shenwei356/taxonkit"
inputs:
  - id: abundance_field
    type:
      - 'null'
      - int
    doc: field index of abundance. input data should be tab-separated
    inputBinding:
      position: 101
      prefix: --abundance-field
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: directory containing nodes.dmp and names.dmp
    inputBinding:
      position: 101
      prefix: --data-dir
  - id: keep_zero
    type:
      - 'null'
      - boolean
    doc: keep taxons with abundance of zero
    inputBinding:
      position: 101
      prefix: --keep-zero
  - id: line_buffered
    type:
      - 'null'
      - boolean
    doc: use line buffering on output, i.e., immediately writing to stdin/file 
      for every line of output
    inputBinding:
      position: 101
      prefix: --line-buffered
  - id: no_sum_up
    type:
      - 'null'
      - boolean
    doc: do not sum up abundance from child to parent TaxIds
    inputBinding:
      position: 101
      prefix: --no-sum-up
  - id: percentage
    type:
      - 'null'
      - boolean
    doc: abundance is in percentage
    inputBinding:
      position: 101
      prefix: --percentage
  - id: recompute_abd
    type:
      - 'null'
      - boolean
    doc: recompute abundance if some TaxIds are deleted in current taxonomy 
      version
    inputBinding:
      position: 101
      prefix: --recompute-abd
  - id: sample_id
    type:
      - 'null'
      - string
    doc: sample ID in result file
    inputBinding:
      position: 101
      prefix: --sample-id
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
      position: 101
      prefix: --show-rank
  - id: taxid_field
    type:
      - 'null'
      - int
    doc: field index of taxid. input data should be tab-separated
    inputBinding:
      position: 101
      prefix: --taxid-field
  - id: taxonomy_id
    type:
      - 'null'
      - string
    doc: taxonomy ID in result file
    inputBinding:
      position: 101
      prefix: --taxonomy-id
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPUs. 4 is enough
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print verbose information
    inputBinding:
      position: 101
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
