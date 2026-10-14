cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - philosopher
  - iprophet
label: philosopher_iprophet
doc: "MS/MS integrative analysis\n\nTool homepage: https://github.com/Nesvilab/philosopher"
inputs:
  - id: decoy
    type:
      - 'null'
      - string
    doc: "specify the decoy tag"
    inputBinding:
      position: 100
      prefix: --decoy
  - id: min_prob
    type:
      - 'null'
      - float
    doc: "specify minimum probability of results to report"
    inputBinding:
      position: 100
      prefix: --minProb
  - id: no_fpkm
    type:
      - 'null'
      - boolean
    doc: "do not use FPKM model"
    inputBinding:
      position: 100
      prefix: --nofpkm
  - id: no_nrs
    type:
      - 'null'
      - boolean
    doc: "do not use NRS model"
    inputBinding:
      position: 100
      prefix: --nonrs
  - id: no_nse
    type:
      - 'null'
      - boolean
    doc: "do not use NSE model"
    inputBinding:
      position: 100
      prefix: --nonse
  - id: no_nsi
    type:
      - 'null'
      - boolean
    doc: "do not use NSI model"
    inputBinding:
      position: 100
      prefix: --nonsi
  - id: no_nsm
    type:
      - 'null'
      - boolean
    doc: "do not use NSM model"
    inputBinding:
      position: 100
      prefix: --nonsm
  - id: no_nsp
    type:
      - 'null'
      - boolean
    doc: "do not use NSP model"
    inputBinding:
      position: 100
      prefix: --nonsp
  - id: no_nss
    type:
      - 'null'
      - boolean
    doc: "do not use NSS model"
    inputBinding:
      position: 100
      prefix: --nonss
  - id: output
    type:
      - 'null'
      - string
    doc: "specify output name prefix"
    inputBinding:
      position: 100
      prefix: --output
  - id: peptide_length_model
    type:
      - 'null'
      - boolean
    doc: "use Peptide Length model"
    inputBinding:
      position: 100
      prefix: --length
  - id: sharp_nse
    type:
      - 'null'
      - boolean
    doc: "use more discriminating model for NSE in SWATH mode"
    inputBinding:
      position: 100
      prefix: --sharpnse
  - id: threads
    type:
      - 'null'
      - int
    doc: "specify threads to use"
    inputBinding:
      position: 100
      prefix: --threads
  - id: pepxml
    type:
      type: array
      items: File
    doc: "PeptideProphet pepXML files to combine"
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
  - id: iprophet_pepxml
    type:
      - 'null'
      - type: array
        items: File
    doc: "iProphet results"
    outputBinding:
      glob: '*.iproph.pep.xml'
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
stdout: philosopher_iprophet.out
