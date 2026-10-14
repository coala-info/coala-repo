cwlVersion: v1.2
class: CommandLineTool
baseCommand: create_phylowgs_inputs.py
label: phylowgs_create_phylowgs_inputs.py
doc: "Create ssm_data.txt and cnv_data.txt input files for PhyloWGS from VCF and
  CNV data.\n\nTool homepage: https://github.com/morrislab/phylowgs"
requirements:
  - class: ShellCommandRequirement
  - class: InlineJavascriptRequirement
inputs:
  - id: vcf_files
    type: File[]
    doc: Path to VCF file for each sample. Passed as <sample>=<VCF path>, in the
      same order as sample_names.
    inputBinding:
      position: 100
      valueFrom: |
        ${ return self.map(function(f, i) { return inputs.sample_names[i] + "=" + f.path; }); }
  - id: sample_names
    type: string[]
    doc: Sample name for each VCF file (same order as vcf_files).
  - id: vcf_types
    type:
      type: array
      items: string
      inputBinding:
        prefix: --vcf-type
    doc: "Type of VCF file for each sample, specified as <sample>=<vcf_type>. Valid
      VCF types are strelka, mutect_pcawg, dkfz, muse, vardict, mutect_smchet,
      mutect_tcga, sanger, pcawg_consensus."
    inputBinding:
      position: 1
  - id: cnv_files
    type:
      - 'null'
      - File[]
    doc: CNV file created with parse_cnvs.py for each sample (same order as
      sample_names).
  - id: error_rate
    type: ['null', float]
    doc: Expected error rate of sequencing platform
    inputBinding:
      position: 2
      prefix: --error-rate
  - id: missing_variant_confidence
    type: ['null', float]
    doc: Confidence in range [0, 1] that SSMs missing from a sample are indeed
      not present in that sample
    inputBinding:
      position: 2
      prefix: --missing-variant-confidence
  - id: sample_size
    type: ['null', int]
    doc: Subsample SSMs to reduce PhyloWGS runtime
    inputBinding:
      position: 2
      prefix: --sample-size
  - id: priority_ssm_filename
    type: ['null', File]
    doc: File containing newline-separated list of SSMs in "<chr>_<locus>"
      format to prioritize for inclusion
    inputBinding:
      position: 2
      prefix: --priority-ssms
  - id: only_priority
    type: ['null', boolean]
    doc: Only sample variants provided on priority list
    inputBinding:
      position: 2
      prefix: --only-priority
  - id: regions
    type:
      - 'null'
      - type: enum
        symbols: [normal_cn, normal_and_abnormal_cn, all]
    doc: Which regions to use variants from
    inputBinding:
      position: 2
      prefix: --regions
  - id: output_cnvs
    type: ['null', string]
    default: cnv_data.txt
    doc: Output destination for CNVs
    inputBinding:
      position: 2
      prefix: --output-cnvs
  - id: output_variants
    type: ['null', string]
    default: ssm_data.txt
    doc: Output destination for variants
    inputBinding:
      position: 2
      prefix: --output-variants
  - id: output_params
    type: ['null', string]
    default: params.json
    doc: Output destination for run parameters
    inputBinding:
      position: 2
      prefix: --output-params
  - id: tumor_sample
    type: ['null', string]
    doc: Name of the tumor sample in the input VCF file. Defaults to last sample
      if not specified.
    inputBinding:
      position: 2
      prefix: --tumor-sample
  - id: muse_tier
    type: ['null', int]
    doc: Maximum MuSE tier to include
    inputBinding:
      position: 2
      prefix: --muse-tier
  - id: nonsubsampled_variants
    type: ['null', string]
    doc: If subsampling, write nonsubsampled variants to separate file, in
      addition to subsampled variants
    inputBinding:
      position: 2
      prefix: --nonsubsampled-variants
  - id: nonsubsampled_variants_cnvs
    type: ['null', string]
    doc: If subsampling, write CNVs for nonsubsampled variants to separate file
    inputBinding:
      position: 2
      prefix: --nonsubsampled-variants-cnvs
  - id: sex
    type:
      - 'null'
      - type: enum
        symbols: [auto, male, female]
    doc: Sex of patient. Used to adjust expected variant frequencies on sex
      chromosomes. If auto, patient is set to male if any variants are provided
      on the Y chromosome, and female otherwise.
    inputBinding:
      position: 2
      prefix: --sex
  - id: het_snp_rate
    type: ['null', float]
    doc: Average number of heterozygous SNPs per base used to call copy number.
      This determines how heavily we weight somatic CNAs relative to SNVs.
    inputBinding:
      position: 2
      prefix: --het-snp-rate
  - id: verbose
    type: ['null', boolean]
    doc: Verbose logging
    inputBinding:
      position: 2
      prefix: --verbose
arguments:
  - position: 3
    shellQuote: false
    valueFrom: |
      ${ if (!inputs.cnv_files) { return ""; }
         return inputs.cnv_files.map(function(f, i) { return "--cnvs '" + inputs.sample_names[i] + "=" + f.path + "'"; }).join(" "); }
outputs:
  - id: ssm_data
    type: File
    doc: Variants (SSM) table for PhyloWGS
    outputBinding:
      glob: $(inputs.output_variants)
  - id: cnv_data
    type: File
    doc: CNV table for PhyloWGS
    outputBinding:
      glob: $(inputs.output_cnvs)
  - id: params
    type: File
    doc: Run parameters (JSON)
    outputBinding:
      glob: $(inputs.output_params)
  - id: nonsubsampled_variants_out
    type: ['null', File]
    doc: Nonsubsampled variants (only when subsampling)
    outputBinding:
      glob: $(inputs.nonsubsampled_variants)
  - id: nonsubsampled_variants_cnvs_out
    type: ['null', File]
    doc: CNVs for nonsubsampled variants (only when subsampling)
    outputBinding:
      glob: $(inputs.nonsubsampled_variants_cnvs)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylowgs:20181105--py27ha7db03b_3
