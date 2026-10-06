cwlVersion: v1.2
class: CommandLineTool
baseCommand: run-adpred
label: adpred_run-adpred
doc: "Predicts activation domains (ADs) from protein sequences or UniProt IDs using
  deep learning and secondary structure prediction.\n\nTool homepage: https://github.com/FredHutch/adpred"
inputs:
  - id: local_psipred
    type:
      - 'null'
      - File
    doc: Path to a local installation of psipred (e.g., ~/psipred/run_psipred)
    inputBinding:
      position: 101
      prefix: --local-psipred
  - id: sequence
    type:
      - 'null'
      - string
    doc: Protein sequence to analyze
    inputBinding:
      position: 101
      prefix: --sequence
  - id: uniprot_id
    type:
      - 'null'
      - string
    doc: UniProt ID to analyze
    inputBinding:
      position: 101
      prefix: --uniprot-id
  - id: saturated_mutagenesis
    type:
      - 'null'
      - string
    doc: list of start positions separated by comma (ends are starts+30)
    inputBinding:
      position: 101
      prefix: --saturated-mutagenesis
  - id: out_prefix_path
    type: string
    doc: Output or path parameter `out_prefix_path`
    inputBinding:
      position: 102
      prefix: --output-prefix
outputs:
  - id: out_prefix
    type:
      type: array
      items: File
    doc: Prefix for output files (e.g., results will be saved to 
      <out_prefix>.predictions.csv)
    outputBinding:
      glob: $(inputs.out_prefix_path)*
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/adpred:1.3.1--pyhdfd78af_0
