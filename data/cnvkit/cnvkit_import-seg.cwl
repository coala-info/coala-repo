cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvkit.py
  - import-seg
label: cnvkit_import-seg
doc: "Convert a SEG file to CNVkit .cns files.\n\nTool homepage: https://github.com/etal/cnvkit"
inputs:
  - id: segfile
    type: File
    doc: "Input file in SEG format. May contain multiple samples."
    inputBinding:
      position: 1
  - id: chromosomes
    type:
      - 'null'
      - string
    doc: "Mapping of chromosome indexes to names. Syntax: \"from1:to1,from2:to2\". Or use \"human\" for the preset: \"23:X,24:Y,25:M\"."
    inputBinding:
      position: 101
      prefix: --chromosomes
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Prefix to add to chromosome names (e.g 'chr' to rename '8' in the SEG file to 'chr8' in the output)."
    inputBinding:
      position: 101
      prefix: --prefix
  - id: from_log10
    type:
      - 'null'
      - boolean
    doc: "Convert base-10 logarithm values in the input to base-2 logs."
    inputBinding:
      position: 101
      prefix: --from-log10
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
