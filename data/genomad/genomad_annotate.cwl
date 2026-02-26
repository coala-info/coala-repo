cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomad annotate
label: genomad_annotate
doc: "Predict the genes in the INPUT file (FASTA format), annotate them using geNomad's
  markers (located in the DATABASE directory), and write the results to the OUTPUT
  directory.\n\nTool homepage: https://portal.nersc.gov/genomad/"
inputs:
  - id: input
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: database
    type: Directory
    doc: Directory containing geNomad's markers
    inputBinding:
      position: 2
  - id: cleanup
    type:
      - 'null'
      - boolean
    doc: Delete intermediate files after execution.
    inputBinding:
      position: 103
      prefix: --cleanup
  - id: evalue
    type:
      - 'null'
      - float
    doc: Maximum accepted E-value in the MMseqs2 search.
    default: 0.001
    inputBinding:
      position: 103
      prefix: --evalue
  - id: full_ictv_lineage
    type:
      - 'null'
      - boolean
    doc: Output the full ICTV lineage of each virus genome, including ranks that
      are hidden by default (subrealm, subkingdom, subphylum, subclass, 
      suborder, subfamily, and, subgenus). The subfamily and subgenus ranks are 
      only shown if --lenient-taxonomy is also used.
    inputBinding:
      position: 103
      prefix: --full-ictv-lineage
  - id: lenient_taxonomy
    type:
      - 'null'
      - boolean
    doc: Allow classification of virus genomes to taxa below the family rank 
      (subfamily, genus, subgenus, and species). The subfamily and subgenus 
      ranks are only shown if --full-ictv-lineage is also used.
    inputBinding:
      position: 103
      prefix: --lenient-taxonomy
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Display the execution log.
    inputBinding:
      position: 103
      prefix: --quiet
  - id: restart
    type:
      - 'null'
      - boolean
    doc: Overwrite existing intermediate files.
    inputBinding:
      position: 103
      prefix: --restart
  - id: sensitivity
    type:
      - 'null'
      - float
    doc: MMseqs2 marker search sensitivity. Higher values will annotate more 
      proteins, but the search will be slower and consume more memory.
    default: 4.2
    inputBinding:
      position: 103
      prefix: --sensitivity
  - id: splits
    type:
      - 'null'
      - int
    doc: Split the data for the MMseqs2 search. Higher values will reduce memory
      usage, but will make the search slower. If the MMseqs2 search is failing, 
      try to increase the number of splits.
    default: 0
    inputBinding:
      position: 103
      prefix: --splits
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    default: 20
    inputBinding:
      position: 103
      prefix: --threads
  - id: use_minimal_db
    type:
      - 'null'
      - boolean
    doc: Use a smaller marker database to annotate proteins. This will make 
      execution faster but sensitivity will be reduced.
    inputBinding:
      position: 103
      prefix: --use-minimal-db
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Display the execution log.
    default: verbose
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: output
    type: Directory
    doc: Output directory
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomad:1.11.2--pyhdfd78af_0
