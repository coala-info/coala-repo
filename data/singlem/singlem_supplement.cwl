cwlVersion: v1.2
class: CommandLineTool
baseCommand: singlem supplement
label: singlem_supplement
doc: "Create a new metapackage from a vanilla one plus new genomes\n\nTool homepage:
  https://github.com/wwood/singlem"
inputs:
  - id: checkm2_max_contamination
    type:
      - 'null'
      - float
    doc: maximum contamination for CheckM2
    default: 10
    inputBinding:
      position: 101
      prefix: --checkm2-max-contamination
  - id: checkm2_min_completeness
    type:
      - 'null'
      - float
    doc: minimum completeness for CheckM2
    default: 50
    inputBinding:
      position: 101
      prefix: --checkm2-min-completeness
  - id: checkm2_quality_file
    type:
      - 'null'
      - File
    doc: CheckM2 quality file of new genomes
    inputBinding:
      position: 101
      prefix: --checkm2-quality-file
  - id: debug
    type:
      - 'null'
      - boolean
    doc: output debug information
    inputBinding:
      position: 101
      prefix: --debug
  - id: dereplicate_with_galah
    type:
      - 'null'
      - boolean
    doc: Run galah to dereplicate genomes at species level
    inputBinding:
      position: 101
      prefix: --dereplicate-with-galah
  - id: full_help
    type:
      - 'null'
      - boolean
    doc: print longer help message
    inputBinding:
      position: 101
      prefix: --full-help
  - id: full_help_roff
    type:
      - 'null'
      - boolean
    doc: print longer help message in ROFF (manpage) format
    inputBinding:
      position: 101
      prefix: --full-help-roff
  - id: gene_definitions
    type:
      - 'null'
      - File
    doc: Tab-separated file of 
      genome_fasta<TAB>transcript_fasta<TAB>protein_fasta
    inputBinding:
      position: 101
      prefix: --gene-definitions
  - id: gtdbtk_output_directory
    type:
      - 'null'
      - Directory
    doc: use this GTDBtk result. Not used if --new-taxonomies is used
    inputBinding:
      position: 101
      prefix: --gtdbtk-output-directory
  - id: hmmsearch_evalue
    type:
      - 'null'
      - float
    doc: evalue for hmmsearch run on proteins to gather markers
    default: '1e-20'
    inputBinding:
      position: 101
      prefix: --hmmsearch-evalue
  - id: ignore_taxonomy_database_incompatibility
    type:
      - 'null'
      - boolean
    doc: Do not halt when the old metapackage is not the default metapackage.
    inputBinding:
      position: 101
      prefix: --ignore-taxonomy-database-incompatibility
  - id: input_metapackage
    type:
      - 'null'
      - string
    doc: metapackage to build upon
    default: Use default package
    inputBinding:
      position: 101
      prefix: --input-metapackage
  - id: new_fully_defined_taxonomies
    type:
      - 'null'
      - File
    doc: newline separated file containing taxonomies of new genomes 
      (path<TAB>taxonomy). Must be fully specified to species level. If not 
      specified, the taxonomy will be inferred from the new genomes using 
      GTDB-tk or read from --taxonomy-file
    inputBinding:
      position: 101
      prefix: --new-fully-defined-taxonomies
  - id: new_genome_fasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: FASTA files of new genomes
    inputBinding:
      position: 101
      prefix: --new-genome-fasta-files
  - id: new_genome_fasta_files_list
    type:
      - 'null'
      - type: array
        items: File
    doc: File containing FASTA file paths of new genomes
    inputBinding:
      position: 101
      prefix: --new-genome-fasta-files-list
  - id: new_taxonomy_database_name
    type:
      - 'null'
      - string
    doc: Name of the taxonomy database to record in the created metapackage
    default: custom_taxonomy_database
    inputBinding:
      position: 101
      prefix: --new-taxonomy-database-name
  - id: new_taxonomy_database_version
    type:
      - 'null'
      - string
    doc: Version of the taxonomy database to use
    default: None
    inputBinding:
      position: 101
      prefix: --new-taxonomy-database-version
  - id: no_dereplication
    type:
      - 'null'
      - boolean
    doc: Assume genome inputs are already dereplicated
    inputBinding:
      position: 101
      prefix: --no-dereplication
  - id: no_quality_filter
    type:
      - 'null'
      - boolean
    doc: skip quality filtering
    inputBinding:
      position: 101
      prefix: --no-quality-filter
  - id: no_taxon_genome_lengths
    type:
      - 'null'
      - boolean
    doc: Do not include taxon genome lengths in updated metapackage
    inputBinding:
      position: 101
      prefix: --no-taxon-genome-lengths
  - id: output_metapackage
    type: string
    doc: output metapackage
    inputBinding:
      position: 101
      prefix: --output-metapackage
  - id: pplacer_threads
    type:
      - 'null'
      - int
    doc: for GTDBtk classify_wf
    inputBinding:
      position: 101
      prefix: --pplacer-threads
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: only output errors
    inputBinding:
      position: 101
      prefix: --quiet
  - id: skip_taxonomy_check
    type:
      - 'null'
      - boolean
    doc: skip check which ensures that GTDBtk assigned taxonomies are concordant
      with the old metapackage's
    inputBinding:
      position: 101
      prefix: --skip-taxonomy-check
  - id: taxonomy_file
    type:
      - 'null'
      - File
    doc: A 2 column tab-separated file containing each genome's taxonomy as 
      output by GTDBtk
    inputBinding:
      position: 101
      prefix: --taxonomy-file
  - id: threads
    type:
      - 'null'
      - int
    doc: parallelisation
    inputBinding:
      position: 101
      prefix: --threads
  - id: working_directory
    type:
      - 'null'
      - Directory
    doc: working directory
    inputBinding:
      position: 101
      prefix: --working-directory
outputs:
  - id: output_taxonomies
    type:
      - 'null'
      - File
    doc: TSV output file of taxonomies of new genomes, whether they are novel 
      species or not.
    outputBinding:
      glob: $(inputs.output_taxonomies)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
