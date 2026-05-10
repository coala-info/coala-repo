cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hmnfusion
  - mmej-fusion
label: hmnfusion_mmej-fusion
doc: "Analyze MMEJ (Microhomology-Mediated End Joining) fusions from HmnFusion results\n\
  \nTool homepage: https://github.com/guillaume-gricourt/HmnFusion"
inputs:
  - id: fusion_exclude_flag
    type:
      - 'null'
      - string
    doc: Exclude fusions with fusion-flag
    inputBinding:
      position: 101
      prefix: --fusion-exclude-flag
  - id: fusion_include_flag
    type:
      - 'null'
      - string
    doc: Select fusions with fusion-flag
    inputBinding:
      position: 101
      prefix: --fusion-include-flag
  - id: input_hmnfusion_json
    type: File
    doc: HmnFusion, json file
    inputBinding:
      position: 101
      prefix: --input-hmnfusion-json
  - id: input_reference_fasta
    type: File
    doc: Reference, fasta file
    inputBinding:
      position: 101
      prefix: --input-reference-fasta
  - id: input_sample_bam
    type: File
    doc: Bam file
    inputBinding:
      position: 101
      prefix: --input-sample-bam
  - id: name
    type: string
    doc: Name of sample
    inputBinding:
      position: 101
      prefix: --name
  - id: size_to_extract
    type:
      - 'null'
      - int
    doc: Size of sequence to extract before and after the genomic coordinate 
      (even number)
    inputBinding:
      position: 101
      prefix: --size-to-extract
  - id: output_hmnfusion_json_path
    type:
      - 'null'
      - string
    inputBinding:
      position: 102
      prefix: --output-hmnfusion-json
  - id: output_hmnfusion_xlsx_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_hmnfusion_xlsx_path`
    inputBinding:
      position: 103
      prefix: --output-hmnfusion-xlsx
outputs:
  - id: output_hmnfusion_xlsx
    type: File
    doc: Excel file output
    outputBinding:
      glob: $(inputs.output_hmnfusion_xlsx_path)
  - id: output_hmnfusion_json
    type:
      - 'null'
      - File
    doc: Json file output
    outputBinding:
      glob: $(inputs.output_hmnfusion_json_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmnfusion:1.5.1--pyh7e72e81_0
