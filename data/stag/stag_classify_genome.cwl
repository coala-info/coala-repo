cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- stag
- classify_genome
label: stag_classify_genome
doc: 'Taxonomically annotate a genome (predict genes, extract the database marker genes and classify them).


  Tool homepage: https://github.com/zellerlab/stag'
inputs:
- id: genome_database
  type: File
  doc: database created with train_genome
  inputBinding:
    position: 1
    prefix: -d
- id: fasta_seq
  type:
  - 'null'
  - File
  doc: genome fasta file
  inputBinding:
    position: 1
    prefix: -i
- id: genome_dir
  type:
  - 'null'
  - Directory
  doc: directory containing genome fasta files (only fasta files will be used)
  inputBinding:
    position: 1
    prefix: -D
- id: markers_json
  type:
  - 'null'
  - File
  doc: json file pointing at a marker gene set (in lieu of a full genome)
  inputBinding:
    position: 1
    prefix: -G
- id: res_dir
  type: string
  doc: output directory
  inputBinding:
    position: 1
    prefix: -o
- id: long_output
  type:
  - 'null'
  - boolean
  doc: long output (with more information about the classification) [False]
  inputBinding:
    position: 1
    prefix: -l
- id: verbose_level
  type:
  - 'null'
  - int
  doc: 'verbose level: 1=error, 2=warning, 3=message, 4+=debugging [3]'
  inputBinding:
    position: 1
    prefix: -v
- id: use_all_genes
  type:
  - 'null'
  - boolean
  doc: use all genes above the filter [False]
  inputBinding:
    position: 1
    prefix: -r
- id: threads
  type:
  - 'null'
  - int
  doc: number of threads [1]
  inputBinding:
    position: 1
    prefix: -t
outputs:
- id: res_dir_result
  type: Directory
  doc: output directory
  outputBinding:
    glob: $(inputs.res_dir)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/stag:0.8.3--pyhdfd78af_1
