cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyani
  - classify
label: pyani_classify
doc: "Classify genomes of a run into clusters by identity and coverage thresholds.\n\nTool homepage: https://github.com/widdowquinn/pyani"
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
  - id: outdir
    type: string
    doc: "output directory"
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
  - id: run_id
    type: int
    doc: "run ID to classify"
    inputBinding:
      position: 10
      prefix: --run_id
  - id: cov_min
    type:
      - 'null'
      - double
    doc: "minimum %coverage for an edge (default: 0.5)"
    inputBinding:
      position: 10
      prefix: --cov_min
  - id: id_min
    type:
      - 'null'
      - double
    doc: "minimum %identity for an edge (default: 0.8)"
    inputBinding:
      position: 10
      prefix: --id_min
  - id: min_id
    type:
      - 'null'
      - double
    doc: "minimum identity threshold to test"
    inputBinding:
      position: 10
      prefix: --min_id
  - id: max_id
    type:
      - 'null'
      - double
    doc: "maximum identity threshold to test"
    inputBinding:
      position: 10
      prefix: --max_id
  - id: resolution
    type:
      - 'null'
      - double
    doc: "number of identity thresholds to test (default: 0.0001)"
    inputBinding:
      position: 10
      prefix: --resolution
  - id: show_all
    type:
      - 'null'
      - boolean
    doc: "report all intervals in log (default: only intervals where all subgraphs are k-complete"
    inputBinding:
      position: 10
      prefix: --show_all
outputs:
  - id: output_dir
    type: Directory
    doc: Classification output directory (this pyani version writes results to the log only)
    outputBinding:
      glob: $(inputs.outdir)
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file with the classification intervals (written when logfile is set)
    outputBinding:
      glob: $(inputs.logfile)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.dbpath)
        writable: true
      - entryname: $(inputs.outdir)
        entry: "$({class: 'Directory', listing: []})"
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyani:0.2.13.1--pyhdc42f0e_0
