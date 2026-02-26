cwlVersion: v1.2
class: CommandLineTool
baseCommand: tama_remove_fragment_models.py
label: gs-tama_tama_remove_fragment_models.py
doc: "This script absorbs transcriptomes.\n\nTool homepage: https://github.com/sguizard/gs-tama"
inputs:
  - id: bed_file
    type:
      - 'null'
      - File
    doc: Bed file
    inputBinding:
      position: 101
      prefix: -f
  - id: exon_ends_threshold
    type:
      - 'null'
      - int
    doc: Exon ends threshold/ splice junction threshold
    default: 10
    inputBinding:
      position: 101
      prefix: -m
  - id: output_file_prefix
    type:
      - 'null'
      - string
    doc: Output file prefix
    inputBinding:
      position: 101
      prefix: -o
  - id: pull_cds_option
    type:
      - 'null'
      - string
    doc: Pull CDS option
    default: tama_cds where CDS regions matching TSS and TTS are ignored if 
      another CDS is found. Use longest_cds to pick the longest CDS
    inputBinding:
      position: 101
      prefix: -cds
  - id: single_exon_overlap_percent_threshold
    type:
      - 'null'
      - int
    doc: Single exon overlap percent threshold
    default: 20
    inputBinding:
      position: 101
      prefix: -s
  - id: trans_ends_wobble_threshold
    type:
      - 'null'
      - int
    doc: Trans ends wobble threshold
    default: 500
    inputBinding:
      position: 101
      prefix: -e
  - id: use_original_id
    type:
      - 'null'
      - string
    doc: Use original ID line original_id
    default: tama_id line based on gene_id;transcript_id structure
    inputBinding:
      position: 101
      prefix: -id
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
stdout: gs-tama_tama_remove_fragment_models.py.out
