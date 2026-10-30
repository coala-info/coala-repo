cwlVersion: v1.2
class: CommandLineTool
baseCommand: salt
label: lsabgc_salt
doc: "Support assessment for lateral transfer of gene clusters found by fai (experimental).\n\nTool homepage: https://github.com/Kalan-Lab/zol"
inputs:
  - id: fai_results_dir
    type: Directory
    doc: "Path to antiSMASH BGC prediction results directory for a single sample/genome."
    inputBinding:
      position: 1
      prefix: --fai-results-dir
      valueFrom: $(self.path + "/")
  - id: target_genomes_db
    type: Directory
    doc: "Result directory from running prepTG for target genomes of interest."
    inputBinding:
      position: 1
      prefix: --target-genomes-db
      valueFrom: $(self.path + "/")
  - id: outdir
    type: string
    doc: "Output directory for salt analysis. The directory is created in the working directory."
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
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lsabgc:1.1.10--pyhdfd78af_0
