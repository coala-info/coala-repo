cwlVersion: v1.2
class: CommandLineTool
baseCommand: tama_cds_regions_bed_add.py
label: gs-tama_tama_cds_regions_bed_add.py
doc: "This script uses data from the blastp parse file and the original annotation
  to assign the locations of the UTR/CDS regions to the bed file\n\nTool homepage:
  https://github.com/sguizard/gs-tama"
inputs:
  - id: annotation_bed_file
    type: File
    doc: Annotation bed file (required)
    inputBinding:
      position: 101
      prefix: -a
  - id: blastp_parse_file
    type: File
    doc: Blastp parse file (required)
    inputBinding:
      position: 101
      prefix: -p
  - id: fasta_annotation_file
    type: File
    doc: Fasta for annotation file (required)
    inputBinding:
      position: 101
      prefix: -f
  - id: include_stop_codon
    type:
      - 'null'
      - boolean
    doc: Include stop codon in CDS region (include_stop), default is to remove 
      stop codon from CDS region
    inputBinding:
      position: 101
      prefix: -s
  - id: nmd_distance
    type:
      - 'null'
      - int
    doc: Distance from last splice junction to call NMD (default 50bp)
    inputBinding:
      position: 101
      prefix: -d
outputs:
  - id: output_file
    type: File
    doc: Output file name (required)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
