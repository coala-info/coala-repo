cwlVersion: v1.2
class: CommandLineTool
baseCommand: iobrpy deside
label: iobrpy_deside
doc: "Predicts cell fractions from gene expression data using a DeSide model.\n\n\
  Tool homepage: https://github.com/IOBR/IOBRpy"
inputs:
  - id: add_cell_type
    type:
      - 'null'
      - boolean
    doc: Append predicted cell type labels
    inputBinding:
      position: 101
      prefix: --add_cell_type
  - id: exp_type
    type:
      - 'null'
      - string
    doc: 'Input format: TPM (log2 processed), log_space (log2 TPM+1), or linear (TPM/counts)'
    inputBinding:
      position: 101
      prefix: --exp_type
  - id: gmt
    type:
      - 'null'
      - type: array
        items: File
    doc: Optional GMT files for pathway masking
    inputBinding:
      position: 101
      prefix: --gmt
  - id: input
    type: File
    doc: Expression file (CSV/TSV) with rows=genes and columns=samples
    inputBinding:
      position: 101
      prefix: --input
  - id: method_adding_pathway
    type:
      - 'null'
      - string
    doc: 'How to integrate pathway profiles: add_to_end or convert'
    inputBinding:
      position: 101
      prefix: --method_adding_pathway
  - id: model_dir
    type: Directory
    doc: Path to DeSide_model directory
    inputBinding:
      position: 101
      prefix: --model_dir
  - id: one_minus_alpha
    type:
      - 'null'
      - boolean
    doc: Use 1−α transformation for all cell types
    inputBinding:
      position: 101
      prefix: --one_minus_alpha
  - id: print_info
    type:
      - 'null'
      - boolean
    doc: Show detailed logs during prediction
    inputBinding:
      position: 101
      prefix: --print_info
  - id: result_dir
    type:
      - 'null'
      - Directory
    doc: Directory to save result plots
    inputBinding:
      position: 101
      prefix: --result_dir
  - id: scaling_by_constant
    type:
      - 'null'
      - boolean
    doc: Enable division-by-constant scaling
    inputBinding:
      position: 101
      prefix: --scaling_by_constant
  - id: scaling_by_sample
    type:
      - 'null'
      - boolean
    doc: Enable per-sample min–max scaling
    inputBinding:
      position: 101
      prefix: --scaling_by_sample
  - id: transpose
    type:
      - 'null'
      - boolean
    doc: Transpose input so that rows=samples and columns=genes
    inputBinding:
      position: 101
      prefix: --transpose
outputs:
  - id: output
    type: File
    doc: Output CSV for predicted cell fractions
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
