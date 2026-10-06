cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - atlas
  - mutationLoad
label: atlas_mutationload
doc: "Estimating mutation load (proportions of sites homozygous or heterozygous for preferred and derived alleles).\n\nTool homepage: https://bitbucket.org/wegmannlab/atlas"
inputs:
  - id: bam
    type:
      - 'null'
      - File
    doc: "Input BAM file (give --bam or --glf)."
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 1
      prefix: --bam
  - id: glf
    type:
      - 'null'
      - File
    doc: "Input GLF file (give --bam or --glf)."
    secondaryFiles:
      - pattern: ^.idx
        required: false
    inputBinding:
      position: 1
      prefix: --glf
  - id: alleles
    type:
      - 'null'
      - File
    doc: "Alleles file (chr, pos, preferred allele) defining the sites to use."
    inputBinding:
      position: 1
      prefix: --alleles
  - id: regions
    type:
      - 'null'
      - File
    doc: "BED file with the sites to use; the reference base is the preferred allele (needs --fasta)."
    inputBinding:
      position: 1
      prefix: --regions
  - id: keep_reads_without_rg
    type:
      - 'null'
      - boolean
    doc: "Keep reads without a read group (by default ATLAS filters them out)."
    inputBinding:
      position: 1
      prefix: --keepReadsWithoutRG
  - id: fasta
    type:
      - 'null'
      - File
    doc: "Reference genome FASTA (with .fai index)."
    secondaryFiles:
      - pattern: .fai
        required: false
    inputBinding:
      position: 1
      prefix: --fasta
  - id: filter_mq
    type:
      - 'null'
      - string
    doc: "Keep reads with mapping quality in this range, e.g. \"[30,256]\"."
    inputBinding:
      position: 1
      prefix: --filterMQ
  - id: chr
    type:
      - 'null'
      - string
    doc: "Comma-separated list of chromosomes to use."
    inputBinding:
      position: 1
      prefix: --chr
  - id: out_prefix
    type: string
    doc: "Prefix for all output files (ATLAS --out)."
    default: "atlas_mutationLoad"
    inputBinding:
      position: 1
      prefix: --out
outputs:
  - id: log
    type: stdout
    doc: ATLAS progress report (standard output).
  - id: mutation_load
    type: File
    doc: "Genome-wide mutation load table (Pi_rr, Pi_ra, Pi_aa, Pi_ab)."
    outputBinding:
      glob: $(inputs.out_prefix)_mutationLoad.txt
  - id: parameters
    type:
      - 'null'
      - File
    doc: "Parameters used for the run."
    outputBinding:
      glob: $(inputs.out_prefix).parameters
  - id: filter_summary
    type:
      - 'null'
      - File
    doc: "Counts of reads removed by each filter."
    outputBinding:
      glob: $(inputs.out_prefix)_filterSummary.txt
  - id: rg_info
    type:
      - 'null'
      - File
    doc: "Read group information."
    outputBinding:
      glob: $(inputs.out_prefix)_RGInfo.json
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atlas:2.0.1--hadca570_0
stdout: atlas_mutationload.log
