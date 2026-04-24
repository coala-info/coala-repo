cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mity
  - normalise
label: mity_normalise
doc: "Normalises VCF files from mity.\n\nTool homepage: https://github.com/KCCG/mity"
inputs:
  - id: vcf
    type: File
    doc: vcf.gz file from running mity
    inputBinding:
      position: 1
  - id: allsamples
    type:
      - 'null'
      - boolean
    doc: PASS in the filter requires all samples to pass instead of just one
    inputBinding:
      position: 102
      prefix: --allsamples
  - id: custom_reference_fasta
    type:
      - 'null'
      - File
    doc: Specify custom reference fasta file
    inputBinding:
      position: 102
      prefix: --custom-reference-fasta
  - id: custom_reference_genome
    type:
      - 'null'
      - File
    doc: Specify custom reference genome file
    inputBinding:
      position: 102
      prefix: --custom-reference-genome
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enter debug mode
    inputBinding:
      position: 102
      prefix: --debug
  - id: keep
    type:
      - 'null'
      - boolean
    doc: Keep all intermediate files
    inputBinding:
      position: 102
      prefix: --keep
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output files will be saved in OUTPUT_DIR.
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: p
    type:
      - 'null'
      - float
    doc: Minimum noise level. This is used to calculate QUAL score
    inputBinding:
      position: 102
      prefix: --p
  - id: prefix
    type:
      - 'null'
      - string
    doc: Output files will be named with PREFIX
    inputBinding:
      position: 102
      prefix: --prefix
  - id: reference
    type:
      - 'null'
      - string
    doc: Reference genome version to use.
    inputBinding:
      position: 102
      prefix: --reference
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mity:2.0.1--pyhdfd78af_0
stdout: mity_normalise.out
