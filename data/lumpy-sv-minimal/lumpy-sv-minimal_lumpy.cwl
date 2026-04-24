cwlVersion: v1.2
class: CommandLineTool
baseCommand: lumpy-sv-minimal_lumpy
label: lumpy-sv-minimal_lumpy
doc: "Find structural variations in various signals.\n\nTool homepage: https://github.com/arq5x/lumpy-sv"
inputs:
  - id: bedpe_input
    type:
      - 'null'
      - type: array
        items: string
    doc: bedpe_file:<bedpe file>, id:<sample name>, weight:<sample weight>
    inputBinding:
      position: 101
      prefix: -bedpe
  - id: exclude_file
    type:
      - 'null'
      - File
    doc: exclude file bed file
    inputBinding:
      position: 101
      prefix: -x
  - id: genome_file
    type:
      - 'null'
      - File
    doc: Genome file (defines chromosome order)
    inputBinding:
      position: 101
      prefix: -g
  - id: min_sample_weight
    type:
      - 'null'
      - float
    doc: minimum per-sample weight for a call
    inputBinding:
      position: 101
      prefix: -msw
  - id: min_weight
    type:
      - 'null'
      - float
    doc: minimum weight for a call
    inputBinding:
      position: 101
      prefix: -mw
  - id: output_bedpe
    type:
      - 'null'
      - boolean
    doc: output BEDPE instead of VCF
    inputBinding:
      position: 101
      prefix: -b
  - id: output_probability_curve
    type:
      - 'null'
      - boolean
    doc: output probability curve for each variant
    inputBinding:
      position: 101
      prefix: -P
  - id: pe_options
    type:
      - 'null'
      - type: array
        items: string
    doc: bam_file:<file name>, id:<sample name>, histo_file:<file name>, 
      mean:<value>, stdev:<value>, read_length:<length>, 
      min_non_overlap:<length>, discordant_z:<z value>, 
      back_distance:<distance>, min_mapping_threshold:<mapping quality>, 
      weight:<sample weight>, read_group:<string>
    inputBinding:
      position: 101
      prefix: -pe
  - id: show_evidence
    type:
      - 'null'
      - boolean
    doc: Show evidence for each call
    inputBinding:
      position: 101
      prefix: -e
  - id: sr_options
    type:
      - 'null'
      - type: array
        items: string
    doc: bam_file:<file name>, id:<sample name>, back_distance:<distance>, 
      min_mapping_threshold:<mapping quality>, weight:<sample weight>, 
      min_clip:<minimum clip length>, read_group:<string>
    inputBinding:
      position: 101
      prefix: -sr
  - id: temp_file_prefix
    type:
      - 'null'
      - Directory
    doc: temp file prefix, must be to a writeable directory
    inputBinding:
      position: 101
      prefix: -t
  - id: trim_threshold
    type:
      - 'null'
      - float
    doc: trim threshold
    inputBinding:
      position: 101
      prefix: -tt
  - id: window_size
    type:
      - 'null'
      - int
    doc: File read windows size
    inputBinding:
      position: 101
      prefix: -w
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lumpy-sv-minimal:0.3.1--h5ca1c30_7
stdout: lumpy-sv-minimal_lumpy.out
