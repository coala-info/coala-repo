cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - crisprme.py
  - generate-personal-card
label: crisprme_generate-personal-card
doc: "Personal card generator that creates files with all the private targets for
  the input sample. The cards are written into the result folder, so it is staged
  writable in the working directory.\n\nTool homepage: https://github.com/samuelecancellieri/CRISPRme"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.result_dir)
        writable: true
inputs:
  - id: result_dir
    type: Directory
    doc: Directory containing the result from which extract the targets to 
      generate the card
    inputBinding:
      position: 1
      prefix: --result_dir
      valueFrom: $(self.basename)
  - id: guide_seq
    type: string
    doc: Sequence of the guide to use in order to extract the targets
    inputBinding:
      position: 1
      prefix: --guide_seq
  - id: sample_id
    type: string
    doc: ID of the sample to use in order to generate the card
    inputBinding:
      position: 1
      prefix: --sample_id
outputs:
  - id: result_dir_out
    type: Directory
    doc: Result folder with the personal card files added
    outputBinding:
      glob: $(inputs.result_dir.basename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crisprme:2.1.9--py38hdfd78af_0
