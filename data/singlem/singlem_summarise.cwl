cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - singlem
  - summarise
label: singlem_summarise
doc: 'Summarise and transform taxonomic profiles and OTU tables.


  Tool homepage: https://github.com/wwood/singlem'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_taxonomic_profiles
    type:
      - 'null'
      - type: array
        items: File
    doc: Input taxonomic profiles to be e.g. converted to krona HTML, or concatenated
    inputBinding:
      position: 101
      prefix: --input-taxonomic-profiles
  - id: output_taxonomic_profile_path
    type:
      - 'null'
      - string
    doc: Output a single output file containing taxonomic profiles of all input taxonomic
      profile files. Requires --input-taxonomic-profiles
    inputBinding:
      position: 102
      prefix: --output-taxonomic-profile
  - id: output_taxonomic_profile_krona_path
    type:
      - 'null'
      - string
    doc: Output taxonomic profile to this file in Krona format.
    inputBinding:
      position: 102
      prefix: --output-taxonomic-profile-krona
  - id: output_species_by_site_relative_abundance_path
    type:
      - 'null'
      - string
    doc: Output site by species relative abundance to this file
    inputBinding:
      position: 102
      prefix: --output-species-by-site-relative-abundance
  - id: output_species_by_site_level
    type:
      - 'null'
      - string
    doc: Output site by species level to this file (species, genus, family, order,
      class, phylum or domain). Requires --output-species-by-site-relative-abundance.
    inputBinding:
      position: 101
      prefix: --output-species-by-site-level
  - id: output_species_by_site_relative_abundance_prefix
    type:
      - 'null'
      - string
    doc: Output site by species relative abundance to this file prefix. One file will
      be written for each taxonomic level.
    inputBinding:
      position: 102
      prefix: --output-species-by-site-relative-abundance-prefix
  - id: output_filled_taxonomic_profile_path
    type:
      - 'null'
      - string
    doc: Output a taxonomic profile where the coverage of each taxon includes the
      coverage of each of its descendent taxons e.g. the d__Bacteria entry includes
      the p__Patescibacteria entry.
    inputBinding:
      position: 102
      prefix: --output-filled-taxonomic-profile
  - id: output_taxonomic_profile_with_extras_path
    type:
      - 'null'
      - string
    doc: Output a taxonomic profile with extra information (coverage, 'filled' coverage,
      relative abundance, taxonomy level).
    inputBinding:
      position: 102
      prefix: --output-taxonomic-profile-with-extras
  - id: num_decimal_places
    type:
      - 'null'
      - int
    doc: 'Number of decimal places to report in the coverage column of the --output-taxonomic-profile-with-extras
      [default: 2].'
    inputBinding:
      position: 101
      prefix: --num-decimal-places
  - id: output_taxonomic_level_coverage_path
    type:
      - 'null'
      - string
    doc: Output summary of how much coverage has been assigned to each taxonomic level
      in a taxonomic profile to a TSV file.
    inputBinding:
      position: 102
      prefix: --output-taxonomic-level-coverage
  - id: input_otu_tables
    type:
      - 'null'
      - type: array
        items: File
    doc: Summarise these tables
    inputBinding:
      position: 101
      prefix: --input-otu-tables
  - id: input_otu_tables_list
    type:
      - 'null'
      - File
    doc: Summarise the OTU table files newline separated in this file
    inputBinding:
      position: 101
      prefix: --input-otu-tables-list
  - id: input_archive_otu_tables
    type:
      - 'null'
      - type: array
        items: File
    doc: Summarise these tables
    inputBinding:
      position: 101
      prefix: --input-archive-otu-tables
  - id: input_archive_otu_table_list
    type:
      - 'null'
      - File
    doc: Summarise the archive tables newline separated in this file
    inputBinding:
      position: 101
      prefix: --input-archive-otu-table-list
  - id: input_gzip_archive_otu_table_list
    type:
      - 'null'
      - File
    doc: Summarise the list of newline-separated gzip-compressed archive OTU tables
      specified in this file
    inputBinding:
      position: 101
      prefix: --input-gzip-archive-otu-table-list
  - id: stream_inputs
    type:
      - 'null'
      - boolean
    doc: Stream input OTU tables, saving RAM. Only works with --output-otu-table and
      transformation options do not work [expert option].
    inputBinding:
      position: 101
      prefix: --stream-inputs
  - id: cluster
    type:
      - 'null'
      - boolean
    doc: Apply sequence clustering to the OTU table. Any dashes in OTU sequences will
      be replaced by N.
    inputBinding:
      position: 101
      prefix: --cluster
  - id: cluster_id
    type:
      - 'null'
      - float
    doc: 'Sequence clustering identity cutoff if --cluster is used [default: 0.9666666666666667
      i.e. 96.66666666666667%]'
    inputBinding:
      position: 101
      prefix: --cluster-id
  - id: taxonomy
    type:
      - 'null'
      - string
    doc: Restrict analysis to OTUs that have this taxonomy (exact taxonomy or more
      fully resolved)
    inputBinding:
      position: 101
      prefix: --taxonomy
  - id: rarefied_output_otu_table_path
    type:
      - 'null'
      - string
    doc: Output rarefied output OTU table, where each gene and sample combination
      is rarefied
    inputBinding:
      position: 102
      prefix: --rarefied-output-otu-table
  - id: number_to_choose
    type:
      - 'null'
      - int
    doc: 'Rarefy using this many sequences. Sample/gene combinations with an insufficient
      number of sequences are ignored with a warning [default: maximal number such
      that all samples have sufficient counts]'
    inputBinding:
      position: 101
      prefix: --number-to-choose
  - id: collapse_to_sample_name
    type:
      - 'null'
      - string
    doc: Merge all OTUs into a single OTU table, using the given sample name. Requires
      archive OTU table input and output.
    inputBinding:
      position: 101
      prefix: --collapse-to-sample-name
  - id: collapse_coupled
    type:
      - 'null'
      - boolean
    doc: Merge forward and reverse read OTU tables into a unified table. Sample names
      of coupled reads must end in '1' and '2' respectively. Read names are ignored,
      so that if the forward and reverse from a pair contain the same OTU sequence,
      they will each count separately.
    inputBinding:
      position: 101
      prefix: --collapse-coupled
  - id: collapse_paired_with_unpaired_archive_otu_table
    type:
      - 'null'
      - File
    doc: For archive OTU tables that have both paired and unpaired components, merge
      these into a single output archive OTU table
    inputBinding:
      position: 101
      prefix: --collapse-paired-with-unpaired-archive-otu-table
  - id: output_otu_table_path
    type:
      - 'null'
      - string
    doc: Output combined OTU table to this file
    inputBinding:
      position: 102
      prefix: --output-otu-table
  - id: output_archive_otu_table_path
    type:
      - 'null'
      - string
    doc: Output combined OTU table to this file
    inputBinding:
      position: 102
      prefix: --output-archive-otu-table
  - id: output_translated_otu_table_path
    type:
      - 'null'
      - string
    doc: Output combined OTU table to this file, with seqeunces translated into amino
      acids
    inputBinding:
      position: 102
      prefix: --output-translated-otu-table
  - id: output_extras
    type:
      - 'null'
      - boolean
    doc: Output extra information in the standard output OTU table
    inputBinding:
      position: 101
      prefix: --output-extras
  - id: krona_path
    type:
      - 'null'
      - string
    doc: Name of krona file to generate. Note that this generates a krona file from
      the OTU table, not the taxonomic profile
    inputBinding:
      position: 102
      prefix: --krona
  - id: wide_format_otu_table_path
    type:
      - 'null'
      - string
    doc: Name of output species by site CSV file
    inputBinding:
      position: 102
      prefix: --wide-format-otu-table
  - id: strain_overview_table_path
    type:
      - 'null'
      - string
    doc: Name of output strains table to generate
    inputBinding:
      position: 102
      prefix: --strain-overview-table
  - id: unifrac_by_otu_path
    type:
      - 'null'
      - string
    doc: Output UniFrac format file where entries are OTU sequences
    inputBinding:
      position: 102
      prefix: --unifrac-by-otu
  - id: unifrac_by_taxonomy_path
    type:
      - 'null'
      - string
    doc: Output UniFrac format file where entries are taxonomies (generally used for
      phylogeny-driven beta diversity when pipe was run with '--assignment_method
      diamond_example')
    inputBinding:
      position: 102
      prefix: --unifrac-by-taxonomy
  - id: clustered_output_otu_table_path
    type:
      - 'null'
      - string
    doc: Output an OTU table with extra information about the clusters. To simply
      cluster an OTU table, use --cluster with --output-otu-table instead.
    inputBinding:
      position: 102
      prefix: --clustered-output-otu-table
  - id: exclude_off_target_hits
    type:
      - 'null'
      - boolean
    doc: Exclude hits that are not in the target domain of each SingleM package
    inputBinding:
      position: 101
      prefix: --exclude-off-target-hits
  - id: singlem_packages
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Packages used in the creation of the OTU tables
    inputBinding:
      position: 101
      prefix: --singlem-packages
  - id: metapackage
    type:
      - 'null'
      - Directory
    doc: Metapackage used in the creation of the OTU tables
    inputBinding:
      position: 101
      prefix: --metapackage
  - id: unaligned_sequences_dump_file_path
    type:
      - 'null'
      - string
    doc: Output unaligned sequences from in put archive OTU table to this file. After
      each read name ~N is added which corresponds to the order of the read in the
      archive OTU table, so that no two sequences have the same read name.
    inputBinding:
      position: 102
      prefix: --unaligned-sequences-dump-file
  - id: debug
    type:
      - 'null'
      - boolean
    doc: output debug information
    inputBinding:
      position: 101
      prefix: --debug
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: only output errors
    inputBinding:
      position: 101
      prefix: --quiet
outputs:
  - id: output_taxonomic_profile
    type:
      - 'null'
      - File
    doc: Output a single output file containing taxonomic profiles of all input taxonomic
      profile files. Requires --input-taxonomic-profiles
    outputBinding:
      glob: $(inputs.output_taxonomic_profile_path)
  - id: output_taxonomic_profile_krona
    type:
      - 'null'
      - File
    doc: Output taxonomic profile to this file in Krona format.
    outputBinding:
      glob: $(inputs.output_taxonomic_profile_krona_path)
  - id: output_species_by_site_relative_abundance
    type:
      - 'null'
      - File
    doc: Output site by species relative abundance to this file
    outputBinding:
      glob: $(inputs.output_species_by_site_relative_abundance_path)
  - id: output_species_by_site_relative_abundance_prefix_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in output_species_by_site_relative_abundance_prefix
      (one per taxonomic level)
    outputBinding:
      glob: $(inputs.output_species_by_site_relative_abundance_prefix)*
  - id: output_filled_taxonomic_profile
    type:
      - 'null'
      - File
    doc: Output a taxonomic profile where the coverage of each taxon includes the
      coverage of each of its descendent taxons e.g. the d__Bacteria entry includes
      the p__Patescibacteria entry.
    outputBinding:
      glob: $(inputs.output_filled_taxonomic_profile_path)
  - id: output_taxonomic_profile_with_extras
    type:
      - 'null'
      - File
    doc: Output a taxonomic profile with extra information (coverage, 'filled' coverage,
      relative abundance, taxonomy level).
    outputBinding:
      glob: $(inputs.output_taxonomic_profile_with_extras_path)
  - id: output_taxonomic_level_coverage
    type:
      - 'null'
      - File
    doc: Output summary of how much coverage has been assigned to each taxonomic level
      in a taxonomic profile to a TSV file.
    outputBinding:
      glob: $(inputs.output_taxonomic_level_coverage_path)
  - id: rarefied_output_otu_table
    type:
      - 'null'
      - File
    doc: Output rarefied output OTU table, where each gene and sample combination
      is rarefied
    outputBinding:
      glob: $(inputs.rarefied_output_otu_table_path)
  - id: output_otu_table
    type:
      - 'null'
      - File
    doc: Output combined OTU table to this file
    outputBinding:
      glob: $(inputs.output_otu_table_path)
  - id: output_archive_otu_table
    type:
      - 'null'
      - File
    doc: Output combined OTU table to this file
    outputBinding:
      glob: $(inputs.output_archive_otu_table_path)
  - id: output_translated_otu_table
    type:
      - 'null'
      - File
    doc: Output combined OTU table to this file, with seqeunces translated into amino
      acids
    outputBinding:
      glob: $(inputs.output_translated_otu_table_path)
  - id: krona
    type:
      - 'null'
      - File
    doc: Name of krona file to generate. Note that this generates a krona file from
      the OTU table, not the taxonomic profile
    outputBinding:
      glob: $(inputs.krona_path)
  - id: wide_format_otu_table
    type:
      - 'null'
      - File
    doc: Name of output species by site CSV file
    outputBinding:
      glob: $(inputs.wide_format_otu_table_path)
  - id: strain_overview_table
    type:
      - 'null'
      - File
    doc: Name of output strains table to generate
    outputBinding:
      glob: $(inputs.strain_overview_table_path)
  - id: unifrac_by_otu
    type:
      - 'null'
      - File
    doc: Output UniFrac format file where entries are OTU sequences
    outputBinding:
      glob: $(inputs.unifrac_by_otu_path)
  - id: unifrac_by_taxonomy
    type:
      - 'null'
      - File
    doc: Output UniFrac format file where entries are taxonomies (generally used for
      phylogeny-driven beta diversity when pipe was run with '--assignment_method
      diamond_example')
    outputBinding:
      glob: $(inputs.unifrac_by_taxonomy_path)
  - id: clustered_output_otu_table
    type:
      - 'null'
      - File
    doc: Output an OTU table with extra information about the clusters. To simply
      cluster an OTU table, use --cluster with --output-otu-table instead.
    outputBinding:
      glob: $(inputs.clustered_output_otu_table_path)
  - id: unaligned_sequences_dump_file
    type:
      - 'null'
      - File
    doc: Output unaligned sequences from in put archive OTU table to this file. After
      each read name ~N is added which corresponds to the order of the read in the
      archive OTU table, so that no two sequences have the same read name.
    outputBinding:
      glob: $(inputs.unaligned_sequences_dump_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
