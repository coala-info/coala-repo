cwlVersion: v1.2
class: CommandLineTool
baseCommand: singlem renew
label: singlem_renew
doc: "Reannotate an OTU table with an updated taxonomy\n\nTool homepage: https://github.com/wwood/singlem"
inputs:
  - id: archive_otu_table
    type:
      - 'null'
      - File
    doc: 'output OTU table in archive format for making DBs etc. [default: unused]'
    inputBinding:
      position: 101
      prefix: --archive-otu-table
  - id: assignment_method
    type:
      - 'null'
      - string
    doc: 'Method of assigning taxonomy to OTUs and taxonomic profiles [default: smafa_naive_then_diamond].TS
      tab(@); l l . T{ Method T}@T{ Description T} _ T{ smafa_naive_then_diamond T}@T{
      Search for the most similar window sequences <= 3bp different using a brute
      force algorithm (using the smafa implementation) over all window sequences in
      the database, and if none are found use DIAMOND blastx of all reads from each
      OTU. T} T{ scann_naive_then_diamond T}@T{ Search for the most similar window
      sequences <= 3bp different using a brute force algorithm over all window sequences
      in the database, and if none are found use DIAMOND blastx of all reads from
      each OTU. T} T{ annoy_then_diamond T}@T{ Same as scann_naive_then_diamond, except
      search using ANNOY rather than using brute force. Requires a non-standard metapackage.
      T} T{ scann_then_diamond T}@T{ Same as scann_naive_then_diamond, except search
      using SCANN rather than using brute force. Requires a non-standard metapackage.
      T} T{ diamond T}@T{ DIAMOND blastx best hit(s) of all reads from each OTU. T}
      T{ diamond_example T}@T{ DIAMOND blastx best hit(s) of all reads from each OTU,
      but report the best hit as a sequence ID instead of a taxonomy. T} T{ annoy
      T}@T{ Search for the most similar window sequences <= 3bp different using ANNOY,
      otherwise no taxonomy is assigned. Requires a non-standard metapackage. T} T{
      pplacer T}@T{ Use pplacer to assign taxonomy of each read in each OTU. Requires
      a non-standard metapackage. T} .TE'
    inputBinding:
      position: 101
      prefix: --assignment-method
  - id: assignment_singlem_db
    type:
      - 'null'
      - string
    doc: 'Use this SingleM DB when assigning taxonomy [default: not set, use the default]'
    inputBinding:
      position: 101
      prefix: --assignment-singlem-db
  - id: debug
    type:
      - 'null'
      - boolean
    doc: output debug information
    inputBinding:
      position: 101
      prefix: --debug
  - id: diamond_taxonomy_assignment_performance_parameters
    type:
      - 'null'
      - string
    doc: "Performance-type arguments to use when calling 'diamond blastx' during the
      taxonomy assignment step. [default: use setting defined in metapackage when
      set, otherwise use '--block-size 0.5 --target-indexed -c1']"
      '--block-size 0.5 --target-indexed -c1'
    inputBinding:
      position: 101
      prefix: --diamond-taxonomy-assignment-performance-parameters
  - id: evalue
    type:
      - 'null'
      - float
    doc: 'HMMSEARCH e-value cutoff to use for sequence gathering [default: 1e-05]'
    inputBinding:
      position: 101
      prefix: --evalue
  - id: exclude_off_target_hits
    type:
      - 'null'
      - boolean
    doc: Exclude hits that are not in the target domain of each SingleM package
    inputBinding:
      position: 101
      prefix: --exclude-off-target-hits
  - id: filter_minimum_protein
    type:
      - 'null'
      - int
    doc: 'Ignore reads aligning in less than this many positions to each protein HMM
      when using --no-diamond-prefilter [default: 24]'
    inputBinding:
      position: 101
      prefix: --filter-minimum-protein
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
  - id: ignore_missing_singlem_packages
    type:
      - 'null'
      - boolean
    doc: 'Ignore OTUs which have been assigned to packages not in the metapackage
      being used for renewal [default: croak]'
    inputBinding:
      position: 101
      prefix: --ignore-missing-singlem-packages
  - id: input_archive_otu_table
    type: File
    doc: Renew this table
    inputBinding:
      position: 101
      prefix: --input-archive-otu-table
  - id: max_species_divergence
    type:
      - 'null'
      - int
    doc: 'Maximum number of different bases acids to allow between a sequence and
      the best hit in the database so that it is assigned to the species level. [default:
      2]'
    inputBinding:
      position: 101
      prefix: --max-species-divergence
  - id: metapackage
    type:
      - 'null'
      - string
    doc: 'Set of SingleM packages to use [default: use the default set]'
    inputBinding:
      position: 101
      prefix: --metapackage
  - id: min_orf_length
    type:
      - 'null'
      - int
    doc: 'When predicting ORFs require this many base pairs uninterrupted by a stop
      codon [default: 72 for reads, 300 for genomes]'
    inputBinding:
      position: 101
      prefix: --min-orf-length
  - id: min_taxon_coverage
    type:
      - 'null'
      - float
    doc: 'Minimum coverage to report in a taxonomic profile. [default: 0.35 for reads,
      0.1 for genomes]'
    inputBinding:
      position: 101
      prefix: --min-taxon-coverage
  - id: otu_table
    type:
      - 'null'
      - File
    doc: output OTU table
    inputBinding:
      position: 101
      prefix: --otu-table
  - id: output_extras
    type:
      - 'null'
      - boolean
    doc: 'give extra output for each sequence identified (e.g. the read(s) each OTU
      was generated from) in the output OTU table [default: not set]'
    inputBinding:
      position: 101
      prefix: --output-extras
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: only output errors
    inputBinding:
      position: 101
      prefix: --quiet
  - id: read_chunk_number
    type:
      - 'null'
      - int
    doc: Process only this specific chunk number (1-based index). Requires 
      --sra-files.
    inputBinding:
      position: 101
      prefix: --read-chunk-number
  - id: read_chunk_size
    type:
      - 'null'
      - int
    doc: Size chunk to process at a time (in number of reads). Requires 
      --sra-files.
    inputBinding:
      position: 101
      prefix: --read-chunk-size
  - id: restrict_read_length
    type:
      - 'null'
      - int
    doc: 'Only use this many base pairs at the start of each sequence searched [default:
      no restriction]'
    inputBinding:
      position: 101
      prefix: --restrict-read-length
  - id: singlem_packages
    type:
      - 'null'
      - type: array
        items: string
    doc: 'SingleM packages to use [default: use the set from the default metapackage]'
    inputBinding:
      position: 101
      prefix: --singlem-packages
  - id: sra_files
    type:
      - 'null'
      - type: array
        items: File
    doc: '"sra" format files (usually from NCBI SRA) to be searched'
    inputBinding:
      position: 101
      prefix: --sra-files
  - id: taxonomic_profile
    type:
      - 'null'
      - File
    doc: output a 'condensed' taxonomic profile for each sample based on the OTU
      table. Taxonomic profiles output can be further converted to other formats
      using singlem summarise.
    inputBinding:
      position: 101
      prefix: --taxonomic-profile
  - id: taxonomic_profile_krona
    type:
      - 'null'
      - File
    doc: output a 'condensed' taxonomic profile for each sample based on the OTU
      table
    inputBinding:
      position: 101
      prefix: --taxonomic-profile-krona
  - id: threads
    type:
      - 'null'
      - int
    doc: 'number of CPUS to use [default: 1]'
    inputBinding:
      position: 101
      prefix: --threads
  - id: translation_table
    type:
      - 'null'
      - int
    doc: 'Codon table for translation. By default, translation table 4 is used, which
      is the same as translation table 11 (the usual bacterial/archaeal one), except
      that the TGA codon is translated as tryptophan, not as a stop codon. Using table
      4 means that the minority of organisms which use table 4 are not biased against,
      without a significant effect on the majority of bacteria and archaea that use
      table 11. See http://www.ncbi.nlm.nih.gov/Taxonomy/taxonomyhome.html/index.cgi?chapter=tgencodes
      for details on specific tables. [default: 4]'
    inputBinding:
      position: 101
      prefix: --translation-table
outputs:
  - id: output_jplace
    type:
      - 'null'
      - File
    doc: "Output a jplace format file for each singlem package to a file starting
      with this string, each with one entry per OTU. Requires 'pplacer' as the --assignment_method
      [default: unused]"
    outputBinding:
      glob: $(inputs.output_jplace)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
