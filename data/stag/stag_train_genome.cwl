cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- stag
- train_genome
label: stag_train_genome
doc: 'Merge single-gene classifiers into a genome STAG database.


  Tool homepage: https://github.com/zellerlab/stag'
inputs:
- id: list_gene_dbs
  type:
    type: array
    items: File
  doc: list of single gene databases to use (comma separated)
  inputBinding:
    position: 1
    prefix: -i
    itemSeparator: ','
- id: gene_thresholds
  type: File
  doc: hmm treshold for selecting the genes
  inputBinding:
    position: 1
    prefix: -T
- id: concat_genes_db
  type: File
  doc: stag database for the concatenated genes
  inputBinding:
    position: 1
    prefix: -C
- id: output_db
  type: string
  doc: output file name (HDF5 format)
  inputBinding:
    position: 1
    prefix: -o
- id: threads
  type:
  - 'null'
  - int
  doc: number of threads [1]
  inputBinding:
    position: 1
    prefix: -t
- id: verbose_level
  type:
  - 'null'
  - int
  doc: 'verbose level: 1=error, 2=warning, 3=message, 4+=debugging [3]'
  inputBinding:
    position: 1
    prefix: -v
outputs:
- id: output_db_result
  type: File
  doc: output file name (HDF5 format)
  outputBinding:
    glob: $(inputs.output_db)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/stag:0.8.3--pyhdfd78af_1
