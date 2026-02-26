cwlVersion: v1.2
class: CommandLineTool
baseCommand: mason_variator
label: mason_mason_variator
doc: "Either simulate variation and write out the result to VCF and optionally FASTA
  files.\n\nTool homepage: https://www.seqan.de/apps/mason.html"
inputs:
  - id: haplotype_name_sep
    type:
      - 'null'
      - string
    doc: Haplotype name separator in output FASTA.
    default: /
    inputBinding:
      position: 101
      prefix: --haplotype-name-sep
  - id: haplotype_sep
    type:
      - 'null'
      - string
    doc: The separator between the chromosome and the haplotype name in the 
      output FASTA file.
    default: /
    inputBinding:
      position: 101
      prefix: --haplotype-sep
  - id: in_reference
    type: File
    doc: 'FASTA file with reference. Valid filetypes are: .fasta and .fa.'
    inputBinding:
      position: 101
      prefix: --in-reference
  - id: in_variant_tsv
    type:
      - 'null'
      - File
    doc: 'TSV file with variants to simulate. See Section on the Variant TSV File
      below. Valid filetypes are: .txt and .tsv.'
    inputBinding:
      position: 101
      prefix: --in-variant-tsv
  - id: max_small_indel_size
    type:
      - 'null'
      - int
    doc: Maximal small indel size to simulate. In range [0..inf].
    default: 6
    inputBinding:
      position: 101
      prefix: --max-small-indel-size
  - id: max_sv_size
    type:
      - 'null'
      - int
    doc: Maximal SV size to simulate. In range [0..inf].
    default: 1000
    inputBinding:
      position: 101
      prefix: --max-sv-size
  - id: meth_cg_mu
    type:
      - 'null'
      - float
    doc: Median of beta distribution for methylation level of CpG loci. In range
      [0..1].
    default: 0.6
    inputBinding:
      position: 101
      prefix: --meth-cg-mu
  - id: meth_cg_sigma
    type:
      - 'null'
      - float
    doc: Standard deviation of beta distribution for methylation level of CpG 
      loci. In range [0..1].
    default: 0.03
    inputBinding:
      position: 101
      prefix: --meth-cg-sigma
  - id: meth_chg_mu
    type:
      - 'null'
      - float
    doc: Median of beta distribution for methylation level of CHG loci. In range
      [0..1].
    default: 0.08
    inputBinding:
      position: 101
      prefix: --meth-chg-mu
  - id: meth_chg_sigma
    type:
      - 'null'
      - float
    doc: Standard deviation of beta distribution for methylation level of CHG 
      loci. In range [0..1].
    default: 0.008
    inputBinding:
      position: 101
      prefix: --meth-chg-sigma
  - id: meth_chh_mu
    type:
      - 'null'
      - float
    doc: Median of beta distribution for methylation level of CHH loci. In range
      [0..1].
    default: 0.05
    inputBinding:
      position: 101
      prefix: --meth-chh-mu
  - id: meth_chh_sigma
    type:
      - 'null'
      - float
    doc: Standard deviation of beta distribution for methylation level of CHH 
      loci. In range [0..1].
    default: 0.005
    inputBinding:
      position: 101
      prefix: --meth-chh-sigma
  - id: meth_fasta_in
    type:
      - 'null'
      - File
    doc: 'Path to load original methylation levels from. Methylation levels are simulated
      if omitted. Valid filetypes are: .sam[.*], .raw[.*], .gbk[.*], .frn[.*], .fq[.*],
      .fna[.*], .ffn[.*], .fastq[.*], .fasta[.*], .fas[.*], .faa[.*], .fa[.*], .embl[.*],
      and .bam, where * is any of the following extensions: gz, bz2, and bgzf for
      transparent (de)compression.'
    inputBinding:
      position: 101
      prefix: --meth-fasta-in
  - id: methylation_levels
    type:
      - 'null'
      - boolean
    doc: Enable methylation level simulation.
    inputBinding:
      position: 101
      prefix: --methylation-levels
  - id: min_small_indel_size
    type:
      - 'null'
      - int
    doc: Minimal small indel size to simulate. In range [0..inf].
    default: 1
    inputBinding:
      position: 101
      prefix: --min-small-indel-size
  - id: min_sv_size
    type:
      - 'null'
      - int
    doc: Minimal SV size to simulate. In range [0..inf].
    default: 50
    inputBinding:
      position: 101
      prefix: --min-sv-size
  - id: no_gen_var_ids
    type:
      - 'null'
      - boolean
    doc: Do not generate variant ids.
    inputBinding:
      position: 101
      prefix: --no-gen-var-ids
  - id: num_haplotypes
    type:
      - 'null'
      - int
    doc: The number of haplotypes to simulate. In range [1..inf].
    default: 1
    inputBinding:
      position: 101
      prefix: --num-haplotypes
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Set verbosity to a minimum.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: seed
    type:
      - 'null'
      - string
    doc: The seed to use for the random number generator.
    default: '0'
    inputBinding:
      position: 101
      prefix: --seed
  - id: small_indel_rate
    type:
      - 'null'
      - float
    doc: Small indel rate. In range [0.0..1.0].
    default: 1e-06
    inputBinding:
      position: 101
      prefix: --small-indel-rate
  - id: snp_rate
    type:
      - 'null'
      - float
    doc: Per-base SNP rate. In range [0.0..1.0].
    default: 0.0001
    inputBinding:
      position: 101
      prefix: --snp-rate
  - id: sv_duplication_rate
    type:
      - 'null'
      - float
    doc: Per-base SNP rate. In range [0.0..1.0].
    default: 1e-07
    inputBinding:
      position: 101
      prefix: --sv-duplication-rate
  - id: sv_indel_rate
    type:
      - 'null'
      - float
    doc: Per-base SNP rate. In range [0.0..1.0].
    default: 1e-07
    inputBinding:
      position: 101
      prefix: --sv-indel-rate
  - id: sv_inversion_rate
    type:
      - 'null'
      - float
    doc: Per-base SNP rate. In range [0.0..1.0].
    default: 1e-07
    inputBinding:
      position: 101
      prefix: --sv-inversion-rate
  - id: sv_translocation_rate
    type:
      - 'null'
      - float
    doc: Per-base SNP rate. In range [0.0..1.0].
    default: 1e-07
    inputBinding:
      position: 101
      prefix: --sv-translocation-rate
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: version_check
    type:
      - 'null'
      - boolean
    doc: Turn this option off to disable version update notifications of the 
      application. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO.
    default: true
    inputBinding:
      position: 101
      prefix: --version-check
  - id: very_verbose
    type:
      - 'null'
      - boolean
    doc: Enable very verbose output.
    inputBinding:
      position: 101
      prefix: --very-verbose
outputs:
  - id: out_vcf
    type: File
    doc: 'VCF file to write simulated variations to. Valid filetype is: .vcf.'
    outputBinding:
      glob: $(inputs.out_vcf)
  - id: out_fasta
    type:
      - 'null'
      - File
    doc: 'FASTA file to write simulated haplotypes to. Valid filetypes are: .fasta
      and .fa.'
    outputBinding:
      glob: $(inputs.out_fasta)
  - id: out_breakpoints
    type:
      - 'null'
      - File
    doc: 'TSV file to write breakpoints in variants to. Valid filetypes are: .txt
      and .tsv.'
    outputBinding:
      glob: $(inputs.out_breakpoints)
  - id: meth_fasta_out
    type:
      - 'null'
      - File
    doc: 'Path to write methylation levels to as FASTA. Only written if -of/--out-fasta
      is given. Valid filetypes are: .sam[.*], .raw[.*], .frn[.*], .fq[.*], .fna[.*],
      .ffn[.*], .fastq[.*], .fasta[.*], .fas[.*], .faa[.*], .fa[.*], and .bam, where
      * is any of the following extensions: gz, bz2, and bgzf for transparent (de)compression.'
    outputBinding:
      glob: $(inputs.meth_fasta_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mason:2.0.13--h7f3286b_0
