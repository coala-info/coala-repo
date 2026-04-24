cwlVersion: v1.2
class: CommandLineTool
baseCommand: mikado_pick
label: mikado_pick
doc: "Launcher of the Mikado pipeline.\n\nTool homepage: https://github.com/lucventurini/mikado"
inputs:
  - id: gff
    type: string
    doc: GFF file
    inputBinding:
      position: 1
  - id: as_cds_only
    type:
      - 'null'
      - boolean
    doc: Flag. If set, Mikado will only consider the CDS to determine whether a 
      transcript is a valid alternative splicing event in a locus.
    inputBinding:
      position: 102
      prefix: --as-cds-only
  - id: cds_only
    type:
      - 'null'
      - boolean
    doc: '"Flag. If set, Mikado will only look for overlap in the coding features
      when clustering transcripts (unless one transcript is non-coding, in which case
      the whole transcript will be considered). Please note that Mikado will only
      consider the **best** ORF for this. Default: False, Mikado will consider transcripts
      in their entirety.'
    inputBinding:
      position: 102
      prefix: --cds-only
  - id: check_references
    type:
      - 'null'
      - boolean
    doc: Flag. If switched on, Mikado will also check reference models against 
      the general transcript requirements, and will also consider them as 
      potential fragments. This is useful in the context of e.g. updating an 
      *ab-initio* results with data from RNASeq, protein alignments, etc.
    inputBinding:
      position: 102
      prefix: --check-references
  - id: codon_table
    type:
      - 'null'
      - string
    doc: 'Codon table to use. Default: 0 (ie Standard, NCBI #1, but only ATG is considered
      a valid start codon.'
    inputBinding:
      position: 102
      prefix: --codon-table
  - id: configuration
    type: File
    doc: Configuration file for Mikado.
    inputBinding:
      position: 102
      prefix: --configuration
  - id: exclude_retained_introns
    type:
      - 'null'
      - boolean
    doc: 'Exclude all retained intron alternative splicing events from the final output.
      Default: False. Retained intron events that do not dirsupt the CDS are kept
      by Mikado in the final output.'
    inputBinding:
      position: 102
      prefix: --exclude-retained-introns
  - id: flank
    type:
      - 'null'
      - int
    doc: 'Flanking distance (in bps) to group non-overlapping transcripts into a single
      superlocus. Default: determined by the configuration file.'
    inputBinding:
      position: 102
      prefix: --flank
  - id: genome
    type: File
    doc: Genome FASTA file. Required for transcript padding.
    inputBinding:
      position: 102
      prefix: --genome
  - id: intron_range
    type:
      - 'null'
      - type: array
        items: int
    doc: 'Range into which intron lengths should fall, as a couple of integers. Transcripts
      with intron lengths outside of this range will be penalised. Default: (60, 900)'
      - 60
      - 900
    inputBinding:
      position: 102
      prefix: --intron-range
  - id: json_conf
    type: File
    doc: Configuration file for Mikado.
    inputBinding:
      position: 102
      prefix: --json-conf
  - id: keep_disrupted_cds
    type:
      - 'null'
      - boolean
    doc: 'Keep in the final output transcripts whose CDS is most probably disrupted
      by a retained intron event. Default: False. Mikado will try to detect these
      instances and exclude them from the final output.'
    inputBinding:
      position: 102
      prefix: --keep-disrupted-cds
  - id: loci_out
    type: File
    doc: This output file is mandatory. If it is not specified in the 
      configuration file, it must be provided here.
    inputBinding:
      position: 102
      prefix: --loci-out
  - id: log
    type:
      - 'null'
      - File
    doc: 'File to write the log to. Default: decided by the configuration file.'
    inputBinding:
      position: 102
      prefix: --log
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Logging level. Default: retrieved by the configuration file.'
    inputBinding:
      position: 102
      prefix: --log-level
  - id: max_intron_length
    type:
      - 'null'
      - int
    doc: 'Maximum intron length for a transcript. Default: inferred from the configuration
      file (default value there is 1,000,000 bps).'
    inputBinding:
      position: 102
      prefix: --max-intron-length
  - id: min_clustering_cdna_overlap
    type:
      - 'null'
      - string
    doc: 'Minimum cDNA overlap between two transcripts for them to be considered part
      of the same locus during the late picking stages. NOTE: if --min-cds-overlap
      is not specified, it will be set to this value! Default: 20%.'
    inputBinding:
      position: 102
      prefix: --min-clustering-cdna-overlap
  - id: min_clustering_cds_overlap
    type:
      - 'null'
      - string
    doc: 'Minimum CDS overlap between two transcripts for them to be considered part
      of the same locus during the late picking stages. NOTE: if not specified, and
      --min-cdna-overlap is specified on the command line, min-cds-overlap will be
      set to this value! Default: 20%.'
    inputBinding:
      position: 102
      prefix: --min-clustering-cds-overlap
  - id: mode
    type:
      - 'null'
      - string
    doc: 'Mode in which Mikado will treat transcripts with multiple ORFs. - nosplit:
      keep the transcripts whole. - stringent: split multi-orf transcripts if two
      consecutive ORFs have both BLAST hits and none of those hits is against the
      same target. - lenient: split multi-orf transcripts as in stringent, and additionally,
      also when either of the ORFs lacks a BLAST hit (but not both). - permissive:
      like lenient, but also split when both ORFs lack BLAST hits - split: split multi-orf
      transcripts regardless of what BLAST data is available.'
    inputBinding:
      position: 102
      prefix: --mode
  - id: monoloci_out
    type:
      - 'null'
      - File
    doc: Output file for monoloci
    inputBinding:
      position: 102
      prefix: --monoloci-out
  - id: no_cds
    type:
      - 'null'
      - boolean
    doc: Flag. If set, not CDS information will be printed out in the GFF output
      files.
    inputBinding:
      position: 102
      prefix: --no_cds
  - id: no_pad
    type:
      - 'null'
      - boolean
    doc: Disable transcript padding.
    inputBinding:
      position: 102
      prefix: --no-pad
  - id: no_purge
    type:
      - 'null'
      - boolean
    doc: Flag. If set, the pipeline will NOT suppress any loci whose transcripts
      do not pass the requirements set in the JSON file.
    inputBinding:
      position: 102
      prefix: --no-purge
  - id: no_shm
    type:
      - 'null'
      - boolean
    doc: Flag. If switched, Mikado will force using the database on location 
      instead of copying it to /dev/shm for faster access.
    inputBinding:
      position: 102
      prefix: --no-shm
  - id: only_reference_update
    type:
      - 'null'
      - boolean
    doc: 'Flag. If switched on, Mikado will only keep loci where at least one of the
      transcripts is marked as "reference". CAUTION: if no transcript has been marked
      as reference, the output will be completely empty!'
    inputBinding:
      position: 102
      prefix: --only-reference-update
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: 'Output directory. Default: current working directory'
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: pad
    type:
      - 'null'
      - boolean
    doc: Whether to pad transcripts in loci.
    inputBinding:
      position: 102
      prefix: --pad
  - id: pad_max_distance
    type:
      - 'null'
      - int
    doc: Maximum amount of bps that transcripts can be padded with (per side).
    inputBinding:
      position: 102
      prefix: --pad-max-distance
  - id: pad_max_splices
    type:
      - 'null'
      - int
    doc: Maximum splice sites that can be crossed during transcript padding.
    inputBinding:
      position: 102
      prefix: --pad-max-splices
  - id: prefix
    type:
      - 'null'
      - string
    doc: 'Prefix for the genes. Default: Mikado'
    inputBinding:
      position: 102
      prefix: --prefix
  - id: procs
    type:
      - 'null'
      - int
    doc: 'Number of processors to use. Default: look in the configuration file (1
      if undefined)'
    inputBinding:
      position: 102
      prefix: --procs
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Enable quiet logging.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: random_seed
    type:
      - 'null'
      - boolean
    doc: Generate a new random seed number (instead of the default of 0)
    inputBinding:
      position: 102
      prefix: --random-seed
  - id: reference_update
    type:
      - 'null'
      - boolean
    doc: Flag. If switched on, Mikado will prioritise transcripts marked as 
      reference and will consider any other transcipt within loci only in 
      reference to these reference transcripts. Novel loci will still be 
      reported.
    inputBinding:
      position: 102
      prefix: --reference-update
  - id: regions
    type:
      - 'null'
      - string
    doc: 'Either a single region on the CLI or a file listing a series of target regions.
      Mikado pick will only consider regions included in this string/file. Regions
      should be provided in a WebApollo-like format: <chrom>:<start>..<end>'
    inputBinding:
      position: 102
      prefix: --regions
  - id: report_all_external_metrics
    type:
      - 'null'
      - boolean
    doc: Boolean switch. If activated, Mikado will report all available external
      metrics, not just those requested for in the scoring configuration. This 
      might affect speed in Minos analyses.
    inputBinding:
      position: 102
      prefix: --report-all-external-metrics
  - id: report_all_orfs
    type:
      - 'null'
      - boolean
    doc: Boolean switch. If set to true, all ORFs will be reported, not just the
      primary.
    inputBinding:
      position: 102
      prefix: --report-all-orfs
  - id: scoring_file
    type:
      - 'null'
      - File
    doc: Optional scoring file for the run. It will override the value set in 
      the configuration.
    inputBinding:
      position: 102
      prefix: --scoring-file
  - id: seed
    type:
      - 'null'
      - int
    doc: 'Random seed number. Default: 0.'
    inputBinding:
      position: 102
      prefix: --seed
  - id: shm
    type:
      - 'null'
      - boolean
    doc: Flag. If switched, Mikado pick will copy the database to RAM (ie SHM) 
      for faster access during the run.
    inputBinding:
      position: 102
      prefix: --shm
  - id: single
    type:
      - 'null'
      - boolean
    doc: Flag. If set, Creator will be launched with a single process, without 
      involving the multithreading apparatus. Useful for debugging purposes 
      only.
    inputBinding:
      position: 102
      prefix: --single
  - id: source
    type:
      - 'null'
      - string
    doc: Source field to use for the output files.
    inputBinding:
      position: 102
      prefix: --source
  - id: sqlite_db
    type:
      - 'null'
      - File
    doc: Location of an SQLite database to overwrite what is specified in the 
      configuration file.
    inputBinding:
      position: 102
      prefix: --sqlite-db
  - id: start_method
    type:
      - 'null'
      - string
    doc: Multiprocessing start method.
    inputBinding:
      position: 102
      prefix: --start-method
  - id: subloci_out
    type:
      - 'null'
      - File
    doc: Output file for sub-loci
    inputBinding:
      position: 102
      prefix: --subloci-out
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose logging.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mikado:2.3.4--py310h8ea774a_2
stdout: mikado_pick.out
