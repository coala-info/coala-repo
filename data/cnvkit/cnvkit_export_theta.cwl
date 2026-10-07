cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvkit.py
  - export
  - theta
label: cnvkit_export_theta
doc: "Convert segments to THetA2 input file format (*.input).\n\nTool homepage: https://github.com/etal/cnvkit"
inputs:
  - id: tumor_segment
    type: File
    doc: "Tumor-sample segmentation file from CNVkit (.cns)."
    inputBinding:
      position: 1
  - id: reference
    type:
      - 'null'
      - File
    doc: "Reference copy number profile (.cnn), or normal-sample bin-level log2 copy ratios (.cnr). Use if the tumor_segment input file does not contain a \"weight\" column."
    inputBinding:
      position: 101
      prefix: --reference
  - id: output
    type: string
    doc: "Output file name."
    inputBinding:
      position: 101
      prefix: --output
  - id: vcf
    type:
      - 'null'
      - File
    doc: "VCF file containing SNVs observed in both the tumor and normal samples. Tumor sample ID should match the `tumor_segment` filename or be specified with -i/--sample-id."
    inputBinding:
      position: 101
      prefix: --vcf
  - id: sample_id
    type:
      - 'null'
      - string
    doc: "Specify the name of the tumor sample in the VCF (given with -v/--vcf). [Default: taken the tumor_segment file name]"
    inputBinding:
      position: 101
      prefix: --sample-id
  - id: normal_id
    type:
      - 'null'
      - string
    doc: "Corresponding normal sample ID in the input VCF."
    inputBinding:
      position: 101
      prefix: --normal-id
  - id: min_variant_depth
    type:
      - 'null'
      - int
    doc: "Minimum read depth for a SNP in the VCF to be counted. [Default: 20]"
    inputBinding:
      position: 101
      prefix: --min-variant-depth
  - id: zygosity_freq
    type:
      - 'null'
      - float
    doc: "Ignore VCF's genotypes (GT field) and instead infer zygosity from allele frequencies. [Default if used without a number: %(const)s]"
    inputBinding:
      position: 101
      prefix: --zygosity-freq
outputs:
  - id: output_out
    type:
      - 'null'
      - File
    doc: "Output file name."
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
