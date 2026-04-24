cwlVersion: v1.2
class: CommandLineTool
baseCommand: singlem pipe
label: singlem_pipe
doc: "Generate a taxonomic profile or OTU table from raw sequences\n\nTool homepage:
  https://github.com/wwood/singlem"
inputs:
  - id: assignment_method
    type:
      - 'null'
      - string
    doc: Method of assigning taxonomy to OTUs and taxonomic profiles. Search for
      the most similar window sequences <= 3bp different using a brute force 
      algorithm (using the smafa implementation) over all window sequences in 
      the database, and if none are found use DIAMOND blastx of all reads from 
      each OTU.
    inputBinding:
      position: 101
      prefix: --assignment-method
  - id: assignment_singlem_db
    type:
      - 'null'
      - string
    doc: Use this SingleM DB when assigning taxonomy
    inputBinding:
      position: 101
      prefix: --assignment-singlem-db
  - id: assignment_threads
    type:
      - 'null'
      - int
    doc: Use this many processes in parallel while assigning taxonomy
    inputBinding:
      position: 101
      prefix: --assignment-threads
  - id: debug
    type:
      - 'null'
      - boolean
    doc: output debug information
    inputBinding:
      position: 101
      prefix: --debug
  - id: diamond_prefilter_db
    type:
      - 'null'
      - string
    doc: Use this DB when running DIAMOND prefilter
    inputBinding:
      position: 101
      prefix: --diamond-prefilter-db
  - id: diamond_prefilter_performance_parameters
    type:
      - 'null'
      - string
    doc: Performance-type arguments to use when calling 'diamond blastx' during 
      the prefiltering. By default, SingleM should run in <4GB of RAM except in 
      very large (>100Gbp) metagenomes.
    inputBinding:
      position: 101
      prefix: --diamond-prefilter-performance-parameters
  - id: diamond_taxonomy_assignment_performance_parameters
    type:
      - 'null'
      - string
    doc: Performance-type arguments to use when calling 'diamond blastx' during 
      the taxonomy assignment step.
    inputBinding:
      position: 101
      prefix: --diamond-taxonomy-assignment-performance-parameters
  - id: evalue
    type:
      - 'null'
      - float
    doc: HMMSEARCH e-value cutoff to use for sequence gathering
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
  - id: filter_minimum_nucleotide
    type:
      - 'null'
      - int
    doc: Ignore reads aligning in less than this many positions to each 
      nucleotide HMM
    inputBinding:
      position: 101
      prefix: --filter-minimum-nucleotide
  - id: filter_minimum_protein
    type:
      - 'null'
      - int
    doc: Ignore reads aligning in less than this many positions to each protein 
      HMM when using --no-diamond-prefilter
    inputBinding:
      position: 101
      prefix: --filter-minimum-protein
  - id: force
    type:
      - 'null'
      - boolean
    doc: overwrite working directory if required
    inputBinding:
      position: 101
      prefix: --force
  - id: forward_sequences
    type:
      - 'null'
      - type: array
        items: File
    doc: nucleotide read sequence(s) (forward or unpaired) to be searched. Can 
      be FASTA or FASTQ format, GZIP-compressed or not, short or long (but 
      Nanopore >=10.4.1 or PacBio HiFi reads recommended).
    inputBinding:
      position: 101
      prefix: --forward
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
  - id: genome_fasta_directory
    type:
      - 'null'
      - Directory
    doc: Directory containing genome FASTA files. Treated identically to 
      --forward input with higher default values for --min-taxon-coverage and 
      --min-orf-length.
    inputBinding:
      position: 101
      prefix: --genome-fasta-directory
  - id: genome_fasta_extension
    type:
      - 'null'
      - string
    doc: File extension of genomes in the directory specified with 
      -d/--genome-fasta-directory.
    inputBinding:
      position: 101
      prefix: --genome-fasta-extension
  - id: genome_fasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Path(s) to genome FASTA files. These are processed like input given 
      with --forward, but use higher default values for --min-taxon-coverage and
      --min-orf-length.
    inputBinding:
      position: 101
      prefix: --genome-fasta-files
  - id: genome_fasta_list
    type:
      - 'null'
      - File
    doc: File containing genome FASTA paths, one per line. Behaviour matches 
      --forward with higher default values for --min-taxon-coverage and 
      --min-orf-length.
    inputBinding:
      position: 101
      prefix: --genome-fasta-list
  - id: hmmsearch_package_assignment
    type:
      - 'null'
      - boolean
    doc: Assign each sequence to a SingleM package using HMMSEARCH, and a 
      sequence may then be assigned to multiple packages.
    inputBinding:
      position: 101
      prefix: --hmmsearch-package-assignment
  - id: include_inserts
    type:
      - 'null'
      - boolean
    doc: print the entirety of the sequences in the OTU table, not just the 
      aligned nucleotides
    inputBinding:
      position: 101
      prefix: --include-inserts
  - id: known_otu_tables
    type:
      - 'null'
      - type: array
        items: File
    doc: OTU tables previously generated with trusted taxonomies for each 
      sequence
    inputBinding:
      position: 101
      prefix: --known-otu-tables
  - id: known_sequence_taxonomy
    type:
      - 'null'
      - File
    doc: A 2-column "sequence<tab>taxonomy" file specifying some sequences that 
      have known taxonomy
    inputBinding:
      position: 101
      prefix: --known-sequence-taxonomy
  - id: max_species_divergence
    type:
      - 'null'
      - int
    doc: Maximum number of different bases acids to allow between a sequence and
      the best hit in the database so that it is assigned to the species level.
    inputBinding:
      position: 101
      prefix: --max-species-divergence
  - id: metapackage
    type:
      - 'null'
      - string
    doc: Set of SingleM packages to use
    inputBinding:
      position: 101
      prefix: --metapackage
  - id: min_orf_length
    type:
      - 'null'
      - int
    doc: When predicting ORFs require this many base pairs uninterrupted by a 
      stop codon
    inputBinding:
      position: 101
      prefix: --min-orf-length
  - id: min_taxon_coverage
    type:
      - 'null'
      - float
    doc: Minimum coverage to report in a taxonomic profile.
    inputBinding:
      position: 101
      prefix: --min-taxon-coverage
  - id: no_assign_taxonomy
    type:
      - 'null'
      - boolean
    doc: Do not assign any taxonomy except for those already known
    inputBinding:
      position: 101
      prefix: --no-assign-taxonomy
  - id: no_diamond_prefilter
    type:
      - 'null'
      - boolean
    doc: 'Do not parse sequence data through DIAMOND blastx using a database constructed
      from the set of singlem packages. Should be used with --hmmsearch-package-assignment.
      NOTE: ignored for nucleotide packages'
    inputBinding:
      position: 101
      prefix: --no-diamond-prefilter
  - id: output_extras
    type:
      - 'null'
      - boolean
    doc: give extra output for each sequence identified (e.g. the read(s) each 
      OTU was generated from) in the output OTU table
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
    doc: Only use this many base pairs at the start of each sequence searched
    inputBinding:
      position: 101
      prefix: --restrict-read-length
  - id: reverse_sequences
    type:
      - 'null'
      - type: array
        items: File
    doc: reverse reads to be searched. Can be FASTA or FASTQ format, 
      GZIP-compressed or not.
    inputBinding:
      position: 101
      prefix: --reverse
  - id: singlem_packages
    type:
      - 'null'
      - type: array
        items: string
    doc: SingleM packages to use
    inputBinding:
      position: 101
      prefix: --singlem-packages
  - id: sleep_after_mkfifo
    type:
      - 'null'
      - int
    doc: Sleep for this many seconds after running os.mkfifo
    inputBinding:
      position: 101
      prefix: --sleep-after-mkfifo
  - id: sra_files
    type:
      - 'null'
      - type: array
        items: File
    doc: '"sra" format files (usually from NCBI SRA) to be searched'
    inputBinding:
      position: 101
      prefix: --sra-files
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPUS to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: translation_table
    type:
      - 'null'
      - int
    doc: Codon table for translation. By default, translation table 4 is used, 
      which is the same as translation table 11 (the usual bacterial/archaeal 
      one), except that the TGA codon is translated as tryptophan, not as a stop
      codon. Using table 4 means that the minority of organisms which use table 
      4 are not biased against, without a significant effect on the majority of 
      bacteria and archaea that use table 11. See 
      http://www.ncbi.nlm.nih.gov/Taxonomy/taxonomyhome.html/index.cgi?chapter=tgencodes
      for details on specific tables.
    inputBinding:
      position: 101
      prefix: --translation-table
  - id: working_directory
    type:
      - 'null'
      - Directory
    doc: use intermediate working directory at a specified location, and do not 
      delete it upon completion
    inputBinding:
      position: 101
      prefix: --working-directory
  - id: working_directory_dev_shm
    type:
      - 'null'
      - boolean
    doc: use an intermediate results temporary working directory in /dev/shm 
      rather than the default
    inputBinding:
      position: 101
      prefix: --working-directory-dev-shm
outputs:
  - id: taxonomic_profile
    type:
      - 'null'
      - File
    doc: output a 'condensed' taxonomic profile for each sample based on the OTU
      table. Taxonomic profiles output can be further converted to other formats
      using singlem summarise.
    outputBinding:
      glob: $(inputs.taxonomic_profile)
  - id: taxonomic_profile_krona
    type:
      - 'null'
      - File
    doc: output a 'condensed' taxonomic profile for each sample based on the OTU
      table
    outputBinding:
      glob: $(inputs.taxonomic_profile_krona)
  - id: otu_table
    type:
      - 'null'
      - File
    doc: output OTU table
    outputBinding:
      glob: $(inputs.otu_table)
  - id: archive_otu_table
    type:
      - 'null'
      - File
    doc: output OTU table in archive format for making DBs etc.
    outputBinding:
      glob: $(inputs.archive_otu_table)
  - id: output_jplace
    type:
      - 'null'
      - File
    doc: Output a jplace format file for each singlem package to a file starting
      with this string, each with one entry per OTU. Requires 'pplacer' as the 
      --assignment_method
    outputBinding:
      glob: $(inputs.output_jplace)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
