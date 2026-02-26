cwlVersion: v1.2
class: CommandLineTool
baseCommand: mfa
label: montreal-forced-aligner_mfa model download acoustic
doc: "Download an acoustic model for Montreal Forced Aligner.\n\nTool homepage: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner"
inputs:
  - id: acoustic_model_name
    type: string
    doc: The name of the acoustic model to download.
    inputBinding:
      position: 1
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: The directory to save the acoustic model to. Defaults to the MFA data 
      directory.
    inputBinding:
      position: 102
      prefix: --output_directory
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/montreal-forced-aligner:3.3.8
stdout: montreal-forced-aligner_mfa model download acoustic.out
