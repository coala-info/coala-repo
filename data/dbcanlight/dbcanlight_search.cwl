cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dbcanlight
  - search
label: dbcanlight_search
doc: "The search module takes the protein fasta as input and searches against protein
  HMM, substrate HMM or diamond databases. Use \"cazyme\" mode to report the CAZyme
  families predicted by HMM; \"sub\" mode to report the potential substrates; and
  \"diamond\" mode to report the CAZyme families predicted by DIAMOND.\n\nTool homepage:
  https://github.com/chtsai0105/dbcanLight/tree/main"
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      DBCANLIGHT_DB: $(inputs.database.path)
inputs:
  - id: database
    type: Directory
    doc: Database folder made by `dbcanlight build` (cazyme.hmm, substrate.hmm, 
      substrate_mapping.tsv, cazydb.dmnd); passed to the tool as DBCANLIGHT_DB
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode for debug
    inputBinding:
      position: 102
      prefix: --verbose
  - id: input
    type: File
    doc: Plain or gzipped protein fasta
    inputBinding:
      position: 102
      prefix: --input
  - id: output
    type:
      - 'null'
      - string
    doc: 'Output directory (default: .)'
    inputBinding:
      position: 102
      prefix: --output
  - id: mode
    type: string
    doc: Search against cazyme or substrate database (one of cazyme, sub, 
      diamond)
    inputBinding:
      position: 102
      prefix: --mode
  - id: evalue
    type:
      - 'null'
      - string
    doc: 'Evalue cutoff (a number or AUTO). Use 1e-15 for hmmsearch and 1e-102 for
      diamond when specifying AUTO (default: AUTO)'
    inputBinding:
      position: 102
      prefix: --evalue
  - id: coverage
    type:
      - 'null'
      - float
    doc: 'Coverage cutoff (default: 0.35)'
    inputBinding:
      position: 102
      prefix: --coverage
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of CPU to use (default: 20)'
    inputBinding:
      position: 102
      prefix: --threads
  - id: blocksize
    type:
      - 'null'
      - int
    doc: 'Number of sequence to search per batch. Lower the blocksize to use fewer
      memory. Set as 0 to disable batching (default: 100000, not applicable on diamond)'
    inputBinding:
      position: 102
      prefix: --blocksize
outputs:
  - id: results
    type: File
    doc: Search hits (cazymes.tsv, substrates.tsv or diamond.tsv, by mode)
    outputBinding:
      glob: |-
        ${ var f = {"cazyme": "cazymes.tsv", "sub": "substrates.tsv", "diamond": "diamond.tsv"}[inputs.mode]; return inputs.output ? inputs.output + "/" + f : f; }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dbcanlight:1.1.1--pyhdfd78af_0
