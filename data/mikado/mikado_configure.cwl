cwlVersion: v1.2
class: CommandLineTool
baseCommand: mikado configure
label: mikado_configure
doc: "Configuration utility for Mikado\n\nTool homepage: https://github.com/lucventurini/mikado"
inputs:
  - id: out
    type:
      - 'null'
      - string
    doc: Output file name
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
  - id: blast_chunks
    type:
      - 'null'
      - int
    doc: Number of parallel DIAMOND/BLAST jobs to run.
    inputBinding:
      position: 102
      prefix: --blast-chunks
  - id: blast_targets
    type:
      - 'null'
      - type: array
        items: File
    doc: BLAST targets
    inputBinding:
      position: 102
      prefix: --blast_targets
  - id: cds_only
    type:
      - 'null'
      - boolean
    doc: '"Flag. If set, Mikado will only look for overlap in the coding features
      when clustering transcripts (unless one transcript is non-coding, in which case
      the whole transcript will be considered). Please note that Mikado will only
      consider the **best** ORF for this. Default: False, Mikado will consider transcripts
      in their entirety."'
    inputBinding:
      position: 102
      prefix: --cds-only
  - id: check_references
    type:
      - 'null'
      - boolean
    doc: If switched on, Mikado will also check reference models against the 
      general transcript requirements, and will also consider them as potential 
      fragments. This is useful in the context of e.g. updating an *ab-initio* 
      results with data from RNASeq, protein alignments, etc.
    inputBinding:
      position: 102
      prefix: --check-references
  - id: cluster_config
    type:
      - 'null'
      - File
    doc: Cluster configuration file to write to.
    inputBinding:
      position: 102
      prefix: --cluster_config
  - id: codon_table
    type:
      - 'null'
      - int
    doc: 'Codon table to use. Default: 0 (ie Standard, NCBI #1, but only ATG is considered
      a valid start codon.'
    inputBinding:
      position: 102
      prefix: --codon-table
  - id: copy_scoring
    type:
      - 'null'
      - string
    doc: File into which to copy the selected scoring file, for modification.
    inputBinding:
      position: 102
      prefix: --copy-scoring
  - id: daijin
    type:
      - 'null'
      - boolean
    doc: If set, the configuration file will be also valid for Daijin.
    inputBinding:
      position: 102
      prefix: --daijin
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
  - id: exe
    type:
      - 'null'
      - File
    doc: Configuration file for the executables.
    inputBinding:
      position: 102
      prefix: --exe
  - id: external
    type:
      - 'null'
      - File
    doc: External configuration file to overwrite/add values from. Parameters 
      specified on the command line will take precedence over those present in 
      the configuration file.
    inputBinding:
      position: 102
      prefix: --external
  - id: full
    type:
      - 'null'
      - boolean
    doc: Show full configuration
    inputBinding:
      position: 102
      prefix: --full
  - id: genome
    type:
      - 'null'
      - File
    doc: Fasta genomic reference.
    inputBinding:
      position: 102
      prefix: --genome
  - id: gff
    type:
      - 'null'
      - type: array
        items: File
    doc: Input GFF/GTF file(s), separated by comma
    inputBinding:
      position: 102
      prefix: --gff
  - id: intron_range
    type:
      - 'null'
      - type: array
        items: int
    doc: 'Range into which intron lengths should fall, as a couple of integers. Transcripts
      with intron lengths outside of this range will be penalised. Default: (60, 900)'
    inputBinding:
      position: 102
      prefix: --intron-range
  - id: json
    type:
      - 'null'
      - boolean
    doc: 'Output will be in JSON (default: inferred by filename, with TOML as fallback).'
    inputBinding:
      position: 102
      prefix: --json
  - id: junctions
    type:
      - 'null'
      - File
    doc: Junctions file
    inputBinding:
      position: 102
      prefix: --junctions
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
  - id: labels
    type:
      - 'null'
      - string
    doc: Labels to attach to the IDs of the transcripts of the input files, 
      separated by comma.
    inputBinding:
      position: 102
      prefix: --labels
  - id: list
    type:
      - 'null'
      - File
    doc: 'Tab-delimited file containing rows with the following format: <file> <label>
      <strandedness(def. False)> <score(optional, def. 0)> <is_reference(optional,
      def. False)> <exclude_redundant(optional, def. True)> <strip_cds(optional, def.
      False)> <skip_split(optional, def. False)> "strandedness", "is_reference", "exclude_redundant",
      "strip_cds" and "skip_split" must be boolean values (True, False) "score" must
      be a valid floating number.'
    inputBinding:
      position: 102
      prefix: --list
  - id: max_intron_length
    type:
      - 'null'
      - int
    doc: Maximum intron length for transcripts
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
  - id: minimum_cdna_length
    type:
      - 'null'
      - int
    doc: Minimum cDNA length for transcripts
    inputBinding:
      position: 102
      prefix: --minimum-cdna-length
  - id: mode
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Mode(s) in which Mikado will treat transcripts with multiple ORFs. - nosplit:
      keep the transcripts whole. - stringent: split multi-orf transcripts if two
      consecutive ORFs have both BLAST hits and none of those hits is against the
      same target. - lenient: split multi-orf transcripts as in stringent, and additionally,
      also when either of the ORFs lacks a BLAST hit (but not both). - permissive:
      like lenient, but also split when both ORFs lack BLAST hits - split: split multi-orf
      transcripts regardless of what BLAST data is available. If multiple modes are
      specified, Mikado will create a Daijin-compatible configuration file.'
    inputBinding:
      position: 102
      prefix: --mode
  - id: monoloci_out
    type:
      - 'null'
      - string
    doc: Name of the optional monoloci output. By default, this will not be 
      produced.
    inputBinding:
      position: 102
      prefix: --monoloci-out
  - id: no_files
    type:
      - 'null'
      - boolean
    doc: Remove all files-specific options from the printed configuration file. 
      Invoking the "--gff" option will disable this flag.
    inputBinding:
      position: 102
      prefix: --no-files
  - id: no_pad
    type:
      - 'null'
      - boolean
    doc: Disable transcript padding. On by default.
    inputBinding:
      position: 102
      prefix: --no-pad
  - id: only_reference_update
    type:
      - 'null'
      - boolean
    doc: 'If switched on, Mikado will only keep loci where at least one of the transcripts
      is marked as "reference". CAUTION: if no transcript has been marked as reference,
      the output will be completely empty!'
    inputBinding:
      position: 102
      prefix: --only-reference-update
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Destination directory for the output.
    inputBinding:
      position: 102
      prefix: --out-dir
  - id: random_seed
    type:
      - 'null'
      - boolean
    doc: Generate a new random seed number (instead of the default of 0)
    inputBinding:
      position: 102
      prefix: --random-seed
  - id: reference
    type:
      - 'null'
      - File
    doc: Fasta genomic reference.
    inputBinding:
      position: 102
      prefix: --reference
  - id: reference_update
    type:
      - 'null'
      - boolean
    doc: If switched on, Mikado will prioritise transcripts marked as reference 
      and will consider any other transcipt within loci only in reference to 
      these reference transcripts. Novel loci will still be reported.
    inputBinding:
      position: 102
      prefix: --reference-update
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
  - id: scheduler
    type:
      - 'null'
      - string
    doc: 'Scheduler to use. Default: None - ie, either execute everything on the local
      machine or use DRMAA to submit and control jobs (recommended).'
    inputBinding:
      position: 102
      prefix: --scheduler
  - id: scoring
    type:
      - 'null'
      - string
    doc: 'Scoring file to use. Mikado provides the following: mammalian.yaml, plant.yaml,
      HISTORIC/scerevisiae.yaml, HISTORIC/human.yaml, HISTORIC/mammalian.yaml, HISTORIC/hsapiens_scoring.yaml,
      HISTORIC/celegans_scoring.yaml, HISTORIC/worm.yaml, HISTORIC/plant.yaml, HISTORIC/athaliana_scoring.yaml,
      HISTORIC/dmelanogaster_scoring.yaml, HISTORIC/insects.yaml, HISTORIC/plants.yaml'
    inputBinding:
      position: 102
      prefix: --scoring
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed number
    inputBinding:
      position: 102
      prefix: --seed
  - id: skip_split
    type:
      - 'null'
      - type: array
        items: string
    doc: List of labels for which splitting will be disabled (eg long reads such
      as PacBio)
    inputBinding:
      position: 102
      prefix: --skip-split
  - id: strand_specific
    type:
      - 'null'
      - boolean
    doc: Boolean flag indicating whether all the assemblies are strand-specific.
    inputBinding:
      position: 102
      prefix: --strand-specific
  - id: strand_specific_assemblies
    type:
      - 'null'
      - string
    doc: List of strand-specific assemblies among the inputs.
    inputBinding:
      position: 102
      prefix: --strand-specific-assemblies
  - id: strip_faulty_cds
    type:
      - 'null'
      - boolean
    doc: 'If set, transcripts with an incorrect CDS will be retained but with their
      CDS stripped. Default behaviour: the whole transcript will be considered invalid
      and discarded.'
    inputBinding:
      position: 102
      prefix: --strip-faulty-cds
  - id: subloci_out
    type:
      - 'null'
      - string
    doc: Name of the optional subloci output. By default, this will not be 
      produced.
    inputBinding:
      position: 102
      prefix: --subloci-out
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 102
      prefix: --threads
  - id: toml
    type:
      - 'null'
      - boolean
    doc: 'Output will be in TOML (default: inferred by filename, with TOML as fallback).'
    inputBinding:
      position: 102
      prefix: --toml
  - id: use_blast
    type:
      - 'null'
      - boolean
    doc: If switched on, Mikado will use BLAST instead of DIAMOND.
    inputBinding:
      position: 102
      prefix: --use-blast
  - id: use_transdecoder
    type:
      - 'null'
      - boolean
    doc: If switched on, Mikado will use TransDecoder instead of Prodigal.
    inputBinding:
      position: 102
      prefix: --use-transdecoder
  - id: yaml
    type:
      - 'null'
      - boolean
    doc: 'Output will be in YAML (default: inferred by filename, with TOML as fallback).'
    inputBinding:
      position: 102
      prefix: --yaml
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mikado:2.3.4--py310h8ea774a_2
stdout: mikado_configure.out
