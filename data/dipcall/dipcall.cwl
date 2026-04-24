cwlVersion: v1.2
class: CommandLineTool
baseCommand: run-dipcall
label: dipcall
doc: "A variant calling pipeline for diploid assemblies. It takes a reference genome
  and two haploid assemblies (paternal and maternal) to produce a VCF of variants.\n\
  \nTool homepage: https://github.com/lh3/dipcall"
inputs:
  - id: ref_fasta
    type: File
    doc: Reference genome FASTA file
    inputBinding:
      position: 1
  - id: pat_fasta
    type: File
    doc: Paternal haploid assembly FASTA file
    inputBinding:
      position: 2
  - id: mat_fasta
    type: File
    doc: Maternal haploid assembly FASTA file
    inputBinding:
      position: 3
  - id: extra_asm_options
    type:
      - 'null'
      - string
    doc: Extra minimap2 options for assembly-to-reference alignment
    inputBinding:
      position: 104
      prefix: -p
  - id: min_alignment_length
    type:
      - 'null'
      - int
    doc: Minimum alignment length
    inputBinding:
      position: 104
      prefix: -z
  - id: min_alignment_score
    type:
      - 'null'
      - int
    doc: Minimum alignment score
    inputBinding:
      position: 104
      prefix: -m
  - id: preset
    type:
      - 'null'
      - string
    doc: 'Preset: hsr (human) or sam (small genome)'
    inputBinding:
      position: 104
      prefix: -x
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 104
      prefix: -t
outputs:
  - id: out_prefix
    type: File
    doc: Prefix for output files
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dipcall:0.3--hdfd78af_0
