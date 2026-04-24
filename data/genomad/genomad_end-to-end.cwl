cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomad end-to-end
label: genomad_end-to-end
doc: "Takes an INPUT file (FASTA format) and executes all modules of the geNomad pipeline
  for plasmid and virus identification. Output files are written in the OUTPUT directory.
  A local copy of geNomad's database (DATABASE directory), which can be downloaded
  with the download-database command, is required. The end-to-end command omits some
  options. If you want to have a more granular control over the execution parameters,
  please execute each module separately.\n\nTool homepage: https://portal.nersc.gov/genomad/"
inputs:
  - id: input
    type: File
    doc: INPUT file (FASTA format)
    inputBinding:
      position: 1
  - id: database
    type: Directory
    doc: Local copy of geNomad's database (DATABASE directory)
    inputBinding:
      position: 2
  - id: cleanup
    type:
      - 'null'
      - boolean
    doc: Delete intermediate files after execution.
    inputBinding:
      position: 103
  - id: composition
    type:
      - 'null'
      - string
    doc: Method for estimating sample composition. (auto|metagenome|virome)
    inputBinding:
      position: 103
  - id: conservative
    type:
      - 'null'
      - boolean
    doc: After classification, sequences are further filtered to remove possible
      false positives. The --conservative preset makes those filters even more 
      aggressive, resulting in more restricted sets of plasmid and virus, 
      containing only sequences whose classification is strongly supported.
    inputBinding:
      position: 103
  - id: disable_find_proviruses
    type:
      - 'null'
      - boolean
    doc: Skip the execution of the find-proviruses module.
    inputBinding:
      position: 103
  - id: disable_nn_classification
    type:
      - 'null'
      - boolean
    doc: Skip the execution of the nn-classification and 
      aggregated-classification modules.
    inputBinding:
      position: 103
  - id: enable_score_calibration
    type:
      - 'null'
      - boolean
    doc: Execute the score-calibration module.
    inputBinding:
      position: 103
  - id: force_auto
    type:
      - 'null'
      - boolean
    doc: Force automatic composition estimation regardless of the sample size.
    inputBinding:
      position: 103
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
  - id: lenient_taxonomy
    type:
      - 'null'
      - boolean
    doc: Allow classification of virus genomes to taxa below the family rank 
      (subfamily, genus, subgenus, and species). The subfamily and subgenus 
      ranks are only shown if --full-ictv-lineage is also used.
    inputBinding:
      position: 103
  - id: max_fdr
    type:
      - 'null'
      - float
    doc: Maximum accepted false discovery rate. This option will be ignored if 
      the scores were not calibrated.
    inputBinding:
      position: 103
  - id: max_uscg
    type:
      - 'null'
      - int
    doc: Maximum allowed number of universal single copy genes (USCGs) in a 
      virus or a plasmid. Sequences with more than this number of USCGs will not
      be classified as viruses or plasmids, regardless of their score. This 
      option will be ignored if the annotation module was not executed.
    inputBinding:
      position: 103
  - id: min_number_genes
    type:
      - 'null'
      - int
    doc: The minimum number of genes a sequence must encode to be considered for
      classification as a plasmid or virus.
    inputBinding:
      position: 103
  - id: min_plasmid_hallmarks
    type:
      - 'null'
      - int
    doc: Minimum number of plasmid hallmarks in the identified plasmids. This 
      option will be ignored if the annotation module was not executed.
    inputBinding:
      position: 103
  - id: min_plasmid_hallmarks_short_seqs
    type:
      - 'null'
      - int
    doc: Minimum number of plasmid hallmarks in plasmids shorter than 2,500 bp. 
      This option will be ignored if the annotation module was not executed.
    inputBinding:
      position: 103
  - id: min_plasmid_marker_enrichment
    type:
      - 'null'
      - float
    doc: Minimum allowed value for the plasmid marker enrichment score, which 
      represents the total enrichment of plasmid markers in the sequence. 
      Sequences with multiple plasmid markers will have higher values than the 
      ones that encode few or no markers. This option will be ignored if the 
      annotation module was not executed.
    inputBinding:
      position: 103
  - id: min_score
    type:
      - 'null'
      - float
    doc: Minimum score to flag a sequence as virus or plasmid.
    inputBinding:
      position: 103
  - id: min_virus_hallmarks
    type:
      - 'null'
      - int
    doc: Minimum number of virus hallmarks in the identified viruses. This 
      option will be ignored if the annotation module was not executed.
    inputBinding:
      position: 103
  - id: min_virus_hallmarks_short_seqs
    type:
      - 'null'
      - int
    doc: Minimum number of virus hallmarks in viruses shorter than 2,500 bp. 
      This option will be ignored if the annotation module was not executed.
    inputBinding:
      position: 103
  - id: min_virus_marker_enrichment
    type:
      - 'null'
      - float
    doc: Minimum allowed value for the virus marker enrichment score, which 
      represents the total enrichment of virus markers in the sequence. 
      Sequences with multiple virus markers will have higher values than the 
      ones that encode few or no markers. This option will be ignored if the 
      annotation module was not executed.
    inputBinding:
      position: 103
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Display the execution log.
    inputBinding:
      position: 103
      prefix: -q
  - id: relaxed
    type:
      - 'null'
      - boolean
    doc: After classification, sequences are further filtered to remove possible
      false positives. The --relaxed preset disables all post-classification 
      filters.
    inputBinding:
      position: 103
  - id: restart
    type:
      - 'null'
      - boolean
    doc: Overwrite existing intermediate files.
    inputBinding:
      position: 103
  - id: sensitivity
    type:
      - 'null'
      - float
    doc: MMseqs2 marker search sensitivity. Higher values will annotate more 
      proteins, but the search will be slower and consume more memory.
    inputBinding:
      position: 103
      prefix: -s
  - id: skip_integrase_identification
    type:
      - 'null'
      - boolean
    doc: Disable provirus boundary extension using nearby integrases.
    inputBinding:
      position: 103
  - id: skip_trna_identification
    type:
      - 'null'
      - boolean
    doc: Disable provirus boundary extension using nearby tRNAs.
    inputBinding:
      position: 103
  - id: splits
    type:
      - 'null'
      - int
    doc: Split the data for the MMseqs2 search. Higher values will reduce memory
      usage, but will make the search slower. If the MMseqs2 search is failing, 
      try to increase the number of splits.
    inputBinding:
      position: 103
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 103
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Display the execution log.
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: output
    type: Directory
    doc: OUTPUT directory
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomad:1.11.2--pyhdfd78af_0
