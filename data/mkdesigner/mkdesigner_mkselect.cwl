cwlVersion: v1.2
class: CommandLineTool
baseCommand: mkselect
label: mkdesigner_mkselect
doc: "Selects markers based on various criteria.\n\nTool homepage: https://github.com/KChigira/mkdesigner/"
inputs:
  - id: avoid_lowercase
    type:
      - 'null'
      - boolean
    doc: Select only primers written by uppercase. Lowercase may mean repeat 
      sequence.
    inputBinding:
      position: 101
      prefix: --avoid_lowercase
  - id: density_file
    type:
      - 'null'
      - File
    doc: TSV file with marker density infomation.. This file must be formatted 
      as "test/density.tsv".
    inputBinding:
      position: 101
      prefix: --density
  - id: fai_index
    type: File
    doc: Index file (.fai) of reference fasta.
    inputBinding:
      position: 101
      prefix: --fai
  - id: max_differences
    type:
      - 'null'
      - int
    doc: For indel marker, set maximum differences of PCR product length between
      alleles.
    inputBinding:
      position: 101
      prefix: --maxdif
  - id: min_differences
    type:
      - 'null'
      - int
    doc: Set minimum differences of PCR product length between alleles. For SNP 
      marker, this must be 0.
    inputBinding:
      position: 101
      prefix: --mindif
  - id: num_marker
    type: int
    doc: Number of markers selected.
    inputBinding:
      position: 101
      prefix: --num_marker
  - id: output_stem
    type: string
    doc: Identical name (must be unique). This will be stem of output directory 
      name.
    inputBinding:
      position: 101
      prefix: --output
  - id: target_position
    type:
      - 'null'
      - type: array
        items: string
    doc: Target position where primers designed e.g. "chr01:1000000-3500000"
    inputBinding:
      position: 101
      prefix: --target
  - id: vcf_primers
    type: File
    doc: VCF file with primers. This file must be made by "mkprimer" command.
    inputBinding:
      position: 101
      prefix: --vcf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mkdesigner:0.5.3--pyhdfd78af_0
stdout: mkdesigner_mkselect.out
