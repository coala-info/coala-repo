cwlVersion: v1.2
class: CommandLineTool
baseCommand: tama_remove_single_read_models_levels.py
label: gs-tama_tama_remove_single_read_models_levels.py
doc: "This script uses the TAMA collapse and TAMA merge outputs to remove single read
  models\n\nTool homepage: https://github.com/sguizard/gs-tama"
inputs:
  - id: annotation_bed_file
    type:
      - 'null'
      - File
    doc: Annotation bed file
    inputBinding:
      position: 101
      prefix: -b
  - id: default_to_keep_multi_exon_models
    type:
      - 'null'
      - string
    doc: Default to keep all multi-exon models (keep_multi or remove_multi)
    inputBinding:
      position: 101
      prefix: -k
  - id: level_of_removal
    type:
      - 'null'
      - string
    doc: Level of removal (gene or transcript level). Gene level will only 
      remove genes with a single read, transcript level will remove all 
      singleton transcripts.
    inputBinding:
      position: 101
      prefix: -l
  - id: min_reads_support
    type:
      - 'null'
      - int
    doc: Requires models to have support from at least this number of reads. 
      Default is 2
    default: 2
    inputBinding:
      position: 101
      prefix: -n
  - id: min_sources_support
    type:
      - 'null'
      - int
    doc: Requires models to have support from at least this number of sources. 
      Default is 1
    default: 1
    inputBinding:
      position: 101
      prefix: -s
  - id: output_prefix
    type: string
    doc: Output prefix (required)
    inputBinding:
      position: 101
      prefix: -o
  - id: read_support_file
    type:
      - 'null'
      - File
    doc: Read support file
    inputBinding:
      position: 101
      prefix: -r
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
stdout: gs-tama_tama_remove_single_read_models_levels.py.out
