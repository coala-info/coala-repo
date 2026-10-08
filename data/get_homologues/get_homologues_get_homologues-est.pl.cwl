cwlVersion: v1.2
class: CommandLineTool
baseCommand: get_homologues-est.pl
label: get_homologues_get_homologues-est.pl
doc: "This program uses BLASTN/HMMER to define clusters of 'orthologous' transcripts
  and pan/core-trancriptome sets. Different algorithm choices are available and search
  parameters are customizable. It is designed to process (in a HPC computer cluster)
  files contained in a directory (-d), so that new .fna/.faa files can be added while
  conserving previous BLASTN/HMMER results. In general the program will try to re-use
  previous results when run with the same input directory.\n\nTool homepage: https://github.com/eead-csic-compbio/get_homologues"
inputs:
  - id: add_redundant_isoforms
    type:
      - 'null'
      - boolean
    doc: add redundant isoforms to clusters (optional, requires -i)
    inputBinding:
      position: 101
      prefix: -L
  - id: add_soft_core_genome_composition
    type:
      - 'null'
      - boolean
    doc: add soft-core to genome composition analysis (optional, requires -c 
      [OMCL])
    inputBinding:
      position: 101
      prefix: -z
  - id: calculate_average_identity
    type:
      - 'null'
      - boolean
    doc: calculate average identity of clustered sequences, uses blastn results 
      (optional, creates tab-separated matrix, [OMCL])
    inputBinding:
      position: 101
      prefix: -A
  - id: calculate_pocs
    type:
      - 'null'
      - boolean
    doc: calculate percentage of conserved sequences (POCS), uses blastn 
      results, best with CDS (optional, creates tab-separated matrix, [OMCL])
    inputBinding:
      position: 101
      prefix: -P
  - id: cluster_redundant_isoforms
    type:
      - 'null'
      - int
    doc: 'cluster redundant isoforms, including those that can be concatenated with
      no overhangs, and perform calculations with longest (min overlap, default: -i
      40, use -i 0 to disable)'
    inputBinding:
      position: 101
      prefix: -i
  - id: compile_core_transcriptome
    type:
      - 'null'
      - boolean
    doc: compile core-transcriptome with minimum BLAST searches (ignores -c 
      [BDBH])
    inputBinding:
      position: 101
      prefix: -b
  - id: exclude_clusters_inparalogues
    type:
      - 'null'
      - boolean
    doc: exclude clusters with inparalogues (by default inparalogues are 
      included)
    inputBinding:
      position: 101
      prefix: -e
  - id: include_files
    type:
      - 'null'
      - File
    doc: file with .fna files in -d to be included (takes all by default, 
      requires -d)
    inputBinding:
      position: 101
      prefix: -I
  - id: input_files
    type:
      type: array
      items: File
    doc: Input transcript FASTA files (.fna, optionally .faa), 1 per sample.
      They are copied into a writable input directory (-d) and the output
      folder '<input_dir_name>_est_homologues' is created next to it.
  - id: input_dir_name
    type: string
    default: transcripts
    doc: Name of the input directory (-d) built from input_files.
  - id: max_evalue
    type:
      - 'null'
      - float
    doc: 'max E-value (default: -E 1e-05 , max=0.01)'
    inputBinding:
      position: 101
      prefix: -E
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: 'min %coverage of shortest sequence in BLAST alignments (range [1-100],default:
      -C 75)'
    inputBinding:
      position: 101
      prefix: -C
  - id: min_sequence_identity
    type:
      - 'null'
      - int
    doc: 'min %sequence identity in BLAST query/subj pairs (range [1-100],default:
      -S 95 [BDBH|OMCL])'
    inputBinding:
      position: 101
      prefix: -S
  - id: nb_threads
    type:
      - 'null'
      - int
    doc: nb of threads for BLASTN/HMMER/MCL in 'local' runmode (default=2)
    inputBinding:
      position: 101
      prefix: -n
  - id: only_blast_pfam
    type:
      - 'null'
      - boolean
    doc: only run BLASTN/Pfam searches and exit (useful to pre-compute searches)
    inputBinding:
      position: 101
      prefix: -o
  - id: orthomcl_inflation_value
    type:
      - 'null'
      - float
    doc: 'orthoMCL inflation value (range [1-5], default: -F 1.5 [OMCL])'
    inputBinding:
      position: 101
      prefix: -F
  - id: random_seed_genome_composition
    type:
      - 'null'
      - int
    doc: set random seed for genome composition analysis (optional, requires -c,
      example -R 1234)
    inputBinding:
      position: 101
      prefix: -R
  - id: reference_transcriptome
    type:
      - 'null'
      - File
    doc: reference transcriptome .fna file, one of input_files (by default takes
      file with least sequences; with BDBH sets first taxa to start adding genes)
    inputBinding:
      position: 101
      prefix: -r
      valueFrom: $(self.basename)
  - id: report_clusters_min_taxa
    type:
      - 'null'
      - int
    doc: 'report sequence clusters including at least t taxa (default: t=numberOfTaxa,
      t=0 reports all clusters [OMCL])'
    inputBinding:
      position: 101
      prefix: -t
  - id: report_transcriptome_composition
    type:
      - 'null'
      - boolean
    doc: report transcriptome composition analysis (follows order in -I file if 
      enforced, with -t N skips clusters occup<N [OMCL], ignores -r,-e)
    inputBinding:
      position: 101
      prefix: -c
  - id: require_equal_pfam_domain_composition
    type:
      - 'null'
      - boolean
    doc: require equal Pfam domain composition (best with -m cluster or -n 
      threads) when defining similarity-based orthology
    inputBinding:
      position: 101
      prefix: -D
  - id: runmode
    type:
      - 'null'
      - string
    doc: 'runmode [local|cluster|dryrun|dryrun|/path/custom/HPC.conf] (def: local,
      path overrides ./HPC.conf)'
    inputBinding:
      position: 101
      prefix: -m
  - id: use_orthomcl
    type:
      - 'null'
      - boolean
    doc: use orthoMCL algorithm (OMCL, PubMed=12952885)
    inputBinding:
      position: 101
      prefix: -M
arguments:
  - position: 100
    prefix: -d
    valueFrom: $(inputs.input_dir_name)
outputs:
  - id: est_homologues_dir
    type: Directory
    doc: Output folder '<input_dir_name>_est_homologues'.
    outputBinding:
      glob: $(inputs.input_dir_name)_est_homologues
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.input_dir_name)
        entry: "$({class: 'Directory', basename: inputs.input_dir_name, listing: inputs.input_files})"
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/get_homologues:3.8.1--hdfd78af_0
stdout: get_homologues_get_homologues-est.pl.out
