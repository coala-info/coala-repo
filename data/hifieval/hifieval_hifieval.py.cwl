cwlVersion: v1.2
class: CommandLineTool
baseCommand: hifieval.py
label: hifieval_hifieval.py
doc: "HiFi-eval evaluates read error correction of PacBio HiFi reads from the PAF
  alignments of raw and corrected reads against a reference genome (over-correction,
  under-correction, correct-correction; optional homopolymer and regional
  evaluation).\n\nTool homepage: https://github.com/magspho/hifieval"
inputs:
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output file prefix
    inputBinding:
      position: 1
      prefix: -o
  - id: reference_fasta
    type:
      - 'null'
      - File
    doc: FASTA file with the reference genome for evaluation in homopolymer
      regions
    inputBinding:
      position: 1
      prefix: -h
  - id: specified_regions_evaluation
    type:
      - 'null'
      - boolean
    doc: Evaluate specified regions; give the three position files (over-corrected,
      under-corrected, correctly corrected) as region_files
    inputBinding:
      position: 1
      prefix: -b
  - id: raw_paf
    type:
      - 'null'
      - File
    doc: PAF file aligned between raw reads and the reference genome
    inputBinding:
      position: 1
      prefix: -r
  - id: corrected_paf
    type:
      - 'null'
      - File
    doc: PAF file aligned between corrected reads and the reference genome
    inputBinding:
      position: 1
      prefix: -c
  - id: region_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Position files for the regional evaluation (used with
      specified_regions_evaluation)
    inputBinding:
      position: 2
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Files written with the output prefix
    outputBinding:
      glob: $(inputs.output_prefix || 'prefix')*
  - id: stderr_log
    type: stderr
    doc: Per-chromosome correction statistics printed to standard error
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hifieval:0.4.0--pyh7cba7a3_0
stderr: hifieval.log
