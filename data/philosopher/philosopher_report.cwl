cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - philosopher
  - report
label: philosopher_report
doc: "Multi-level reporting for both narrow-searches and open-searches\n\nTool homepage: https://github.com/Nesvilab/philosopher"
inputs:
  - id: decoys
    type:
      - 'null'
      - boolean
    doc: "add decoy observations to reports"
    inputBinding:
      position: 100
      prefix: --decoys
  - id: ionmobility
    type:
      - 'null'
      - boolean
    doc: "forces the printing of the ion mobility column"
    inputBinding:
      position: 100
      prefix: --ionmobility
  - id: msstats
    type:
      - 'null'
      - boolean
    doc: "create an output compatible with MSstats"
    inputBinding:
      position: 100
      prefix: --msstats
  - id: mzid
    type:
      - 'null'
      - boolean
    doc: "create a mzID output"
    inputBinding:
      position: 100
      prefix: --mzid
  - id: prefix
    type:
      - 'null'
      - boolean
    doc: "add the project (folder) name as a prefix to the output files"
    inputBinding:
      position: 100
      prefix: --prefix
  - id: removecontam
    type:
      - 'null'
      - boolean
    doc: "remove contaminant sequences from the reports"
    inputBinding:
      position: 100
      prefix: --removecontam
  - id: workspace
    type:
      - 'null'
      - Directory
    doc: "Philosopher workspace (the .meta folder written by an earlier step); it is staged writable as .meta in the working directory"
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: tables
    type:
      - 'null'
      - type: array
        items: File
    doc: "Reports: psm.tsv, ion.tsv, peptide.tsv, protein.tsv, protein.fas, and MSstats or mzID output when requested"
    outputBinding:
      glob:
        - '*.tsv'
        - '*.fas'
        - '*.csv'
        - '*.mzid'
  - id: workspace_out
    type:
      - 'null'
      - Directory
    doc: "Philosopher workspace (.meta folder) after this step; pass it to the next step"
    outputBinding:
      glob: .meta
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: .meta
        entry: $(inputs.workspace)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
    dockerOutputDirectory: /work
stdout: philosopher_report.out
