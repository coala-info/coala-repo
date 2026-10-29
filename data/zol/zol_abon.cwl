cwlVersion: v1.2
class: CommandLineTool
baseCommand: abon
label: zol_abon
doc: |-
  abon assesses the conservation of the biosynthetic gene clusters of a sample genome across target genomes using fai.

  Tool homepage: https://github.com/Kalan-Lab/zol
inputs:
  - id: antismash_results
    type: ['null', Directory]
    doc: 'Path to antiSMASH BGC prediction results directory for a single sample/genome.'
    inputBinding:
      position: 1
      prefix: --antismash-results
  - id: gecco_results
    type: ['null', Directory]
    doc: 'Path to GECCO BGC prediction results directory for a single sample/genome.'
    inputBinding:
      position: 1
      prefix: --gecco-results
  - id: target_genomes_db
    type: Directory
    doc: 'prepTG database directory for target genomes of interest.'
    inputBinding:
      position: 1
      prefix: --target-genomes-db
  - id: fai_options
    type: ['null', string]
    doc: 'Provide fai options to run. Should be surrounded by quotes. [Default is ''-skpv -kpm 0.75 -kpe 1e-10 -e 1e-10 -m 0.5 -dm -sct 0.6'']'
    inputBinding:
      position: 1
      prefix: --fai-options
  - id: use_simple_blastp
    type: ['null', boolean]
    doc: 'Use a simple DIAMOND BLASTp search with no requirement for co-localization of hits.'
    inputBinding:
      position: 1
      prefix: --use-simple-blastp
  - id: simple_blastp_identity_cutoff
    type: ['null', float]
    doc: 'If simple BLASTp mode requested: cutoff for identity between query proteins and matches in target genomes [Default is 40.0].'
    inputBinding:
      position: 1
      prefix: --simple-blastp-identity-cutoff
  - id: simple_blastp_coverage_cutoff
    type: ['null', float]
    doc: 'If simple BLASTp mode requested: cutoff for coverage between query proteins and matches in target genomes [Default is 70.0].'
    inputBinding:
      position: 1
      prefix: --simple-blastp-coverage-cutoff
  - id: simple_blastp_evalue_cutoff
    type: ['null', float]
    doc: 'If simple BLASTp mode requested: cutoff for E-value between query proteins and matches in target genomes [Default is 1e-5].'
    inputBinding:
      position: 1
      prefix: --simple-blastp-evalue-cutoff
  - id: simple_blastp_key_proteins_proportion_cutoff
    type: ['null', float]
    doc: 'If simple BLASTp mode requested: cutoff for proportion of key proteins needed to consider a BGC as present in a target genome [Default is 0.75].'
    inputBinding:
      position: 1
      prefix: --simple-blastp-key-proteins-proportion-cutoff
  - id: simple_blastp_sensitivity_mode
    type: ['null', string]
    doc: 'Sensitivity mode for DIAMOND BLASTp. [Default is "very-sensititve"].'
    inputBinding:
      position: 1
      prefix: --simple-blastp-sensitivity-mode
  - id: outdir
    type: string
    doc: 'See the tool help.'
    inputBinding:
      position: 1
      prefix: --outdir
  - id: threads
    type: ['null', int]
    doc: 'The number of threads to use [Default is 1].'
    inputBinding:
      position: 1
      prefix: --threads
outputs:
  - id: output_directory
    type: ['null', Directory]
    doc: Output directory
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zol:1.6.17--py312hf731ba3_1
