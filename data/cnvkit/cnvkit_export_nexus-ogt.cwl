cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvkit.py
  - export
  - nexus-ogt
label: cnvkit_export_nexus-ogt
doc: "Convert log2 ratios and b-allele freqs to Nexus \"Custom-OGT\" format.\n\nTool homepage: https://github.com/etal/cnvkit"
inputs:
  - id: filename
    type: File
    doc: "Log2 copy ratio data file (*.cnr), the output of the 'fix' sub-command."
    inputBinding:
      position: 1
  - id: vcf
    type: File
    doc: "VCF of SNVs for the same sample, to calculate b-allele frequencies."
    inputBinding:
      position: 2
  - id: sample_id
    type:
      - 'null'
      - string
    doc: "Specify the name of the sample in the VCF to use to extract b-allele frequencies."
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
    doc: "Minimum read depth for a SNV to be included in the b-allele frequency calculation. [Default: 20]"
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
  - id: min_weight
    type:
      - 'null'
      - float
    doc: "Minimum weight (between 0 and 1) for a bin to be included in the output. [Default: 0.0]"
    inputBinding:
      position: 101
      prefix: --min-weight
  - id: output
    type: string
    doc: "Output file name."
    inputBinding:
      position: 101
      prefix: --output
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
