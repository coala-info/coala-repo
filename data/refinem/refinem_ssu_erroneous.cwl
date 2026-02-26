cwlVersion: v1.2
class: CommandLineTool
baseCommand: refinem ssu_erroneous
label: refinem_ssu_erroneous
doc: "Identify scaffolds with erroneous 16S rRNA genes.\n\nTool homepage: http://pypi.python.org/pypi/refinem/"
inputs:
  - id: genome_nt_dir
    type: Directory
    doc: directory containing nucleotide scaffolds for each genome
    inputBinding:
      position: 1
  - id: taxon_profile_dir
    type: Directory
    doc: directory with results of taxon_profile command
    inputBinding:
      position: 2
  - id: ssu_db
    type: File
    doc: BLAST database of 16S rRNA genes
    inputBinding:
      position: 3
  - id: ssu_taxonomy_file
    type: File
    doc: taxonomy file for genes in the 16S rRNA database
    inputBinding:
      position: 4
  - id: output_dir
    type: Directory
    doc: output directory
    inputBinding:
      position: 5
  - id: common_taxon
    type:
      - 'null'
      - float
    doc: threshold for defining a taxon as common
    default: 10.0
    inputBinding:
      position: 106
      prefix: --common_taxon
  - id: concatenate
    type:
      - 'null'
      - int
    doc: concatenate hits within the specified number of base pairs
    default: 200
    inputBinding:
      position: 106
      prefix: --concatenate
  - id: cpus
    type:
      - 'null'
      - int
    doc: number of CPUs to use
    default: 1
    inputBinding:
      position: 106
      prefix: --cpus
  - id: evalue
    type:
      - 'null'
      - float
    doc: e-value threshold for identifying and classifying 16S rRNA genes
    default: '1e-05'
    inputBinding:
      position: 106
      prefix: --evalue
  - id: genome_ext
    type:
      - 'null'
      - string
    doc: extension of genomes (other files in directory are ignored)
    default: fna
    inputBinding:
      position: 106
      prefix: --genome_ext
  - id: silent
    type:
      - 'null'
      - boolean
    doc: suppress output of logger
    inputBinding:
      position: 106
      prefix: --silent
  - id: ssu_class
    type:
      - 'null'
      - float
    doc: percent identity threshold for accepting class classification of SSU
    default: 89.2
    inputBinding:
      position: 106
      prefix: --ssu_class
  - id: ssu_domain
    type:
      - 'null'
      - float
    doc: percent identity threshold for accepting domain classification of SSU
    default: 83.68
    inputBinding:
      position: 106
      prefix: --ssu_domain
  - id: ssu_family
    type:
      - 'null'
      - float
    doc: percent identity threshold for accepting family classification of SSU
    default: 96.4
    inputBinding:
      position: 106
      prefix: --ssu_family
  - id: ssu_genus
    type:
      - 'null'
      - float
    doc: percent identity threshold for accepting genus classification of SSU
    default: 98.7
    inputBinding:
      position: 106
      prefix: --ssu_genus
  - id: ssu_min_len
    type:
      - 'null'
      - int
    doc: minimum length of SSU 16S gene fragment to consider for classification
    default: 600
    inputBinding:
      position: 106
      prefix: --ssu_min_len
  - id: ssu_order
    type:
      - 'null'
      - float
    doc: percent identity threshold for accepting order classification of SSU
    default: 92.25
    inputBinding:
      position: 106
      prefix: --ssu_order
  - id: ssu_phylum
    type:
      - 'null'
      - float
    doc: percent identity threshold for accepting phylum classification of SSU
    default: 86.35
    inputBinding:
      position: 106
      prefix: --ssu_phylum
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/refinem:0.1.2--pyh3252c3a_0
stdout: refinem_ssu_erroneous.out
