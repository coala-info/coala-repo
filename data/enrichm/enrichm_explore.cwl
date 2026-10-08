cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - enrichm
  - explore
label: enrichm_explore
doc: "Take steps into metabolism using a KEGG compound ID as a starting point; useful to see which pathways use a compound of interest.\n\nTool homepage: https://github.com/geronimp/enrichM"
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
  - id: queries
    type: File
    doc: "A file containing the KEGG ids of the compounds from which to start in the metabolic network"
    inputBinding:
      position: 1
      prefix: --queries
  - id: depth
    type:
      - 'null'
      - int
    doc: "Number of steps to take into the metabolic network"
    inputBinding:
      position: 1
      prefix: --depth
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
      glob: explore.log
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enrichm:0.6.6--pyhdfd78af_0
