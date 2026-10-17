cwlVersion: v1.2
class: CommandLineTool
baseCommand: average_nucleotide_identity.py
label: pyani_average_nucleotide_identity
doc: "Calculate average nucleotide identity (ANIm, ANIb, ANIblastall or TETRA) for all genomes in a directory.\n\nTool homepage: https://github.com/widdowquinn/pyani"
inputs:
  - id: outdirname
    type: string
    doc: "Output directory (required)"
    inputBinding:
      position: 1
      prefix: -o
  - id: indir
    type: Directory
    doc: "Input directory name (required)"
    inputBinding:
      position: 1
      prefix: -i
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Give verbose output"
    inputBinding:
      position: 10
      prefix: -v
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Report debug messages"
    inputBinding:
      position: 10
      prefix: --debug
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Force file overwriting"
    inputBinding:
      position: 10
      prefix: -f
  - id: fragsize
    type:
      - 'null'
      - int
    doc: "Sequence fragment size for ANIb (default 1020)"
    inputBinding:
      position: 10
      prefix: -s
  - id: logfile
    type:
      - 'null'
      - string
    doc: "Logfile location"
    inputBinding:
      position: 10
      prefix: -l
  - id: skip_nucmer
    type:
      - 'null'
      - boolean
    doc: "Skip NUCmer runs, for testing (e.g. if output already present)"
    inputBinding:
      position: 10
      prefix: --skip_nucmer
  - id: skip_blastn
    type:
      - 'null'
      - boolean
    doc: "Skip BLASTN runs, for testing (e.g. if output already present)"
    inputBinding:
      position: 10
      prefix: --skip_blastn
  - id: noclobber
    type:
      - 'null'
      - boolean
    doc: "Don't nuke existing files"
    inputBinding:
      position: 10
      prefix: --noclobber
  - id: nocompress
    type:
      - 'null'
      - boolean
    doc: "Don't compress/delete the comparison output"
    inputBinding:
      position: 10
      prefix: --nocompress
  - id: graphics
    type:
      - 'null'
      - boolean
    doc: "Generate heatmap of ANI"
    inputBinding:
      position: 10
      prefix: -g
  - id: gformat
    type:
      - 'null'
      - string
    doc: "Graphics output format(s) [pdf|png|jpg|svg] (default pdf,png,eps meaning three file formats)"
    inputBinding:
      position: 10
      prefix: --gformat
  - id: gmethod
    type:
      - 'null'
      - type: enum
        symbols: [mpl, seaborn]
    doc: "Graphics output method (default mpl)"
    inputBinding:
      position: 10
      prefix: --gmethod
  - id: labels
    type:
      - 'null'
      - File
    doc: "Path to file containing sequence labels"
    inputBinding:
      position: 10
      prefix: --labels
  - id: classes
    type:
      - 'null'
      - File
    doc: "Path to file containing sequence classes"
    inputBinding:
      position: 10
      prefix: --classes
  - id: method
    type:
      - 'null'
      - type: enum
        symbols: [ANIm, ANIb, ANIblastall, TETRA]
    doc: "ANI method (default ANIm)"
    inputBinding:
      position: 10
      prefix: -m
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
  - id: maxmatch
    type:
      - 'null'
      - boolean
    doc: "Override MUMmer to allow all NUCmer matches"
    inputBinding:
      position: 10
      prefix: --maxmatch
  - id: nucmer_exe
    type:
      - 'null'
      - string
    doc: "Path to NUCmer executable"
    inputBinding:
      position: 10
      prefix: --nucmer_exe
  - id: filter_exe
    type:
      - 'null'
      - string
    doc: "Path to delta-filter executable"
    inputBinding:
      position: 10
      prefix: --filter_exe
  - id: blastn_exe
    type:
      - 'null'
      - string
    doc: "Path to BLASTN+ executable"
    inputBinding:
      position: 10
      prefix: --blastn_exe
  - id: makeblastdb_exe
    type:
      - 'null'
      - string
    doc: "Path to BLAST+ makeblastdb executable"
    inputBinding:
      position: 10
      prefix: --makeblastdb_exe
  - id: blastall_exe
    type:
      - 'null'
      - string
    doc: "Path to BLASTALL executable"
    inputBinding:
      position: 10
      prefix: --blastall_exe
  - id: formatdb_exe
    type:
      - 'null'
      - string
    doc: "Path to BLAST formatdb executable"
    inputBinding:
      position: 10
      prefix: --formatdb_exe
  - id: write_excel
    type:
      - 'null'
      - boolean
    doc: "Write Excel format output tables"
    inputBinding:
      position: 10
      prefix: --write_excel
  - id: rerender
    type:
      - 'null'
      - boolean
    doc: "Rerender graphics output without recalculation"
    inputBinding:
      position: 10
      prefix: --rerender
  - id: subsample
    type:
      - 'null'
      - double
    doc: "Subsample a percentage [0-1] or specific number (1-n) of input sequences"
    inputBinding:
      position: 10
      prefix: --subsample
  - id: seed
    type:
      - 'null'
      - int
    doc: "Set random seed for reproducible subsampling."
    inputBinding:
      position: 10
      prefix: --seed
  - id: job_prefix
    type:
      - 'null'
      - string
    doc: "Prefix for SGE jobs (default ANI)."
    inputBinding:
      position: 10
      prefix: --jobprefix
outputs:
  - id: output_dir
    type: Directory
    doc: Analysis results directory
    outputBinding:
      glob: $(inputs.outdirname)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyani:0.2.13.1--pyhdc42f0e_0
