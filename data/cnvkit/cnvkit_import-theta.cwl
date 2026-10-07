cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvkit.py
  - import-theta
label: cnvkit_import-theta
doc: "Convert THetA output to a BED-like, CNVkit-like tabular format. Equivalently, use the THetA results file to convert CNVkit .cns segments to integer copy number calls.\n\nTool homepage: https://github.com/etal/cnvkit"
inputs:
  - id: tumor_cns
    type: File
    doc: "tumor_cns"
    inputBinding:
      position: 1
  - id: theta_results
    type: File
    doc: "theta_results"
    inputBinding:
      position: 2
  - id: ploidy
    type:
      - 'null'
      - int
    doc: "Ploidy of normal cells. [Default: %(default)d]"
    inputBinding:
      position: 101
      prefix: --ploidy
  - id: output_dir
    type: string
    default: cnvkit_output
    doc: "Output directory name."
    inputBinding:
      position: 101
      prefix: --output-dir
outputs:
  - id: output_dir_out
    type:
      - 'null'
      - Directory
    doc: "Output directory name."
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$({class: "Directory", basename: inputs.output_dir, listing: [], writable: true})'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
