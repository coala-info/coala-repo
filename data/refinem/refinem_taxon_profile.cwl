cwlVersion: v1.2
class: CommandLineTool
baseCommand: refinem taxon_profile
label: refinem_taxon_profile
doc: "Generate taxonomic profile of genes across scaffolds within a genome.\n\nTool
  homepage: http://pypi.python.org/pypi/refinem/"
inputs:
  - id: genome_prot_dir
    type: Directory
    doc: directory containing amino acid genes for each genome
    inputBinding:
      position: 1
  - id: scaffold_stats_file
    type: File
    doc: file with statistics for each scaffold
    inputBinding:
      position: 2
  - id: db_file
    type: File
    doc: DIAMOND database of reference genomes
    inputBinding:
      position: 3
  - id: taxonomy_file
    type: File
    doc: taxonomic assignment of each reference genomes
    inputBinding:
      position: 4
  - id: output_dir
    type: Directory
    doc: output directory
    inputBinding:
      position: 5
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
    doc: e-value of valid hits
    default: 0.001
    inputBinding:
      position: 106
      prefix: --evalue
  - id: per_aln_len
    type:
      - 'null'
      - float
    doc: minimum percent coverage of query sequence for reporting an alignment
    default: 50.0
    inputBinding:
      position: 106
      prefix: --per_aln_len
  - id: per_identity
    type:
      - 'null'
      - float
    doc: percent identity of valid hits
    default: 30.0
    inputBinding:
      position: 106
      prefix: --per_identity
  - id: per_to_classify
    type:
      - 'null'
      - float
    doc: minimum percentage of genes to assign a scaffold to a taxonomic group
    default: 20.0
    inputBinding:
      position: 106
      prefix: --per_to_classify
  - id: protein_ext
    type:
      - 'null'
      - string
    doc: extension of amino acid gene files (other files in directory are 
      ignored)
    default: faa
    inputBinding:
      position: 106
      prefix: --protein_ext
  - id: silent
    type:
      - 'null'
      - boolean
    doc: suppress output of logger
    inputBinding:
      position: 106
      prefix: --silent
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: specify alternative directory for temporary files
    default: /tmp
    inputBinding:
      position: 106
      prefix: --tmpdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/refinem:0.1.2--pyh3252c3a_0
stdout: refinem_taxon_profile.out
