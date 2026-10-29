cwlVersion: v1.2
class: CommandLineTool
baseCommand: zol-scape
label: zol_zol-scape
doc: |-
  zol-scape runs zol for each gene cluster family identified by a BiG-SCAPE analysis.

  Tool homepage: https://github.com/Kalan-Lab/zol
inputs:
  - id: big_scape_input
    type: Directory
    doc: 'Path to folder which was input into BiG-SCAPE.'
    inputBinding:
      position: 1
      prefix: --big-scape-input
  - id: big_scape_results
    type: Directory
    doc: 'Path to BiG-SCAPE results directory - will be searched recursively for ''clustering'' files.'
    inputBinding:
      position: 1
      prefix: --big-scape-results
  - id: outdir
    type: string
    doc: 'See the tool help.'
    inputBinding:
      position: 1
      prefix: --outdir
  - id: zol_parameters
    type: ['null', string]
    doc: 'Parameters to pass to zol - please surround by double quotes [Default is '''']. parallelizing on an HPC using a job array.'
    inputBinding:
      position: 1
      prefix: --zol-parameters
  - id: threads
    type: ['null', int]
    doc: 'The number of threads to use per zol job [Default is 1].'
    inputBinding:
      position: 1
      prefix: --threads
  - id: jobs
    type: ['null', int]
    doc: 'See the tool help.'
    inputBinding:
      position: 1
      prefix: --jobs
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
