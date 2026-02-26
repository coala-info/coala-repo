cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vcontact3
  - run
label: vcontact3_run
doc: "vcontact3 run\n\nTool homepage: https://bitbucket.org/MAVERICLab/vcontact3"
inputs:
  - id: breaks
    type:
      - 'null'
      - int
    doc: Number of breaks for output chunking.
    default: 1
    inputBinding:
      position: 101
      prefix: --breaks
  - id: calc_silhouette
    type:
      - 'null'
      - boolean
    doc: Calculate Silhouette scores for Newick. Slightly increases processing 
      time.
    default: false
    inputBinding:
      position: 101
      prefix: --calc-silhouette
  - id: completeness_members
    type:
      - 'null'
      - int
    doc: Minimum members for completeness calculation. Moderately increases 
      processing time.Uses genus to estimate completeness.
    default: 5
    inputBinding:
      position: 101
      prefix: --completeness-members
  - id: db_domain
    type:
      - 'null'
      - string
    doc: Database domain to use.
    default: prokaryotes
    inputBinding:
      position: 101
      prefix: --db-domain
  - id: db_path
    type:
      - 'null'
      - Directory
    doc: Path to database file or directory.
    inputBinding:
      position: 101
      prefix: --db-path
  - id: db_version
    type:
      - 'null'
      - string
    doc: Database version to use.
    inputBinding:
      position: 101
      prefix: --db-version
  - id: default_realm
    type:
      - 'null'
      - string
    doc: Default realm fallback if no PC similarity found.
    default: Duplodnaviria
    inputBinding:
      position: 101
      prefix: --default-realm
  - id: distance_metric
    type:
      - 'null'
      - string
    doc: Distance metric between genomes.
    default: SqRoot
    inputBinding:
      position: 101
      prefix: --distance-metric
  - id: export_all
    type:
      - 'null'
      - boolean
    doc: For "ani", "newick" and "profiles", include ALL genomes, not just 
      user-supplied.
    default: false
    inputBinding:
      position: 101
      prefix: --export-all
  - id: exports
    type:
      - 'null'
      - type: array
        items: string
    doc: Export formats to generate.
    default:
      - ''
    inputBinding:
      position: 101
      prefix: --exports
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite existing files.
    default: false
    inputBinding:
      position: 101
      prefix: --force-overwrite
  - id: gene2genome
    type:
      - 'null'
      - File
    doc: File linking gene names to genomes (required with --proteins).
    inputBinding:
      position: 101
      prefix: --gene2genome
  - id: keep_fna
    type:
      - 'null'
      - boolean
    doc: Keep family-level nucleotide files when --export ani.
    default: false
    inputBinding:
      position: 101
      prefix: --keep-fna
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: Keep intermediate files.
    default: false
    inputBinding:
      position: 101
      prefix: --keep-temp
  - id: len_nucleotide
    type:
      - 'null'
      - File
    doc: Genome length file for normalization.
    inputBinding:
      position: 101
      prefix: --len-nucleotide
  - id: max_iterations
    type:
      - 'null'
      - int
    doc: Max number of iterations to run when resolving mixed- realm components.
      Increase to to remove or reduce large hetero-realm clusters (e.g. 
      Adnaviria|Duplornaviria)
    default: 3
    inputBinding:
      position: 101
      prefix: --max-iterations
  - id: mmseqs_fp
    type:
      - 'null'
      - File
    doc: Path to MMSeqs2 executable.
    inputBinding:
      position: 101
      prefix: --mmseqs-bin
  - id: no_progress
    type:
      - 'null'
      - boolean
    doc: Disable progress bars (useful for batch jobs).
    default: false
    inputBinding:
      position: 101
      prefix: --no-progress
  - id: nucleotides
    type:
      - 'null'
      - File
    doc: FASTA-formatted nucleotide file. Enables gene-calling, disables 
      --proteins.
    inputBinding:
      position: 101
      prefix: --nucleotide
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    default: vConTACT3_results
    inputBinding:
      position: 101
      prefix: --output
  - id: proteins
    type:
      - 'null'
      - File
    doc: FASTA-formatted proteins file. Disables ANI export
    inputBinding:
      position: 101
      prefix: --proteins
  - id: pyrodigal_gv
    type:
      - 'null'
      - boolean
    doc: Enable pyrodigal-gv models (giant viruses, alternative codes).
    default: false
    inputBinding:
      position: 101
      prefix: --pyrodigal-gv
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress progress messages; only show warnings and errors.
    default: false
    inputBinding:
      position: 101
      prefix: --quiet
  - id: reduce_memory
    type:
      - 'null'
      - boolean
    doc: Reduce memory usage with float16 arrays.
    default: false
    inputBinding:
      position: 101
      prefix: --reduce-memory
  - id: target_members
    type:
      - 'null'
      - int
    doc: Minimum members for profile rendering.
    default: 5
    inputBinding:
      position: 101
      prefix: --target-members
  - id: target_rank
    type:
      - 'null'
      - type: array
        items: string
    doc: Target rank(s) for protein cluster profiles.
    default: []
    inputBinding:
      position: 101
      prefix: --target-rank
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPUs to use.
    default: 20
    inputBinding:
      position: 101
      prefix: --threads
  - id: vclust_fp
    type:
      - 'null'
      - File
    doc: Path to vclust executable.
    inputBinding:
      position: 101
      prefix: --vclust-bin
  - id: verbose
    type:
      - 'null'
      - int
    doc: 'Increase verbosity: default=INFO, -v=DEBUG. Use --quiet to show only warnings/errors.'
    default: 0
    inputBinding:
      position: 101
      prefix: --verbose
  - id: virus_only
    type:
      - 'null'
      - boolean
    doc: Run only virus models in pyrodigal-gv.
    default: false
    inputBinding:
      position: 101
      prefix: --virus-only
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcontact3:3.1.6--pyhdfd78af_0
stdout: vcontact3_run.out
