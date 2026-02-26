cwlVersion: v1.2
class: CommandLineTool
baseCommand: artic minion
label: artic_minion
doc: "ARTIC pipeline for MinION data\n\nTool homepage: https://github.com/artic-network/fieldbioinformatics"
inputs:
  - id: sample
    type: string
    doc: The name of the sample
    inputBinding:
      position: 1
  - id: align_consensus
    type:
      - 'null'
      - boolean
    doc: Run a mafft alignment of consensus to reference after generation
    inputBinding:
      position: 102
      prefix: --align-consensus
  - id: allow_mismatched_primers
    type:
      - 'null'
      - boolean
    doc: Do not remove reads which appear to have mismatched primers
    default: false
    inputBinding:
      position: 102
      prefix: --allow-mismatched-primers
  - id: bed
    type:
      - 'null'
      - File
    doc: BED file containing primer scheme
    inputBinding:
      position: 102
      prefix: --bed
  - id: dry_run
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --dry-run
  - id: linearise_fasta
    type:
      - 'null'
      - boolean
    doc: Output linearised (unwrapped) FASTA consensus files
    inputBinding:
      position: 102
      prefix: --linearise-fasta
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum coverage required for a position to be included in the 
      consensus sequence
    default: 20
    inputBinding:
      position: 102
      prefix: --min-depth
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality to consider
    default: 20
    inputBinding:
      position: 102
      prefix: --min-mapq
  - id: model
    type:
      - 'null'
      - string
    doc: The model to use for clair3, if not provided the pipeline will try to 
      figure it out the appropriate model from the read fastq
    inputBinding:
      position: 102
      prefix: --model
  - id: model_dir
    type:
      - 'null'
      - Directory
    doc: Path containing clair3 models, defaults to models packaged with conda 
      installation
    default: $CONDA_PREFIX/bin/models/
    inputBinding:
      position: 102
      prefix: --model-dir
  - id: no_frameshifts
    type:
      - 'null'
      - boolean
    doc: Remove variants which induce frameshifts (ignored when --no-indels set)
    inputBinding:
      position: 102
      prefix: --no-frameshifts
  - id: no_indels
    type:
      - 'null'
      - boolean
    doc: Do not report InDels (uses SNP-only mode of nanopolish/medaka)
    inputBinding:
      position: 102
      prefix: --no-indels
  - id: normalise
    type:
      - 'null'
      - int
    doc: 'Normalise down to moderate coverage to save runtime (default: 100, deactivate
      with `--normalise 0`)'
    default: 100
    inputBinding:
      position: 102
      prefix: --normalise
  - id: primer_match_threshold
    type:
      - 'null'
      - int
    doc: Allow fuzzy primer matching within this threshold
    default: 35
    inputBinding:
      position: 102
      prefix: --primer-match-threshold
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not output warnings to stderr
    inputBinding:
      position: 102
      prefix: --quiet
  - id: read_file
    type: File
    doc: FASTQ file containing reads
    inputBinding:
      position: 102
      prefix: --read-file
  - id: ref
    type:
      - 'null'
      - File
    doc: Reference sequence for the scheme
    inputBinding:
      position: 102
      prefix: --ref
  - id: scheme_directory
    type:
      - 'null'
      - Directory
    doc: Default scheme directory
    default: //primer-schemes
    inputBinding:
      position: 102
      prefix: --scheme-directory
  - id: scheme_length
    type:
      - 'null'
      - int
    doc: Length of the scheme to fetch from the scheme repository 
      (https://github.com/quick-lab/primerschemes). This is only required if the
      --scheme-name has multiple possible lengths.
    inputBinding:
      position: 102
      prefix: --scheme-length
  - id: scheme_name
    type:
      - 'null'
      - string
    doc: Name of the scheme, e.g. sars-cov-2, mpxv to fetch from the scheme 
      repository (https://github.com/quick-lab/primerschemes)
    inputBinding:
      position: 102
      prefix: --scheme-name
  - id: scheme_version
    type:
      - 'null'
      - string
    doc: Primer scheme version
    inputBinding:
      position: 102
      prefix: --scheme-version
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 8
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/artic:1.8.5--pyhdfd78af_0
stdout: artic_minion.out
