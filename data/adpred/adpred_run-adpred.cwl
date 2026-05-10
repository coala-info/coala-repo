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
      prefix: --local_psipred
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
      prefix: --uniprot_id
  - id: out_prefix_path
    type: string
    doc: Output or path parameter `out_prefix_path`
    inputBinding:
      position: 102
      prefix: --out-prefix
outputs:
  - id: out_prefix
    type: File
    doc: Prefix for output files (e.g., results will be saved to 
      <out_prefix>.predictions.csv)
    outputBinding:
      glob: $(inputs.out_prefix_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/adpred:1.3.1--pyhdfd78af_0
