cwlVersion: v1.2
class: CommandLineTool
baseCommand: salt
label: zol_salt
doc: |-
  salt (Support Assessment for Lateral Transfer) assesses support for horizontal versus vertical evolution of a gene cluster across genomes searched with fai.

  Tool homepage: https://github.com/Kalan-Lab/zol
inputs:
  - id: fai_results_dir
    type: Directory
    doc: 'Path to antiSMASH BGC prediction results directory for a single sample/genome.'
    inputBinding:
      position: 1
      prefix: --fai-results-dir
      valueFrom: $(self.basename)/
  - id: target_genomes_db
    type: Directory
    doc: 'Result directory from running prepTG for target genomes of interest.'
    inputBinding:
      position: 1
      prefix: --target-genomes-db
      valueFrom: $(self.basename)/
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
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.fai_results_dir.basename)
        entry: $(inputs.fai_results_dir)
      - entryname: $(inputs.target_genomes_db.basename)
        entry: $(inputs.target_genomes_db)
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zol:1.6.17--py312hf731ba3_1
    dockerOutputDirectory: /zol_work
