cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyani
  - report
label: pyani_report
doc: "Report tables from a pyani database.\n\nTool homepage: https://github.com/widdowquinn/pyani"
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
  - id: runs
    type:
      - 'null'
      - boolean
    doc: "Report table of analysis runs in database"
    inputBinding:
      position: 10
      prefix: --runs
  - id: genomes
    type:
      - 'null'
      - boolean
    doc: "Report table of genomes in database"
    inputBinding:
      position: 10
      prefix: --genomes
  - id: runs_genomes
    type:
      - 'null'
      - boolean
    doc: "Report table of all genomes for each run in database"
    inputBinding:
      position: 10
      prefix: --runs_genomes
  - id: genomes_runs
    type:
      - 'null'
      - boolean
    doc: "Report table of all runs in which each genome in the database participates"
    inputBinding:
      position: 10
      prefix: --genomes_runs
  - id: run_results
    type:
      - 'null'
      - type: array
        items: int
    doc: "Report table of results for space-separated list of runs"
    inputBinding:
      position: 10
      prefix: --run_results
  - id: run_matrices
    type:
      - 'null'
      - type: array
        items: int
    doc: "Report matrices of results for space-separated list of runs"
    inputBinding:
      position: 10
      prefix: --run_matrices
  - id: no_matrix_labels
    type:
      - 'null'
      - boolean
    doc: "Turn off row/column labels in output matrix files"
    inputBinding:
      position: 10
      prefix: --no_matrix_labels
  - id: formats
    type:
      - 'null'
      - type: array
        items: string
    doc: "Space-separated list of output formats (in addition to .tab); possible values: {html, excel, stdout}"
    inputBinding:
      position: 10
      prefix: --formats
outputs:
  - id: output_dir
    type: Directory
    doc: Report tables
    outputBinding:
      glob: $(inputs.outdir)
  - id: stdout_text
    type: stdout
    doc: Standard output
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
stdout: pyani_report.out
