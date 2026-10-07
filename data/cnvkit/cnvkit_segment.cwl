cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvkit.py
  - segment
label: cnvkit_segment
doc: "Infer copy number segments from the given coverage table.\n\nTool homepage: https://github.com/etal/cnvkit"
inputs:
  - id: filename
    type: File
    doc: "Bin-level log2 ratios (.cnr file), as produced by 'fix'."
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: "Output table file name (CNR-like table of segments, .cns)."
    inputBinding:
      position: 101
      prefix: --output
  - id: dataframe
    type:
      - 'null'
      - string
    doc: "File name to save the raw R dataframe emitted by CBS or Fused Lasso. (Useful for debugging.)"
    inputBinding:
      position: 101
      prefix: --dataframe
  - id: method
    type:
      - 'null'
      - string
    doc: "Segmentation method (see docs), or 'none' for chromosome arm-level averages as segments. [Default: cbs] (choices: cbs, flasso, haar, none, hmm, hmm-tumor, hmm-germline)"
    inputBinding:
      position: 101
      prefix: --method
  - id: threshold
    type:
      - 'null'
      - float
    doc: "Significance threshold (p-value or FDR, depending on method) to accept breakpoints during segmentation. For HMM methods, this is the smoothing window size."
    inputBinding:
      position: 101
      prefix: --threshold
  - id: drop_low_coverage
    type:
      - 'null'
      - boolean
    doc: "Drop very-low-coverage bins before segmentation to avoid false-positive deletions in poor-quality tumor samples."
    inputBinding:
      position: 101
      prefix: --drop-low-coverage
  - id: drop_outliers
    type:
      - 'null'
      - float
    doc: "Drop outlier bins more than this many multiples of the 95th quantile away from the average within a rolling window. Set to 0 for no outlier filtering. [Default: %(default)g]"
    inputBinding:
      position: 101
      prefix: --drop-outliers
  - id: rscript_path
    type:
      - 'null'
      - string
    doc: "Path to the Rscript executable to use for running R code. Use this option to specify a non-default R installation. [Default: Rscript]"
    inputBinding:
      position: 101
      prefix: --rscript-path
  - id: processes
    type:
      - 'null'
      - int
    doc: "Number of subprocesses to segment in parallel. Give 0 or a negative value to use the maximum number of available CPUs. [Default: use 1 process]"
    inputBinding:
      position: 101
      prefix: --processes
  - id: smooth_cbs
    type:
      - 'null'
      - boolean
    doc: "Perform an additional smoothing before CBS segmentation, which in some cases may increase the sensitivity. Used only for CBS method."
    inputBinding:
      position: 101
      prefix: --smooth-cbs
  - id: diploid_parx_genome
    type:
      - 'null'
      - string
    doc: "Considers the given human genome's PAR of chromosome X as autosomal. Example: 'grch38'"
    inputBinding:
      position: 101
      prefix: --diploid-parx-genome
  - id: vcf
    type:
      - 'null'
      - File
    doc: "VCF file name containing variants for segmentation by allele frequencies."
    inputBinding:
      position: 101
      prefix: --vcf
  - id: sample_id
    type:
      - 'null'
      - string
    doc: "Specify the name of the sample in the VCF (-v/--vcf) to use for b-allele frequency extraction and as the default plot title."
    inputBinding:
      position: 101
      prefix: --sample-id
  - id: normal_id
    type:
      - 'null'
      - string
    doc: "Corresponding normal sample ID in the input VCF (-v/--vcf). This sample is used to select only germline SNVs to plot b-allele frequencies."
    inputBinding:
      position: 101
      prefix: --normal-id
  - id: min_variant_depth
    type:
      - 'null'
      - int
    doc: "Minimum read depth for a SNV to be displayed in the b-allele frequency plot. [Default: 20]"
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
    doc: "Output table file name (CNR-like table of segments, .cns)."
    outputBinding:
      glob: $(inputs.output)
  - id: dataframe_out
    type:
      - 'null'
      - File
    doc: "File name to save the raw R dataframe emitted by CBS or Fused Lasso. (Useful for debugging.)"
    outputBinding:
      glob: $(inputs.dataframe)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
