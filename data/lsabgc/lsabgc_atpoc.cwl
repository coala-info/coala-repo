cwlVersion: v1.2
class: CommandLineTool
baseCommand: atpoc
label: lsabgc_atpoc
doc: "Automated analysis of conservation and novelty of the prophages of one sample, using VIBRANT, PhiSpy or geNomad results and a prepTG database.\n\nTool homepage: https://github.com/Kalan-Lab/zol"
inputs:
  - id: sample_genome
    type: File
    doc: "Path to sample genome in GenBank or FASTA format."
    inputBinding:
      position: 1
      prefix: --sample-genome
  - id: vibrant_results
    type:
      - 'null'
      - Directory
    doc: "Path to VIBRANT results directory for a single sample/genome."
    inputBinding:
      position: 1
      prefix: --vibrant-results
  - id: phispy_results
    type:
      - 'null'
      - Directory
    doc: "Path to PhiSpy results directory for a single sample/genome."
    inputBinding:
      position: 1
      prefix: --phispy-results
  - id: genomad_results
    type:
      - 'null'
      - Directory
    doc: "Path to GeNomad results directory for a single sample/genome."
    inputBinding:
      position: 1
      prefix: --genomad-results
  - id: target_genomes_db
    type: Directory
    doc: "prepTG database directory for target genomes of interest."
    inputBinding:
      position: 1
      prefix: --target-genomes-db
      valueFrom: $(self.path + "/")
  - id: use_pyrodigal
    type:
      - 'null'
      - boolean
    doc: "Use default pyrodigal instead of prodigal-gv to call genes in phage regions to use as queries in fai/simple-blast. This is perhaps preferable if target genomes db was created with default pyrodigal/prodigal."
    inputBinding:
      position: 1
      prefix: --use-pyrodigal
  - id: fai_options
    type:
      - 'null'
      - string
    doc: "Provide fai options to run. Should be surrounded by quotes. [Default is '-skpv -e 1e-10 -m 0.5 -dm -sct 0.4']."
    inputBinding:
      position: 1
      prefix: --fai-options=
      separate: false
  - id: use_simple_blastp
    type:
      - 'null'
      - boolean
    doc: "Use a simple DIAMOND BLASTp search with no requirement for co-localization of hits."
    inputBinding:
      position: 1
      prefix: --use-simple-blastp
  - id: simple_blastp_identity_cutoff
    type:
      - 'null'
      - float
    doc: "If simple BLASTp mode requested: cutoff for identity between query proteins and matches in target genomes [Default is 40.0]."
    inputBinding:
      position: 1
      prefix: --simple-blastp-identity-cutoff
  - id: simple_blastp_coverage_cutoff
    type:
      - 'null'
      - float
    doc: "If simple BLASTp mode requested: cutoff for coverage between query proteins and matches in target genomes [Default is 70.0]."
    inputBinding:
      position: 1
      prefix: --simple-blastp-coverage-cutoff
  - id: simple_blastp_evalue_cutoff
    type:
      - 'null'
      - float
    doc: "If simple BLASTp mode requested: cutoff for E-value between query proteins and matches in target genomes [Default is 1e-5]."
    inputBinding:
      position: 1
      prefix: --simple-blastp-evalue-cutoff
  - id: simple_blastp_sensitivity_mode
    type:
      - 'null'
      - string
    doc: "Sensitivity mode for DIAMOND BLASTp. [Default is 'very-sensititve']."
    inputBinding:
      position: 1
      prefix: --simple-blastp-sensitivity-mode
  - id: outdir
    type: string
    doc: "Output directory. The directory is created in the working directory."
    inputBinding:
      position: 1
      prefix: --outdir
  - id: threads
    type:
      - 'null'
      - int
    doc: "The number of threads to use [Default is 1]."
    inputBinding:
      position: 1
      prefix: --threads
outputs:
  - id: outdir_dir
    type: Directory
    doc: Results directory written with --outdir.
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lsabgc:1.1.10--pyhdfd78af_0
