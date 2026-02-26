cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hybran
  - annotate
label: hybran
doc: "Annotate genomes using reference annotations and ab initio gene prediction.\n\
  \nTool homepage: https://lpcdrp.gitlab.io/hybran"
inputs:
  - id: genomes
    type:
      type: array
      items: File
    doc: Directory, a space-separated list of FASTAs, or a FOFN containing all 
      genomes desired to be annotated. FASTA format required.
    inputBinding:
      position: 1
  - id: references
    type:
      type: array
      items: File
    doc: Directory, a space-separated list of GBKs, or a FOFN containing Genbank
      files of reference annotations to transfer.
    inputBinding:
      position: 2
  - id: blast_min_coverage
    type:
      - 'null'
      - float
    doc: Minimum percent query and subject alignment coverage threshold to use 
      for inferring homologs.
    default: 95
    inputBinding:
      position: 103
      prefix: --blast-min-coverage
  - id: blast_min_identity
    type:
      - 'null'
      - float
    doc: Minimum percent sequence identity threshold to use for inferring 
      homologs.
    default: 95
    inputBinding:
      position: 103
      prefix: --blast-min-identity
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Don't delete temporary files created by Hybran.
    default: false
    inputBinding:
      position: 103
      prefix: --debug
  - id: dedupe_references
    type:
      - 'null'
      - boolean
    doc: Identify duplicate genes in the reference annotations and assign one 
      name to all copies.This option is deprecated and has no effect.If name 
      unification is not desired, consider running `hybran standardize` 
      afterwards.
    default: false
    inputBinding:
      position: 103
      prefix: --dedupe-references
  - id: eggnog_databases
    type:
      - 'null'
      - Directory
    doc: Directory of the eggnog databases downloaded using 
      download_eggnog_data.py -y bactNOG. Full path only
    inputBinding:
      position: 103
      prefix: --eggnog-databases
  - id: evalue
    type:
      - 'null'
      - float
    doc: Similarity e-value cut-off
    default: '1e-09'
    inputBinding:
      position: 103
      prefix: --evalue
  - id: filter_ratt
    type:
      - 'null'
      - boolean
    doc: Enforce identity/coverage thresholds on RATT-transferred annotations.
    default: false
    inputBinding:
      position: 103
      prefix: --filter-ratt
  - id: first_reference
    type:
      - 'null'
      - string
    doc: Reference name or file name whose locus tags should be used as unified 
      names for conserved copies in the others. Default is the annotation with 
      the most named CDSs. If you specify a file here that is not in your input 
      list, it will be added.
    inputBinding:
      position: 103
      prefix: --first-reference
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite intermediate files (does not overwrite annotation files
      already annotated using hybran.
    default: false
    inputBinding:
      position: 103
      prefix: --force
  - id: genus
    type:
      - 'null'
      - string
    doc: Genus name. Deprecated -- use hybran -s/--organism instead
    inputBinding:
      position: 103
      prefix: --genus
  - id: gram
    type:
      - 'null'
      - string
    doc: Gram
    inputBinding:
      position: 103
      prefix: --gram
  - id: hmms
    type:
      - 'null'
      - string
    doc: Trusted HMM to first annotate from
    inputBinding:
      position: 103
      prefix: --hmms
  - id: kingdom
    type:
      - 'null'
      - string
    doc: Determines which UniProtKB databases Prokka searches against.
    default: Bacteria
    inputBinding:
      position: 103
      prefix: --kingdom
  - id: mcl_inflation
    type:
      - 'null'
      - float
    doc: MCL inflation value. Higher value results in more fine-grained clusters
      (fewer genes in common). See <https://micans.org/mcl/man/mcl.html#opt-I> 
      for details.
    default: 1.5
    inputBinding:
      position: 103
      prefix: --mcl-inflation
  - id: metagenome
    type:
      - 'null'
      - boolean
    doc: Improve gene predictions for highly fragmented genomes
    default: false
    inputBinding:
      position: 103
      prefix: --metagenome
  - id: no_ratt_correct_pseudogenes
    type:
      - 'null'
      - boolean
    doc: whether RATT should attempt correction of reference pseudogenes in your
      samples
    default: false
    inputBinding:
      position: 103
      prefix: --no-ratt-correct-pseudogenes
  - id: no_ratt_correct_splice
    type:
      - 'null'
      - boolean
    doc: whether RATT should attempt splice site corrections
    default: false
    inputBinding:
      position: 103
      prefix: --no-ratt-correct-splice
  - id: nproc
    type:
      - 'null'
      - int
    doc: Number of processors/CPUs to use
    default: 1
    inputBinding:
      position: 103
      prefix: --nproc
  - id: onegene_coverage_threshold
    type:
      - 'null'
      - float
    doc: Minimum percent sequence coverage threshold to use for identifying 
      redundant sequences.
    default: 99
    inputBinding:
      position: 103
      prefix: --onegene-coverage-threshold
  - id: onegene_identity_threshold
    type:
      - 'null'
      - float
    doc: Minimum percent sequence identity threshold to use for identifying 
      redundant sequences.
    default: 99
    inputBinding:
      position: 103
      prefix: --onegene-identity-threshold
  - id: orf_prefix
    type:
      - 'null'
      - string
    doc: prefix for generic gene names (*not* locus tags)
    default: HYBRA
    inputBinding:
      position: 103
      prefix: --orf-prefix
  - id: organism
    type:
      - 'null'
      - string
    doc: genus only or binomial name
    inputBinding:
      position: 103
      prefix: --organism
  - id: output
    type:
      - 'null'
      - Directory
    doc: Directory to output all new annotation files.
    default: .
    inputBinding:
      position: 103
      prefix: --output
  - id: plasmid
    type:
      - 'null'
      - string
    doc: Plasmid name or identifier
    inputBinding:
      position: 103
      prefix: --plasmid
  - id: prodigaltf
    type:
      - 'null'
      - string
    doc: Prodigal training file
    inputBinding:
      position: 103
      prefix: --prodigaltf
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: No logging output when flagged
    default: false
    inputBinding:
      position: 103
      prefix: --quiet
  - id: ratt_correct_pseudogenes
    type:
      - 'null'
      - boolean
    doc: whether RATT should attempt correction of reference pseudogenes in your
      samples
    default: false
    inputBinding:
      position: 103
      prefix: --ratt-correct-pseudogenes
  - id: ratt_correct_splice
    type:
      - 'null'
      - boolean
    doc: whether RATT should attempt splice site corrections
    default: false
    inputBinding:
      position: 103
      prefix: --ratt-correct-splice
  - id: ratt_splice_sites
    type:
      - 'null'
      - string
    doc: 'splice donor and acceptor sequences. example: GT..AG'
    default: XX..XX
    inputBinding:
      position: 103
      prefix: --ratt-splice-sites
  - id: ratt_transfer_type
    type:
      - 'null'
      - string
    doc: Presets for nucmer alignment settings to determine 
      synteny.Automatically set to 'Multiple' when multiple references are 
      provided unless 'Free' is specified.
    default: Strain
    inputBinding:
      position: 103
      prefix: --ratt-transfer-type
  - id: species
    type:
      - 'null'
      - string
    doc: Species name. Deprecated -- use hybran -s/--organism instead
    inputBinding:
      position: 103
      prefix: --species
  - id: strain
    type:
      - 'null'
      - string
    doc: Strain name. Deprecated -- use hybran -s/--organism instead
    inputBinding:
      position: 103
      prefix: --strain
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    default: false
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hybran:1.10--pyhdfd78af_0
stdout: hybran.out
