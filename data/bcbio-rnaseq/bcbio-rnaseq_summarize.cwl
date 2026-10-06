cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bcbio-rnaseq
  - summarize
label: bcbio-rnaseq_summarize
doc: "Summarize RNA-Seq analysis results from a bcbio project.\n\nTool homepage: https://github.com/hbc/bcbioRNASeq"
inputs:
  - id: project_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files the project file refers to by relative path (combined.counts,
      the bcbio_system.yaml named in the project file); staged beside it
  - id: project_file
    type: File
    doc: bcbio project configuration file (YAML format)
    inputBinding:
      position: 1
      valueFrom: $(runtime.outdir)/$(self.basename)
  - id: formula
    type:
      - 'null'
      - string
    doc: 'Formula to use in model, written without spaces (example: ~batch+condition); the bcbio-rnaseq wrapper script splits arguments on spaces'
    inputBinding:
      position: 102
      prefix: --formula
  - id: organism
    type:
      - 'null'
      - string
    doc: organism (mouse, human)
    inputBinding:
      position: 102
      prefix: --organism
  - id: run_dexseq
    type:
      - 'null'
      - boolean
    doc: Run DEXSeq analysis
    inputBinding:
      position: 102
      prefix: --dexseq
  - id: run_sleuth
    type:
      - 'null'
      - boolean
    doc: Run Sleuth analysis
    inputBinding:
      position: 102
      prefix: --sleuth
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: summary_dir
    type: Directory
    doc: Folder with the QC summary R Markdown report (qc-summary.Rmd) and its
      templates, written beside the project file
    outputBinding:
      glob: summary
  - id: tidy_summary
    type: File
    doc: CSV table of per-sample summary metrics and metadata
    outputBinding:
      glob: $(inputs.project_file.nameroot).csv
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.project_file)
        writable: true
      - $(inputs.project_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcbio-rnaseq:1.2.0--r3.3.2_3
stdout: bcbio-rnaseq_summarize.out
