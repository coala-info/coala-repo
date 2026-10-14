cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - philosopher
  - proteinprophet
label: philosopher_proteinprophet
doc: "Protein identification validation\n\nTool homepage: https://github.com/Nesvilab/philosopher"
inputs:
  - id: iprophet
    type:
      - 'null'
      - boolean
    doc: "input is from iProphet"
    inputBinding:
      position: 100
      prefix: --iprophet
  - id: maxppmdiff
    type:
      - 'null'
      - int
    doc: "maximum peptide mass difference in ppm"
    inputBinding:
      position: 100
      prefix: --maxppmdiff
  - id: minprob
    type:
      - 'null'
      - float
    doc: "probability threshold"
    inputBinding:
      position: 100
      prefix: --minprob
  - id: nonsp
    type:
      - 'null'
      - boolean
    doc: "do not use NSP model"
    inputBinding:
      position: 100
      prefix: --nonsp
  - id: output
    type:
      - 'null'
      - string
    doc: "Output name"
    inputBinding:
      position: 100
      prefix: --output
  - id: subgroups
    type:
      - 'null'
      - boolean
    doc: "do not use NOGROUPS"
    inputBinding:
      position: 100
      prefix: --subgroups
  - id: unmapped
    type:
      - 'null'
      - boolean
    doc: "report results for UNMAPPED proteins"
    inputBinding:
      position: 100
      prefix: --unmapped
  - id: pepxml
    type:
      type: array
      items: File
    doc: "PeptideProphet or iProphet pepXML files"
    inputBinding:
      position: 200
  - id: workspace
    type:
      - 'null'
      - Directory
    doc: "Philosopher workspace (the .meta folder written by an earlier step); it is staged writable as .meta in the working directory"
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: protxml
    type:
      - 'null'
      - File
    doc: "Protein groups in protXML format"
    outputBinding:
      glob: '*.prot.xml'
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
stdout: philosopher_proteinprophet.out
