cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyani
  - plot
label: pyani_plot
doc: "Plot heatmaps and distributions for runs in a pyani database.\n\nTool homepage: https://github.com/widdowquinn/pyani"
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
  - id: run_ids
    type:
      type: array
      items: int
    doc: "run IDs to plot"
    inputBinding:
      position: 10
      prefix: --run_ids
  - id: formats
    type:
      - 'null'
      - type: array
        items: string
    doc: "graphics output format; options: (pdf, png, svg, jpg)"
    inputBinding:
      position: 10
      prefix: --formats
  - id: method
    type:
      - 'null'
      - string
    doc: "graphics method to use for plotting; options (seaborn, mpl, plotly)"
    inputBinding:
      position: 10
      prefix: --method
  - id: workers
    type:
      - 'null'
      - int
    doc: "Number of worker processes for multiprocessing (default zero, meaning use all available cores)"
    inputBinding:
      position: 10
      prefix: --workers
outputs:
  - id: output_dir
    type: Directory
    doc: Plots
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.dbpath)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyani:0.2.13.1--pyhdc42f0e_0
