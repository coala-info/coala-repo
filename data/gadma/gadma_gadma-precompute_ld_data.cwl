cwlVersion: v1.2
class: CommandLineTool
baseCommand: gadma-precompute_ld_data
label: gadma_gadma-precompute_ld_data
doc: "GADMA module for data preprocessing with momentsLD engine\n\nTool homepage: https://github.com/ctlab/GADMA"
inputs:
  - id: params_file
    type:
      - 'null'
      - File
    doc: 'Parameters file'
    inputBinding:
      position: 1
      prefix: --params
  - id: extra_params_file
    type:
      - 'null'
      - File
    doc: 'Extra parameters file'
    inputBinding:
      position: 1
      prefix: --extra
  - id: input_data
    type:
      - 'null'
      - type: array
        items: File
    doc: input data (a VCF file followed by its popmap file)
    inputBinding:
      position: 1
      prefix: --input
      itemSeparator: ','
  - id: output_path
    type:
      - 'null'
      - string
    doc: 'output directory.'
    inputBinding:
      position: 1
      prefix: --output
  - id: resume_dir
    type:
      - 'null'
      - Directory
    doc: 'resume another launch from this directory.'
    inputBinding:
      position: 1
      prefix: --resume
  - id: only_models
    type:
      - 'null'
      - boolean
    doc: 'flag to take models only from another launch (--resume option).'
    inputBinding:
      position: 1
      prefix: --only_models
  - id: test
    type:
      - 'null'
      - boolean
    doc: 'run test case.'
    inputBinding:
      position: 1
      prefix: --test
outputs:
  - id: preprocessed_data
    type: File
    doc: Pickled region statistics and bootstrap data (preprocessed_data.bp)
    outputBinding:
      glob: preprocessed_data.bp
  - id: updated_params_file
    type:
      - 'null'
      - File
    doc: The params file with the added line `preprocessed_data`
    outputBinding:
      glob: $(inputs.params_file.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$((inputs.input_data || []).concat(inputs.params_file ? [inputs.params_file] : [], inputs.extra_params_file ? [inputs.extra_params_file] : []).map(function(f) { return {entryname: f.basename, entry: f, writable: true}; }))"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gadma:2.0.3--pyhdfd78af_0
