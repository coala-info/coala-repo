cwlVersion: v1.2
class: CommandLineTool
baseCommand: tama_remove_polya_models_levels.py
label: gs-tama_tama_remove_polya_models_levels.py
doc: "This script uses the TAMA collapse and TAMA merge outputs to remove Poly-A models\n\nTool homepage: https://github.com/sguizard/gs-tama"
inputs:
  - id: annotation_bed_file
    type:
      - 'null'
      - File
    doc: Annotation bed file
    inputBinding:
      position: 101
      prefix: -b
  - id: file_list
    type:
      - 'null'
      - File
    doc: "Filelist file with Poly-A file names (tab separated: source name, polya file name)"
    inputBinding:
      position: 101
      prefix: -f
  - id: read_support_file
    type:
      - 'null'
      - File
    doc: Read support file
    inputBinding:
      position: 101
      prefix: -r
  - id: output_prefix
    type: string
    doc: Output prefix (required)
    inputBinding:
      position: 101
      prefix: -o
  - id: polya_percent_threshold
    type:
      - 'null'
      - double
    doc: Percent poly-A threshold (default of 75.0)
    inputBinding:
      position: 101
      prefix: -p
  - id: level_of_removal
    type:
      - 'null'
      - string
    doc: Level of removal (gene or transcript level)
    inputBinding:
      position: 101
      prefix: -l
  - id: remove_models_mode
    type:
      - 'null'
      - string
    doc: "Remove all models with Poly-A (all_polya or singleton_polya). Default is singleton_polya."
    inputBinding:
      position: 101
      prefix: -a
  - id: keep_multi_exon_models
    type:
      - 'null'
      - string
    doc: Keep all multi-exon models (keep_multi or remove_multi)
    inputBinding:
      position: 101
      prefix: -k
  - id: listed_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Poly-A files named in the file list (the polya.txt files from tama_collapse); they are staged in the working directory so that the names in the file list resolve"
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_prefix_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in output_prefix
    outputBinding:
      glob: $(inputs.output_prefix)*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.listed_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
stdout: gs-tama_tama_remove_polya_models_levels.py.out
