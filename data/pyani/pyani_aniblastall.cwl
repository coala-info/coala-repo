cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyani
  - aniblastall
label: pyani_aniblastall
doc: "Run ANIblastall (legacy BLAST based average nucleotide identity) on a directory of genomes.\n\nTool homepage: https://github.com/widdowquinn/pyani"
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
outputs:
  - id: output_dir
    type: Directory
    doc: Analysis results directory
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyani:0.2.13.1--pyhdc42f0e_0
