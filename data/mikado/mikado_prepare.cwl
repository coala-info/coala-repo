cwlVersion: v1.2
class: CommandLineTool
baseCommand: mikado_prepare
label: mikado_prepare
doc: "Prepare input files for Mikado.\n\nTool homepage: https://github.com/lucventurini/mikado"
inputs:
  - id: gff_files
    type:
      type: array
      items: File
    doc: Input GFF/GTF file(s).
    inputBinding:
      position: 1
  - id: codon_table
    type:
      - 'null'
      - int
    doc: 'Codon table to use. Default: 0 (ie Standard, NCBI #1, but only ATG is considered
      a valid start codon.'
    default: 0
    inputBinding:
      position: 102
      prefix: --codon-table
  - id: configuration
    type:
      - 'null'
      - File
    doc: Configuration file.
    inputBinding:
      position: 102
      prefix: --configuration
  - id: exclude_redundant
    type:
      - 'null'
      - boolean
    doc: Boolean flag. If invoked, Mikado prepare will exclude redundant 
      models,ignoring the per-sample instructions.
    inputBinding:
      position: 102
      prefix: --exclude-redundant
  - id: labels
    type:
      - 'null'
      - string
    doc: Labels to attach to the IDs of the transcripts of the input files, 
      separated by comma.
    inputBinding:
      position: 102
      prefix: --labels
  - id: lenient
    type:
      - 'null'
      - boolean
    doc: Flag. If set, transcripts with only non-canonical splices will be 
      output as well.
    inputBinding:
      position: 102
      prefix: --lenient
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
  - id: log
    type:
      - 'null'
      - File
    doc: Log file. Optional.
    inputBinding:
      position: 102
      prefix: --log
  - id: log_level
    type:
      - 'null'
      - string
    doc: Log level.
    default: INFO
    inputBinding:
      position: 102
      prefix: --log-level
  - id: max_intron_size
    type:
      - 'null'
      - int
    doc: Maximum intron length for transcripts.
    default: 1000000
    inputBinding:
      position: 102
      prefix: --max-intron-size
  - id: minimum_cdna_length
    type:
      - 'null'
      - int
    doc: Minimum length for transcripts.
    default: 200
    inputBinding:
      position: 102
      prefix: --minimum-cdna-length
  - id: out
    type:
      - 'null'
      - File
    doc: 'Output file. Default: mikado_prepared.gtf.'
    default: mikado_prepared.gtf
    inputBinding:
      position: 102
      prefix: --out
  - id: out_fasta
    type:
      - 'null'
      - File
    doc: 'Output file. Default: mikado_prepared.fasta.'
    default: mikado_prepared.fasta
    inputBinding:
      position: 102
      prefix: --out_fasta
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: 'Output directory. Default: current working directory'
    default: .
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: procs
    type:
      - 'null'
      - int
    doc: Number of processors to use (default None)
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
  - id: reference
    type: File
    doc: Genome FASTA file. Required.
    inputBinding:
      position: 102
      prefix: --fasta
  - id: seed
    type:
      - 'null'
      - int
    doc: 'Random seed number. Default: 0.'
    default: 0
    inputBinding:
      position: 102
      prefix: --seed
  - id: single_thread
    type:
      - 'null'
      - boolean
    doc: Disable multi-threading. Useful for debugging.
    inputBinding:
      position: 102
      prefix: --single
  - id: start_method
    type:
      - 'null'
      - string
    doc: Multiprocessing start method.
    inputBinding:
      position: 102
      prefix: --start-method
  - id: strand_specific
    type:
      - 'null'
      - boolean
    doc: Flag. If set, monoexonic transcripts will be left on their strand 
      rather than being moved to the unknown strand.
    inputBinding:
      position: 102
      prefix: --strand-specific
  - id: strand_specific_assemblies
    type:
      - 'null'
      - string
    doc: Comma-delimited list of strand specific assemblies.
    inputBinding:
      position: 102
      prefix: --strand-specific-assemblies
  - id: strip_cds
    type:
      - 'null'
      - boolean
    doc: Boolean flag. If set, ignores any CDS/UTR segment.
    inputBinding:
      position: 102
      prefix: --strip_cds
  - id: strip_faulty_cds
    type:
      - 'null'
      - boolean
    doc: 'Flag. If set, transcripts with an incorrect CDS will be retained but with
      their CDS stripped. Default behaviour: the whole transcript will be considered
      invalid and discarded.'
    inputBinding:
      position: 102
      prefix: --strip-faulty-cds
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
stdout: mikado_prepare.out
