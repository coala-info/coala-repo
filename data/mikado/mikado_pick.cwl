cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mikado
  - pick
label: mikado_pick
doc: "Launcher of the Mikado pipeline: picks the best transcript models per locus.\n\nTool homepage: https://github.com/EI-CoreBioinformatics/mikado"
inputs:
  - id: genome
    type:
      - 'null'
      - File
    doc: Genome FASTA file. Required for transcript padding.
    secondaryFiles:
      - .fai
      - pattern: .gzi
        required: false
    inputBinding:
      position: 101
      prefix: --genome
  - id: start_method
    type:
      - 'null'
      - string
    doc: 'Multiprocessing start method: fork, spawn or forkserver.'
    inputBinding:
      position: 101
      prefix: --start-method
  - id: shm
    type:
      - 'null'
      - boolean
    doc: Copy the database to RAM (SHM) for faster access.
    inputBinding:
      position: 101
      prefix: --shm
  - id: no_shm
    type:
      - 'null'
      - boolean
    doc: Force using the database on location.
    inputBinding:
      position: 101
      prefix: --no-shm
  - id: procs
    type:
      - 'null'
      - int
    doc: Number of processors to use.
    inputBinding:
      position: 101
      prefix: -p
  - id: configuration
    type: File
    doc: Configuration file for Mikado.
    inputBinding:
      position: 101
      prefix: --configuration
  - id: scoring_file
    type:
      - 'null'
      - File
    doc: Optional scoring file for the run; overrides the value set in the configuration.
    inputBinding:
      position: 101
      prefix: --scoring-file
  - id: intron_range
    type:
      - 'null'
      - type: array
        items: int
    doc: 'Range into which intron lengths should fall (two integers). Default: 60 900.'
    inputBinding:
      position: 101
      prefix: --intron-range
  - id: no_pad
    type:
      - 'null'
      - boolean
    doc: Disable transcript padding.
    inputBinding:
      position: 101
      prefix: --no-pad
  - id: pad
    type:
      - 'null'
      - boolean
    doc: Pad transcripts in loci.
    inputBinding:
      position: 101
      prefix: --pad
  - id: codon_table
    type:
      - 'null'
      - int
    doc: 'Codon table to use. Default: 0.'
    inputBinding:
      position: 101
      prefix: --codon-table
  - id: pad_max_splices
    type:
      - 'null'
      - int
    doc: Maximum splice sites that can be crossed during transcript padding.
    inputBinding:
      position: 101
      prefix: --pad-max-splices
  - id: pad_max_distance
    type:
      - 'null'
      - int
    doc: Maximum amount of bps that transcripts can be padded with (per side).
    inputBinding:
      position: 101
      prefix: --pad-max-distance
  - id: regions
    type:
      - 'null'
      - string
    doc: A single region or a file listing target regions (<chrom>:<start>..<end>).
    inputBinding:
      position: 101
      prefix: -r
  - id: no_cds
    type:
      - 'null'
      - boolean
    doc: Do not print CDS information in the GFF output files.
    inputBinding:
      position: 101
      prefix: --no_cds
  - id: flank
    type:
      - 'null'
      - int
    doc: Flanking distance (in bps) to group non-overlapping transcripts into a single superlocus.
    inputBinding:
      position: 101
      prefix: --flank
  - id: max_intron_length
    type:
      - 'null'
      - int
    doc: Maximum intron length for a transcript.
    inputBinding:
      position: 101
      prefix: --max-intron-length
  - id: no_purge
    type:
      - 'null'
      - boolean
    doc: Do not suppress loci whose transcripts do not pass the requirements.
    inputBinding:
      position: 101
      prefix: --no-purge
  - id: cds_only
    type:
      - 'null'
      - boolean
    doc: Only look for overlap in the coding features when clustering transcripts.
    inputBinding:
      position: 101
      prefix: --cds-only
  - id: as_cds_only
    type:
      - 'null'
      - boolean
    doc: Only consider the CDS to decide whether a transcript is a valid alternative splicing event.
    inputBinding:
      position: 101
      prefix: --as-cds-only
  - id: reference_update
    type:
      - 'null'
      - boolean
    doc: Prioritise transcripts marked as reference.
    inputBinding:
      position: 101
      prefix: --reference-update
  - id: report_all_orfs
    type:
      - 'null'
      - boolean
    doc: Report all ORFs, not just the primary.
    inputBinding:
      position: 101
      prefix: --report-all-orfs
  - id: only_reference_update
    type:
      - 'null'
      - boolean
    doc: Only keep loci where at least one transcript is marked as reference.
    inputBinding:
      position: 101
      prefix: --only-reference-update
  - id: exclude_retained_introns
    type:
      - 'null'
      - boolean
    doc: Exclude all retained intron alternative splicing events from the final output.
    inputBinding:
      position: 101
      prefix: -eri
  - id: keep_disrupted_cds
    type:
      - 'null'
      - boolean
    doc: Keep transcripts whose CDS is most probably disrupted by a retained intron event.
    inputBinding:
      position: 101
      prefix: -kdc
  - id: min_clustering_cdna_overlap
    type:
      - 'null'
      - string
    doc: Minimum cDNA overlap between two transcripts to be part of the same locus.
    inputBinding:
      position: 101
      prefix: -mco
  - id: min_clustering_cds_overlap
    type:
      - 'null'
      - string
    doc: Minimum CDS overlap between two transcripts to be part of the same locus.
    inputBinding:
      position: 101
      prefix: -mcso
  - id: check_references
    type:
      - 'null'
      - boolean
    doc: Also check reference models against the general transcript requirements.
    inputBinding:
      position: 101
      prefix: --check-references
  - id: sqlite_db
    type:
      - 'null'
      - File
    doc: Location of an SQLite database to overwrite what is specified in the configuration file.
    inputBinding:
      position: 101
      prefix: -db
  - id: single
    type:
      - 'null'
      - boolean
    doc: Run with a single process.
    inputBinding:
      position: 101
      prefix: --single
  - id: mode
    type:
      - 'null'
      - string
    doc: 'Mode for transcripts with multiple ORFs: nosplit, stringent, lenient, permissive or split.'
    inputBinding:
      position: 101
      prefix: --mode
  - id: seed
    type:
      - 'null'
      - int
    doc: 'Random seed number. Default: 0.'
    inputBinding:
      position: 101
      prefix: --seed
  - id: random_seed
    type:
      - 'null'
      - boolean
    doc: Generate a new random seed number.
    inputBinding:
      position: 101
      prefix: --random-seed
  - id: output_dir
    type:
      - 'null'
      - string
    doc: 'Output directory. Default: current working directory.'
    inputBinding:
      position: 101
      prefix: -od
  - id: subloci_out
    type:
      - 'null'
      - string
    doc: Subloci output file name.
    inputBinding:
      position: 101
      prefix: --subloci-out
  - id: monoloci_out
    type:
      - 'null'
      - string
    doc: Monoloci output file name.
    inputBinding:
      position: 101
      prefix: --monoloci-out
  - id: loci_out
    type:
      - 'null'
      - string
    doc: Loci output file name (mandatory if not set in the configuration file).
    inputBinding:
      position: 101
      prefix: --loci-out
  - id: prefix
    type:
      - 'null'
      - string
    doc: 'Prefix for the genes. Default: Mikado.'
    inputBinding:
      position: 101
      prefix: --prefix
  - id: source
    type:
      - 'null'
      - string
    doc: Source field to use for the output files.
    inputBinding:
      position: 101
      prefix: --source
  - id: report_all_external_metrics
    type:
      - 'null'
      - boolean
    doc: Report all available external metrics.
    inputBinding:
      position: 101
      prefix: --report-all-external-metrics
  - id: log
    type:
      - 'null'
      - string
    doc: File to write the log to.
    inputBinding:
      position: 101
      prefix: -l
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose logging.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet logging.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Logging level: DEBUG, INFO, WARNING, ERROR or CRITICAL.'
    inputBinding:
      position: 101
      prefix: -lv
  - id: gff
    type:
      - 'null'
      - File
    doc: Prepared transcripts (GTF/GFF) to pick from.
    inputBinding:
      position: 201
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named inside the configuration or list file (annotations, genome, scoring file, ...); staged
      in the working directory so the relative names resolve.
outputs:
  - id: loci
    type:
      type: array
      items: File
    doc: Loci, subloci and monoloci tables and GFF files.
    outputBinding:
      glob:
        - '$((inputs.output_dir ? inputs.output_dir + ''/'' : '''') + (inputs.loci_out ? inputs.loci_out
          : ''mikado.loci.gff3''))'
        - '$((inputs.output_dir ? inputs.output_dir + ''/'' : '''') + (inputs.loci_out ? inputs.loci_out.replace(/\.gff3$/,
          '''') : ''mikado.loci'') + ''.metrics.tsv'')'
        - '$((inputs.output_dir ? inputs.output_dir + ''/'' : '''') + (inputs.loci_out ? inputs.loci_out.replace(/\.gff3$/,
          '''') : ''mikado.loci'') + ''.scores.tsv'')'
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file.
    outputBinding:
      glob: $(inputs.log)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '$(inputs.staged_files ? inputs.staged_files : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mikado:2.3.4--py310h8ea774a_2
