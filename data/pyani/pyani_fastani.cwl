cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyani
  - fastani
label: pyani_fastani
doc: "Run fastANI based average nucleotide identity on a directory of genomes.\n\nTool homepage: https://github.com/widdowquinn/pyani"
inputs:
  - id: logfile
    type:
      - 'null'
      - string
    doc: "logfile location"
    inputBinding:
      position: 10
      prefix: -l
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "report verbose progress to log"
    inputBinding:
      position: 10
      prefix: -v
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "report debug messages to log"
    inputBinding:
      position: 10
      prefix: --debug
  - id: disable_tqdm
    type:
      - 'null'
      - boolean
    doc: "Turn off tqdm progress bar"
    inputBinding:
      position: 10
      prefix: --disable_tqdm
  - id: scheduler
    type:
      - 'null'
      - type: enum
        symbols: [multiprocessing, SGE]
    doc: "Job scheduler (default multiprocessing, i.e. locally)"
    inputBinding:
      position: 10
      prefix: --scheduler
  - id: workers
    type:
      - 'null'
      - int
    doc: "Number of worker processes for multiprocessing (default zero, meaning use all available cores)"
    inputBinding:
      position: 10
      prefix: --workers
  - id: sge_group_size
    type:
      - 'null'
      - int
    doc: "Number of jobs to place in an SGE array group (default 10000)"
    inputBinding:
      position: 10
      prefix: --SGEgroupsize
  - id: sge_args
    type:
      - 'null'
      - string
    doc: "Additional arguments for qsub"
    inputBinding:
      position: 10
      prefix: --SGEargs
  - id: job_prefix
    type:
      - 'null'
      - string
    doc: "Prefix for SGE jobs (default PYANI)."
    inputBinding:
      position: 10
      prefix: --jobprefix
  - id: name
    type:
      - 'null'
      - string
    doc: "Provide a name to help identify the analysis run"
    inputBinding:
      position: 10
      prefix: --name
  - id: classes
    type:
      - 'null'
      - File
    doc: "Path to genome classes for the run"
    inputBinding:
      position: 10
      prefix: --classes
  - id: labels
    type:
      - 'null'
      - File
    doc: "Path to genome labels for the run"
    inputBinding:
      position: 10
      prefix: --labels
  - id: recovery
    type:
      - 'null'
      - boolean
    doc: "Recover comparison results for this run"
    inputBinding:
      position: 10
      prefix: --recovery
  - id: indir
    type: Directory
    doc: "input genome directory"
    inputBinding:
      position: 1
      prefix: -i
  - id: outdir
    type: string
    doc: "output analysis results directory"
    inputBinding:
      position: 1
      prefix: -o
  - id: dbpath
    type: File
    doc: "pyani database (SQLite file, from createdb); a writable copy is used"
    inputBinding:
      position: 10
      prefix: --dbpath
      valueFrom: $(self.basename)
  - id: fastani_exe
    type:
      - 'null'
      - string
    doc: "path to fastani executable (default: fastANI)"
    inputBinding:
      position: 10
      prefix: --fastani_exe
  - id: kmer
    type:
      - 'null'
      - int
    doc: "kmer size <= 16 (default: 16)"
    inputBinding:
      position: 10
      prefix: --kmer
  - id: frag_len
    type:
      - 'null'
      - int
    doc: "fragment length (default: 3000)"
    inputBinding:
      position: 10
      prefix: --fragLen
  - id: threads
    type:
      - 'null'
      - int
    doc: "thread count for parallel execution (default: 1)"
    inputBinding:
      position: 10
      prefix: -t
  - id: min_fraction
    type:
      - 'null'
      - double
    doc: "Minimum fraction of genome that must be shared for trusting ANI. If reference and query genome size differ, smaller one among the two is considered. (default: 0.2)"
    inputBinding:
      position: 10
      prefix: --minFraction
  - id: matrix
    type:
      - 'null'
      - boolean
    doc: "Also output ANI values as lower triangular matrix (format inspired from phylip). If enabled, you should expect an output file with .matrix extension."
    inputBinding:
      position: 10
      prefix: --matrix
outputs:
  - id: output_dir
    type: Directory
    doc: Analysis results directory
    outputBinding:
      glob: $(inputs.outdir)
  - id: db_out
    type: File
    doc: Updated pyani database
    outputBinding:
      glob: $(inputs.dbpath.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.dbpath)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyani:0.2.13.1--pyhdc42f0e_0
