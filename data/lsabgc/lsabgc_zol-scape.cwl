cwlVersion: v1.2
class: CommandLineTool
baseCommand: zol-scape
label: lsabgc_zol-scape
doc: "Run zol on the gene cluster families (clusters) found by BiG-SCAPE.\n\nTool homepage: https://github.com/Kalan-Lab/zol"
inputs:
  - id: big_scape_input
    type: Directory
    doc: "Path to folder which was input into BiG-SCAPE."
    inputBinding:
      position: 1
      prefix: --big-scape-input
  - id: big_scape_results
    type: Directory
    doc: "Path to BiG-SCAPE results directory - will be searched recursively for 'clustering' files."
    inputBinding:
      position: 1
      prefix: --big-scape-results
  - id: outdir
    type: string
    doc: "Output directory. The directory is created in the working directory."
    inputBinding:
      position: 1
      prefix: --outdir
  - id: zol_parameters
    type:
      - 'null'
      - string
    doc: "Parameters to pass to zol - please surround by double quotes [Default is '']."
    inputBinding:
      position: 1
      prefix: --zol-parameters=
      separate: false
  - id: print_mode
    type:
      - 'null'
      - boolean
    doc: "Print zol commands - one per line - and exit - to allow for parallelizing on an HPC using a job array."
    inputBinding:
      position: 1
      prefix: --print-mode
  - id: threads
    type:
      - 'null'
      - int
    doc: "The number of threads to use per zol job [Default is 1]."
    inputBinding:
      position: 1
      prefix: --threads
  - id: jobs
    type:
      - 'null'
      - int
    doc: "The number of parallel zol jobs to run at once [Default is 1]."
    inputBinding:
      position: 1
      prefix: --jobs
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
