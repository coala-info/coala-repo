cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - enrichm
  - pathway
label: enrichm_pathway
doc: "Generate a metabolic network from specific KEGG modules or compounds.\n\nTool homepage: https://github.com/geronimp/enrichM"
inputs:
  - id: matrix
    type: File
    doc: "KO matrix. REQUIRED."
    inputBinding:
      position: 1
      prefix: --matrix
  - id: genome_metadata
    type:
      - 'null'
      - File
    doc: "Metadata file with two columns, the first with the genome name, the second with the groupings to compare."
    inputBinding:
      position: 1
      prefix: --genome_metadata
  - id: abundance
    type:
      - 'null'
      - File
    doc: "Abundance matrix."
    inputBinding:
      position: 1
      prefix: --abundance
  - id: abundance_metadata
    type:
      - 'null'
      - File
    doc: "Metadata file with two columns, the first with the genome name, the second with the groupings to compare."
    inputBinding:
      position: 1
      prefix: --abundance_metadata
  - id: tpm_values
    type:
      - 'null'
      - File
    doc: "TPM values produced by DetectM."
    inputBinding:
      position: 1
      prefix: --tpm_values
  - id: tpm_metadata
    type:
      - 'null'
      - File
    doc: "Metadata file with two columns, the first with the genome name, the second with the groupings to compare."
    inputBinding:
      position: 1
      prefix: --tpm_metadata
  - id: metabolome
    type:
      - 'null'
      - File
    doc: "Metabolome CID matrix."
    inputBinding:
      position: 1
      prefix: --metabolome
  - id: log
    type:
      - 'null'
      - string
    doc: "Output logging information to this file."
    inputBinding:
      position: 1
      prefix: --log
  - id: verbosity
    type:
      - 'null'
      - int
    doc: "Level of verbosity (1 - 5 - default = 4) 5 = Very verbose, 1 = Silent"
    inputBinding:
      position: 1
      prefix: --verbosity
  - id: output
    type:
      - 'null'
      - string
    doc: "Output directory"
    inputBinding:
      position: 1
      prefix: --output
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Overwrite previous run"
    inputBinding:
      position: 1
      prefix: --force
  - id: limit
    type:
      - 'null'
      - type: array
        items: string
    doc: "USE ONLY these reactions, or reactions within this pathway or module (space separated list)."
    inputBinding:
      position: 1
      prefix: --limit
  - id: filter
    type:
      - 'null'
      - type: array
        items: string
    doc: "Do not use these reactions, or reactions within this pathway or module (space separated list)."
    inputBinding:
      position: 1
      prefix: --filter
  - id: enrichment_output
    type:
      - 'null'
      - Directory
    doc: "Supply an enrichment output to integrate the results into the output network."
    inputBinding:
      position: 1
      prefix: --enrichment_output
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file written by the tool (named after the subcommand)
    outputBinding:
      glob: pathway.log
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enrichm:0.6.6--pyhdfd78af_0
