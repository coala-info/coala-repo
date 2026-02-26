cwlVersion: v1.2
class: CommandLineTool
baseCommand: refinem taxon_filter
label: refinem_taxon_filter
doc: "Identify scaffolds with divergent taxonomic classification.\n\nTool homepage:
  http://pypi.python.org/pypi/refinem/"
inputs:
  - id: taxon_profile_dir
    type: Directory
    doc: directory with results of taxon_profile command
    inputBinding:
      position: 1
  - id: common_taxa
    type:
      - 'null'
      - float
    doc: threshold for treating a taxon as common
    default: 5.0
    inputBinding:
      position: 102
      prefix: --common_taxa
  - id: congruent_scaffold
    type:
      - 'null'
      - float
    doc: threshold for treating a scaffold as congruent
    default: 10.0
    inputBinding:
      position: 102
      prefix: --congruent_scaffold
  - id: consensus_scaffold
    type:
      - 'null'
      - float
    doc: threshold of consensus taxon for filtering a scaffold
    default: 50.0
    inputBinding:
      position: 102
      prefix: --consensus_scaffold
  - id: consensus_taxon
    type:
      - 'null'
      - float
    doc: threshold for accepting a consensus taxon
    default: 50.0
    inputBinding:
      position: 102
      prefix: --consensus_taxon
  - id: cpus
    type:
      - 'null'
      - int
    doc: number of CPUs to use
    default: 1
    inputBinding:
      position: 102
      prefix: --cpus
  - id: min_classified
    type:
      - 'null'
      - int
    doc: minimum number of classified genes required to filter a scaffold
    default: 5
    inputBinding:
      position: 102
      prefix: --min_classified
  - id: min_classified_per
    type:
      - 'null'
      - float
    doc: minimum percentage of genes with a classification to filter a scaffold
    default: 25.0
    inputBinding:
      position: 102
      prefix: --min_classified_per
  - id: silent
    type:
      - 'null'
      - boolean
    doc: suppress output of logger
    inputBinding:
      position: 102
      prefix: --silent
  - id: trusted_scaffold
    type:
      - 'null'
      - float
    doc: threshold for treating a scaffold as trusted
    default: 50.0
    inputBinding:
      position: 102
      prefix: --trusted_scaffold
outputs:
  - id: output_file
    type: File
    doc: file indicating divergent scaffolds
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/refinem:0.1.2--pyh3252c3a_0
