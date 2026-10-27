cwlVersion: v1.2
class: CommandLineTool
baseCommand: VIBRANT_run.py
label: vibrant_VIBRANT_run.py
doc: "VIBRANT: Virus Identification By iteRative ANnoTation. Used for automated recovery
  and annotation of viruses from metagenomic assemblies.\n\nTool homepage: https://github.com/AnantharamanLab/VIBRANT"
inputs:
  - id: input
    type: File
    doc: input fasta file
    inputBinding:
      position: 101
      prefix: -i
  - id: format
    type:
      - 'null'
      - type: enum
        symbols:
          - prot
          - nucl
    doc: format of input [default="nucl"]
    inputBinding:
      position: 101
      prefix: -f
  - id: folder
    type:
      - 'null'
      - string
    doc: path to deposit output folder and temporary files, will create if doesn't exist [default= working directory]
    inputBinding:
      position: 101
      prefix: -folder
  - id: threads
    type:
      - 'null'
      - int
    doc: number of parallel VIBRANT runs, each occupies 1 CPU [default=1, max of 1 CPU per scaffold]
    inputBinding:
      position: 101
      prefix: -t
  - id: lim_size
    type:
      - 'null'
      - int
    doc: length in basepairs to limit input sequences [default=1000, can increase but not decrease]
    inputBinding:
      position: 101
      prefix: -l
  - id: lim_orf
    type:
      - 'null'
      - int
    doc: number of ORFs per scaffold to limit input sequences [default=4, can increase but not decrease]
    inputBinding:
      position: 101
      prefix: -o
  - id: virome
    type:
      - 'null'
      - boolean
    doc: use this setting if dataset is known to be comprised mainly of viruses. More sensitive to viruses, less sensitive to false identifications [default=off]
    inputBinding:
      position: 101
      prefix: -virome
  - id: no_plot
    type:
      - 'null'
      - boolean
    doc: suppress the generation of summary plots [default=off]
    inputBinding:
      position: 101
      prefix: -no_plot
  - id: databases_directory
    type:
      - 'null'
      - Directory
    doc: path to original "databases" directory that contains .HMM files (if moved from default location)
    inputBinding:
      position: 101
      prefix: -d
  - id: model_directory
    type:
      - 'null'
      - Directory
    doc: path to original "files" directory that contains .tsv and model files (if moved from default location)
    inputBinding:
      position: 101
      prefix: -m
outputs:
  - id: output_folder
    type: Directory
    doc: VIBRANT_<input name> results folder, inside the -folder directory when given
    outputBinding:
      glob: "${ return (inputs.folder ? inputs.folder.replace(/\\/+$/, '') + '/' : '') + 'VIBRANT_*'; }"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vibrant:1.2.1--hdfd78af_4
