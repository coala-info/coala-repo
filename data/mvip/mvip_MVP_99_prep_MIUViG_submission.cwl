cwlVersion: v1.2
class: CommandLineTool
baseCommand: mvip_MVP_99_prep_MIUViG_submission
label: mvip_MVP_99_prep_MIUViG_submission
doc: "Additional module to assist with submitting metagenome-assembled viral genome(s)
  to GenBank, including MIUViG metadata.\n\nTool homepage: https://gitlab.com/ccoclet/mvp"
inputs:
  - id: genome
    type:
      - 'null'
      - string
    doc: Identifier of the sequence to be processed.
    inputBinding:
      position: 101
      prefix: --genome
  - id: metadata_path
    type: File
    doc: Path to your metadata that you want to use to run MVP.
    inputBinding:
      position: 101
      prefix: --metadata
  - id: step
    type:
      - 'null'
      - string
    doc: Should be one of "setup_metadata" (to be run first) or 
      "prep_submission" (once sequence metadata have been checked and 
      completed).
    inputBinding:
      position: 101
      prefix: --step
  - id: template
    type:
      - 'null'
      - File
    doc: 'path to the BioSample submission template file, generated from https://submit.ncbi.nlm.nih.gov/genbank/template/submission/,
      only required for the step 2: prep_submission'
    inputBinding:
      position: 101
      prefix: --template
  - id: working_directory_path
    type: Directory
    doc: Path to your working directory where you want to run MVP.
    inputBinding:
      position: 101
      prefix: --input
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mvip:1.1.5--pyhdfd78af_1
stdout: mvip_MVP_99_prep_MIUViG_submission.out
