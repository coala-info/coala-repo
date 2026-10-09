cwlVersion: v1.2
class: CommandLineTool
baseCommand: HSD_batch_run.py
label: hsdecipher_batch_run
doc: "Add HSDs of a series of combined thresholds in one run; the input folder holds one sub-folder per species (for example Arabidopsis_thaliana with Arabidopsis_thaliana.90_10.txt)\n\nTool homepage: https://github.com/zx0223winner/HSDecipher"
inputs:
  - id: input_folder
    type: Directory
    doc: HSD folder with one sub-folder per species; it is staged writable because the script updates its files in place
    inputBinding:
      position: 101
      prefix: --input_folder
outputs:
  - id: combined_hsd_files
    type:
      type: array
      items: File
    doc: combined HSD file of each species, named <species>.batch_run.txt
    outputBinding:
      glob: '*/*.batch_run.txt'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_folder)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hsdecipher:1.1.2--hdfd78af_0
