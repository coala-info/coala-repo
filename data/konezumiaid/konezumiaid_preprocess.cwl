cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - konezumiaid
  - preprocess
label: konezumiaid_preprocess
doc: "Preprocesses data for konezumiaid.\n\nTool homepage: https://github.com/aki2274/KOnezumi-AID"
inputs:
  - id: refflat_path
    type: File
    doc: Path to the refFlat text file (the name must end in .txt).
    inputBinding:
      position: 1
  - id: chromosome_fasta_path
    type: File
    secondaryFiles:
      - pattern: .fai
        required: true
    doc: Path to the chromosome fasta file, e.g. mm39.fa (the name must end in .fa or .fasta).
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: konezumiaid_data
    type: Directory
    doc: Dataset folder with the pickle files that the design commands need
    outputBinding:
      glob: konezumiaid_data
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/konezumiaid:0.3.6.1--pyhdfd78af_0
stdout: konezumiaid_preprocess.out
