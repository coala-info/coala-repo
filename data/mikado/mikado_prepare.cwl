cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mikado
  - prepare
label: mikado_prepare
doc: "Prepare input files for Mikado: merges, filters and sorts the transcript assemblies into one GTF\
  \ and FASTA.\n\nTool homepage: https://github.com/EI-CoreBioinformatics/mikado"
inputs:
  - id: fasta
    type:
      - 'null'
      - File
    doc: Genome FASTA file.
    secondaryFiles:
      - .fai
      - pattern: .gzi
        required: false
    inputBinding:
      position: 101
      prefix: --fasta
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
    doc: 'Log level: DEBUG, INFO, WARN or ERROR.'
    inputBinding:
      position: 101
      prefix: -lv
  - id: start_method
    type:
      - 'null'
      - string
    doc: 'Multiprocessing start method: fork, spawn or forkserver.'
    inputBinding:
      position: 101
      prefix: --start-method
  - id: strand_specific
    type:
      - 'null'
      - boolean
    doc: Monoexonic transcripts are left on their strand rather than moved to the unknown strand.
    inputBinding:
      position: 101
      prefix: -s
  - id: strand_specific_assemblies
    type:
      - 'null'
      - string
    doc: Comma-delimited list of strand specific assemblies.
    inputBinding:
      position: 101
      prefix: -sa
  - id: list
    type:
      - 'null'
      - File
    doc: Tab-delimited file with rows <file> <label> <strandedness> <score> <is_reference> <exclude_redundant>
      <strip_cds> <skip_split>.
    inputBinding:
      position: 101
      prefix: --list
  - id: log
    type:
      - 'null'
      - string
    doc: Log file.
    inputBinding:
      position: 101
      prefix: -l
  - id: lenient
    type:
      - 'null'
      - boolean
    doc: Output transcripts with only non-canonical splices too.
    inputBinding:
      position: 101
      prefix: --lenient
  - id: minimum_cdna_length
    type:
      - 'null'
      - int
    doc: 'Minimum length for transcripts. Default: 200 bps.'
    inputBinding:
      position: 101
      prefix: -m
  - id: max_intron_length
    type:
      - 'null'
      - int
    doc: 'Maximum intron length for transcripts. Default: 1,000,000 bps.'
    inputBinding:
      position: 101
      prefix: -MI
  - id: procs
    type:
      - 'null'
      - int
    doc: Number of processors to use.
    inputBinding:
      position: 101
      prefix: -p
  - id: strip_cds
    type:
      - 'null'
      - boolean
    doc: Ignore any CDS/UTR segment.
    inputBinding:
      position: 101
      prefix: -scds
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
    doc: 'Codon table to use. Default: 0.'
    inputBinding:
      position: 101
      prefix: --codon-table
  - id: single
    type:
      - 'null'
      - boolean
    doc: Disable multi-threading.
    inputBinding:
      position: 101
      prefix: --single
  - id: output_dir
    type:
      - 'null'
      - string
    doc: 'Output directory. Default: current working directory.'
    inputBinding:
      position: 101
      prefix: -od
  - id: out
    type:
      - 'null'
      - string
    doc: 'Output file. Default: mikado_prepared.gtf.'
    inputBinding:
      position: 101
      prefix: -o
  - id: out_fasta
    type:
      - 'null'
      - string
    doc: 'Output FASTA file. Default: mikado_prepared.fasta.'
    inputBinding:
      position: 101
      prefix: -of
  - id: configuration
    type:
      - 'null'
      - File
    doc: Configuration file.
    inputBinding:
      position: 101
      prefix: --configuration
  - id: exclude_redundant
    type:
      - 'null'
      - boolean
    doc: Exclude redundant models, ignoring the per-sample instructions.
    inputBinding:
      position: 101
      prefix: -er
  - id: strip_faulty_cds
    type:
      - 'null'
      - boolean
    doc: Retain transcripts with an incorrect CDS but strip their CDS.
    inputBinding:
      position: 101
      prefix: --strip-faulty-cds
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
  - id: gff
    type:
      - 'null'
      - type: array
        items: File
    doc: Input GFF/GTF file(s).
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
  - id: prepared_gtf
    type: File
    doc: Prepared transcripts (GTF).
    outputBinding:
      glob: '$((inputs.output_dir ? inputs.output_dir + ''/'' : '''') + (inputs.out ? inputs.out : ''mikado_prepared.gtf''))'
  - id: prepared_fasta
    type: File
    doc: Prepared transcript sequences (FASTA).
    outputBinding:
      glob: '$((inputs.output_dir ? inputs.output_dir + ''/'' : '''') + (inputs.out_fasta ? inputs.out_fasta
        : ''mikado_prepared.fasta''))'
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
