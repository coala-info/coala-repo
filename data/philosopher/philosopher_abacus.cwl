cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - philosopher
  - abacus
label: philosopher_abacus
doc: "Combined analysis of LC-MS/MS results\n\nTool homepage: https://github.com/Nesvilab/philosopher"
inputs:
  - id: full
    type:
      - 'null'
      - boolean
    doc: "generates combined tables with extra information"
    inputBinding:
      position: 100
      prefix: --full
  - id: labels
    type:
      - 'null'
      - boolean
    doc: "indicates whether the data sets includes TMT labels or not"
    inputBinding:
      position: 100
      prefix: --labels
  - id: pep_prob
    type:
      - 'null'
      - float
    doc: "minimum peptide probability"
    inputBinding:
      position: 100
      prefix: --pepProb
  - id: peptide
    type:
      - 'null'
      - boolean
    doc: "global level peptide report"
    inputBinding:
      position: 100
      prefix: --peptide
  - id: picked
    type:
      - 'null'
      - boolean
    doc: "apply the picked FDR algorithm before the protein scoring"
    inputBinding:
      position: 100
      prefix: --picked
  - id: plex
    type:
      - 'null'
      - string
    doc: "number of channels"
    inputBinding:
      position: 100
      prefix: --plex
  - id: protein
    type:
      - 'null'
      - boolean
    doc: "global level protein report"
    inputBinding:
      position: 100
      prefix: --protein
  - id: prt_prob
    type:
      - 'null'
      - float
    doc: "minimum protein probability"
    inputBinding:
      position: 100
      prefix: --prtProb
  - id: razor
    type:
      - 'null'
      - boolean
    doc: "use razor peptides for protein FDR scoring"
    inputBinding:
      position: 100
      prefix: --razor
  - id: reprint
    type:
      - 'null'
      - boolean
    doc: "create abacus reports using the Reprint format"
    inputBinding:
      position: 100
      prefix: --reprint
  - id: tag
    type:
      - 'null'
      - string
    doc: "decoy tag"
    inputBinding:
      position: 100
      prefix: --tag
  - id: uniqueonly
    type:
      - 'null'
      - boolean
    doc: "report TMT quantification based on only unique peptides"
    inputBinding:
      position: 100
      prefix: --uniqueonly
  - id: experiments
    type:
      type: array
      items: Directory
    doc: "Experiment folders, each holding the .meta workspace of a filtered experiment"
    inputBinding:
      position: 200
  - id: combined_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "combined.pep.xml and combined.prot.xml from a ProteinProphet run over all experiments; staged in the working directory"
  - id: workspace
    type:
      - 'null'
      - Directory
    doc: "Philosopher workspace (the .meta folder written by an earlier step); it is staged writable as .meta in the working directory"
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: combined
    type:
      - 'null'
      - type: array
        items: File
    doc: "Combined reports"
    outputBinding:
      glob:
        - 'combined*.tsv'
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
      - '${ return inputs.combined_files ? inputs.combined_files : []; }'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
    dockerOutputDirectory: /work
stdout: philosopher_abacus.out
