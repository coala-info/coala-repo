cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyTMB.py
label: tmb_pyTMB.py
doc: "Calculates Tumor Mutational Burden (TMB) from variant data.\n\nTool homepage:
  https://github.com/bioinfo-pf-curie/TMB"
inputs:
  - id: bed
    type:
      - 'null'
      - File
    doc: Capture design to use if effGenomeSize is not defined (BED file)
    inputBinding:
      position: 101
      prefix: --bed
  - id: cancer_db
    type:
      - 'null'
      - string
    doc: Databases used for cancer hotspot annotation (comma separated)
    inputBinding:
      position: 101
      prefix: --cancerDb
  - id: db_config
    type: string
    doc: Databases config file
    inputBinding:
      position: 101
      prefix: --dbConfig
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Export original VCF with TMB_FILTER tag
    inputBinding:
      position: 101
      prefix: --debug
  - id: eff_genome_size
    type:
      - 'null'
      - string
    doc: Effective genome size
    inputBinding:
      position: 101
      prefix: --effGenomeSize
  - id: export
    type:
      - 'null'
      - boolean
    doc: Export a VCF with the considered variants
    inputBinding:
      position: 101
      prefix: --export
  - id: filter_cancer_hotspot
    type:
      - 'null'
      - boolean
    doc: Filter variants annotated as cancer hotspots
    inputBinding:
      position: 101
      prefix: --filterCancerHotspot
  - id: filter_coding
    type:
      - 'null'
      - boolean
    doc: Filter Coding variants
    inputBinding:
      position: 101
      prefix: --filterCoding
  - id: filter_indels
    type:
      - 'null'
      - boolean
    doc: Filter insertions/deletions
    inputBinding:
      position: 101
      prefix: --filterIndels
  - id: filter_low_qual
    type:
      - 'null'
      - boolean
    doc: Filter low quality (i.e not PASS) variant
    inputBinding:
      position: 101
      prefix: --filterLowQual
  - id: filter_non_coding
    type:
      - 'null'
      - boolean
    doc: Filter Non-coding variants
    inputBinding:
      position: 101
      prefix: --filterNonCoding
  - id: filter_non_syn
    type:
      - 'null'
      - boolean
    doc: Filter Non-Synonymous variants
    inputBinding:
      position: 101
      prefix: --filterNonSyn
  - id: filter_polym
    type:
      - 'null'
      - boolean
    doc: Filter polymorphism variants in genome databases. See --maf
    inputBinding:
      position: 101
      prefix: --filterPolym
  - id: filter_recurrence
    type:
      - 'null'
      - boolean
    doc: Filter on recurrence values
    inputBinding:
      position: 101
      prefix: --filterRecurrence
  - id: filter_splice
    type:
      - 'null'
      - boolean
    doc: Filter Splice variants
    inputBinding:
      position: 101
      prefix: --filterSplice
  - id: filter_syn
    type:
      - 'null'
      - boolean
    doc: Filter Synonymous variants
    inputBinding:
      position: 101
      prefix: --filterSyn
  - id: maf
    type:
      - 'null'
      - float
    doc: Filter variants with MAF > maf
    inputBinding:
      position: 101
      prefix: --maf
  - id: min_alt_depth
    type:
      - 'null'
      - int
    doc: Filter variants with alternative allele depth < minAltDepth
    inputBinding:
      position: 101
      prefix: --minAltDepth
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Filter variants with depth < minDepth
    inputBinding:
      position: 101
      prefix: --minDepth
  - id: polym_db
    type:
      - 'null'
      - string
    doc: Databases used for polymorphisms detection (comma separated)
    inputBinding:
      position: 101
      prefix: --polymDb
  - id: sample
    type:
      - 'null'
      - string
    doc: Specify the sample ID to focus on
    inputBinding:
      position: 101
      prefix: --sample
  - id: vaf
    type:
      - 'null'
      - float
    doc: Filter variants with Allelic Ratio < vaf
    inputBinding:
      position: 101
      prefix: --vaf
  - id: var_config
    type: string
    doc: Variant calling config file
    inputBinding:
      position: 101
      prefix: --varConfig
  - id: vcf
    type: File
    doc: Input file (.vcf, .vcf.gz, .bcf, .bcf.gz)
    inputBinding:
      position: 101
      prefix: --vcf
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Active verbose mode
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tmb:1.5.0--pyhdfd78af_1
stdout: tmb_pyTMB.py.out
