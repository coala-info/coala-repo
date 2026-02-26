cwlVersion: v1.2
class: CommandLineTool
baseCommand: konezumiaid_preprocess
label: konezumiaid_preprocess
doc: "Preprocesses data for konezumiaid.\n\nTool homepage: https://github.com/aki2274/KOnezumi-AID"
inputs:
  - id: refflat_path
    type: File
    doc: Path to the refFlat text file.
    inputBinding:
      position: 1
  - id: chromosome_fasta_path
    type: File
    doc: Path to the chromosome fasta file.(e.g. mm39.fa)
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/konezumiaid:0.3.6.1--pyhdfd78af_0
stdout: konezumiaid_preprocess.out
