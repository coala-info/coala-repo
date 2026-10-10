cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mikado
  - configure
label: mikado_configure
doc: "Configuration utility for Mikado: writes the configuration file used by prepare, serialise and pick.\n\
  \nTool homepage: https://github.com/EI-CoreBioinformatics/mikado"
inputs:
  - id: full
    type:
      - 'null'
      - boolean
    doc: Print the full configuration.
    inputBinding:
      position: 101
      prefix: --full
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
    doc: Generate a new random seed number (instead of the default of 0).
    inputBinding:
      position: 101
      prefix: --random-seed
  - id: minimum_cdna_length
    type:
      - 'null'
      - int
    doc: Minimum cDNA length for transcripts.
    inputBinding:
      position: 101
      prefix: --minimum-cdna-length
  - id: max_intron_length
    type:
      - 'null'
      - int
    doc: Maximum intron length for transcripts.
    inputBinding:
      position: 101
      prefix: --max-intron-length
  - id: strip_faulty_cds
    type:
      - 'null'
      - boolean
    doc: If set, transcripts with an incorrect CDS will be retained but with their CDS stripped.
    inputBinding:
      position: 101
      prefix: --strip-faulty-cds
  - id: scoring
    type:
      - 'null'
      - string
    doc: Scoring file to use (for example plant.yaml or mammalian.yaml).
    inputBinding:
      position: 101
      prefix: --scoring
  - id: copy_scoring
    type:
      - 'null'
      - string
    doc: File into which to copy the selected scoring file, for modification.
    inputBinding:
      position: 101
      prefix: --copy-scoring
  - id: intron_range
    type:
      - 'null'
      - type: array
        items: int
    doc: Range into which intron lengths should fall, as a couple of integers (default 60 900).
    inputBinding:
      position: 101
      prefix: --intron-range
  - id: subloci_out
    type:
      - 'null'
      - string
    doc: Name of the optional subloci output.
    inputBinding:
      position: 101
      prefix: --subloci-out
  - id: monoloci_out
    type:
      - 'null'
      - string
    doc: Name of the optional monoloci output.
    inputBinding:
      position: 101
      prefix: --monoloci-out
  - id: no_pad
    type:
      - 'null'
      - boolean
    doc: Disable transcript padding. On by default.
    inputBinding:
      position: 101
      prefix: --no-pad
  - id: reference_update
    type:
      - 'null'
      - boolean
    doc: Prioritise transcripts marked as reference.
    inputBinding:
      position: 101
      prefix: --reference-update
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
    doc: Keep in the final output transcripts whose CDS is most probably disrupted by a retained intron
      event.
    inputBinding:
      position: 101
      prefix: -kdc
  - id: check_references
    type:
      - 'null'
      - boolean
    doc: Also check reference models against the general transcript requirements.
    inputBinding:
      position: 101
      prefix: --check-references
  - id: min_clustering_cdna_overlap
    type:
      - 'null'
      - string
    doc: Minimum cDNA overlap between two transcripts to be part of the same locus (default 20%).
    inputBinding:
      position: 101
      prefix: --min-clustering-cdna-overlap
  - id: min_clustering_cds_overlap
    type:
      - 'null'
      - string
    doc: Minimum CDS overlap between two transcripts to be part of the same locus (default 20%).
    inputBinding:
      position: 101
      prefix: --min-clustering-cds-overlap
  - id: report_all_orfs
    type:
      - 'null'
      - boolean
    doc: Report all ORFs, not just the primary.
    inputBinding:
      position: 101
      prefix: --report-all-orfs
  - id: report_all_external_metrics
    type:
      - 'null'
      - boolean
    doc: Report all available external metrics.
    inputBinding:
      position: 101
      prefix: --report-all-external-metrics
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
    doc: Only consider the CDS to determine whether a transcript is a valid alternative splicing event.
    inputBinding:
      position: 101
      prefix: --as-cds-only
  - id: strand_specific
    type:
      - 'null'
      - boolean
    doc: All the assemblies are strand-specific.
    inputBinding:
      position: 101
      prefix: --strand-specific
  - id: no_files
    type:
      - 'null'
      - boolean
    doc: Remove all files-specific options from the printed configuration file.
    inputBinding:
      position: 101
      prefix: --no-files
  - id: gff
    type:
      - 'null'
      - type: array
        items: File
    doc: Input GFF/GTF file(s), joined with commas.
    inputBinding:
      position: 101
      prefix: --gff
      itemSeparator: ','
  - id: list
    type:
      - 'null'
      - File
    doc: Tab-delimited file with rows <file> <label> <strandedness> <score> <is_reference> <exclude_redundant>
      <strip_cds> <skip_split>.
    inputBinding:
      position: 101
      prefix: --list
  - id: reference
    type:
      - 'null'
      - File
    doc: Fasta genomic reference.
    secondaryFiles:
      - .fai
      - pattern: .gzi
        required: false
    inputBinding:
      position: 101
      prefix: --reference
  - id: junctions
    type:
      - 'null'
      - File
    doc: Junctions BED file.
    inputBinding:
      position: 101
      prefix: --junctions
  - id: blast_targets
    type:
      - 'null'
      - type: array
        items: File
    doc: BLAST/DIAMOND target protein FASTA file(s), joined with commas.
    inputBinding:
      position: 101
      prefix: -bt
      itemSeparator: ','
  - id: strand_specific_assemblies
    type:
      - 'null'
      - string
    doc: List of strand-specific assemblies among the inputs.
    inputBinding:
      position: 101
      prefix: --strand-specific-assemblies
  - id: labels
    type:
      - 'null'
      - string
    doc: Labels to attach to the IDs of the transcripts of the input files, separated by comma.
    inputBinding:
      position: 101
      prefix: --labels
  - id: codon_table
    type:
      - 'null'
      - int
    doc: 'Codon table to use. Default: 0 (standard, only ATG a valid start codon).'
    inputBinding:
      position: 101
      prefix: --codon-table
  - id: external
    type:
      - 'null'
      - File
    doc: External configuration file to overwrite/add values from.
    inputBinding:
      position: 101
      prefix: --external
  - id: daijin
    type:
      - 'null'
      - boolean
    doc: The configuration file will be also valid for Daijin.
    inputBinding:
      position: 101
      prefix: --daijin
  - id: blast_chunks
    type:
      - 'null'
      - int
    doc: 'Number of parallel DIAMOND/BLAST jobs to run. Default: 10.'
    inputBinding:
      position: 101
      prefix: -bc
  - id: use_blast
    type:
      - 'null'
      - boolean
    doc: Use BLAST instead of DIAMOND.
    inputBinding:
      position: 101
      prefix: --use-blast
  - id: use_transdecoder
    type:
      - 'null'
      - boolean
    doc: Use TransDecoder instead of Prodigal.
    inputBinding:
      position: 101
      prefix: --use-transdecoder
  - id: mode
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Mode(s) for transcripts with multiple ORFs: nosplit, stringent, lenient, permissive, split.'
    inputBinding:
      position: 101
      prefix: --mode
  - id: scheduler
    type:
      - 'null'
      - string
    doc: 'Scheduler to use: local, SLURM, LSF or PBS.'
    inputBinding:
      position: 101
      prefix: --scheduler
  - id: exe
    type:
      - 'null'
      - File
    doc: Configuration file for the executables.
    inputBinding:
      position: 101
      prefix: --exe
  - id: cluster_config
    type:
      - 'null'
      - string
    doc: Cluster configuration file to write to.
    inputBinding:
      position: 101
      prefix: -c
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads.
    inputBinding:
      position: 101
      prefix: -t
  - id: skip_split
    type:
      - 'null'
      - type: array
        items: string
    doc: Labels for which splitting will be disabled (for example long reads).
    inputBinding:
      position: 101
      prefix: --skip-split
  - id: json
    type:
      - 'null'
      - boolean
    doc: Output in JSON.
    inputBinding:
      position: 101
      prefix: -j
  - id: yaml
    type:
      - 'null'
      - boolean
    doc: Output in YAML.
    inputBinding:
      position: 101
      prefix: -y
  - id: toml
    type:
      - 'null'
      - boolean
    doc: Output in TOML.
    inputBinding:
      position: 101
      prefix: --toml
  - id: out_dir
    type:
      - 'null'
      - string
    doc: Destination directory for the output.
    inputBinding:
      position: 101
      prefix: -od
  - id: out
    type:
      - 'null'
      - string
    doc: Name of the configuration file to write (the format is inferred from the extension); printed
      to standard output if omitted.
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
  - id: config_file
    type:
      - 'null'
      - File
    doc: Configuration file.
    outputBinding:
      glob: '$(inputs.out_dir ? inputs.out_dir + ''/'' + inputs.out : inputs.out)'
  - id: scoring_copy
    type:
      - 'null'
      - File
    doc: Copy of the scoring file.
    outputBinding:
      glob: $(inputs.copy_scoring)
  - id: stdout_text
    type: stdout
    doc: Configuration printed to standard output when no output file is given.
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '$(inputs.staged_files ? inputs.staged_files : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mikado:2.3.4--py310h8ea774a_2
stdout: mikado_configure.out
