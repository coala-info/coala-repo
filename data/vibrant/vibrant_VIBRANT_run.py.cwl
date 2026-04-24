cwlVersion: v1.2
class: CommandLineTool
baseCommand: VIBRANT_run.py
label: vibrant_VIBRANT_run.py
doc: "VIBRANT: Virus Identification By iteRative ANnoTation. Used for automated recovery
  and annotation of viruses from metagenomic assemblies.\n\nTool homepage: https://github.com/AnantharamanLab/VIBRANT"
inputs:
  - id: format
    type:
      - 'null'
      - string
    doc: input format (nucl or prot)
    inputBinding:
      position: 101
      prefix: -f
  - id: input
    type: File
    doc: input fasta file
    inputBinding:
      position: 101
      prefix: -i
  - id: lim_orf
    type:
      - 'null'
      - int
    doc: minimum number of ORFs per scaffold
    inputBinding:
      position: 101
      prefix: -n
  - id: lim_size
    type:
      - 'null'
      - int
    doc: length limit (bp) for input scaffolds
    inputBinding:
      position: 101
      prefix: -l
  - id: model_directory
    type:
      - 'null'
      - Directory
    doc: path to VIBRANT_setup.py model directory
    inputBinding:
      position: 101
      prefix: -m
  - id: no_ann
    type:
      - 'null'
      - boolean
    doc: do not perform annotation
    inputBinding:
      position: 101
      prefix: -no_ann
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: -t
  - id: virome
    type:
      - 'null'
      - boolean
    doc: use virome settings (increased sensitivity)
    inputBinding:
      position: 101
      prefix: -virome
outputs:
  - id: output_folder
    type:
      - 'null'
      - File
    doc: output folder name
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vibrant:1.2.1--hdfd78af_4
