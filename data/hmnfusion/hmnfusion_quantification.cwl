cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hmnfusion
  - quantification
label: hmnfusion_quantification
doc: "Quantification of fusions using hmnfusion\n\nTool homepage: https://github.com/guillaume-gricourt/HmnFusion"
inputs:
  - id: baseclipped_count
    type:
      - 'null'
      - int
    doc: Number of base hard/soft-clipped bases to count in interval (pb)
    inputBinding:
      position: 101
      prefix: --baseclipped-count
  - id: baseclipped_interval
    type:
      - 'null'
      - int
    doc: Interval to count hard/soft-clipped bases from fusion point (pb)
    inputBinding:
      position: 101
      prefix: --baseclipped-interval
  - id: input_hmnfusion_bed
    type:
      - 'null'
      - File
    doc: Bed file
    inputBinding:
      position: 101
      prefix: --input-hmnfusion-bed
  - id: input_hmnfusion_json
    type:
      - 'null'
      - File
    doc: Output Json produced by command "extractfusion"
    inputBinding:
      position: 101
      prefix: --input-hmnfusion-json
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
  - id: region
    type:
      - 'null'
      - string
    doc: Region format <chrom>:<postion>
    inputBinding:
      position: 101
      prefix: --region
outputs:
  - id: output_hmnfusion_vcf
    type:
      - 'null'
      - File
    doc: Vcf file output
    outputBinding:
      glob: $(inputs.output_hmnfusion_vcf)
  - id: output_hmnfusion_json
    type:
      - 'null'
      - File
    doc: Json file output
    outputBinding:
      glob: $(inputs.output_hmnfusion_json)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmnfusion:1.5.1--pyh7e72e81_0
