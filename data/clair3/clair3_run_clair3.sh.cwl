cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - run_clair3.sh
label: clair3_run_clair3.sh
doc: "Clair3: germline small variant caller for long and short reads (pileup and full-alignment models).\n\nTool homepage: https://github.com/HKU-BAL/Clair3"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: bam_fn
    type: File
    doc: "BAM file input. The input file must be samtools indexed."
    secondaryFiles:
      - pattern: .bai
        required: true
    inputBinding:
      position: 101
      prefix: --bam_fn=
      separate: false
  - id: ref_fn
    type: File
    doc: "FASTA reference file input. The input file must be samtools indexed."
    secondaryFiles:
      - pattern: .fai
        required: true
    inputBinding:
      position: 101
      prefix: --ref_fn=
      separate: false
  - id: model_path
    type: Directory
    doc: "The folder path containing a Clair3 model (requiring six files in the folder, including pileup.data-00000-of-00002, pileup.data-00001-of-00002 pileup.index, full_alignment.data-00000-of-00002, full_alignment.data-00001-of-00002 and full_alignment.index)."
    inputBinding:
      position: 101
      prefix: --model_path=
      separate: false
  - id: threads
    type: int
    doc: "Max #threads to be used. The full genome will be divided into small chunks for parallel processing. Each chunk will use 4 threads. The #chunks being processed simultaneously is ceil(#threads/4)*3. 3 is the overloading factor."
    inputBinding:
      position: 101
      prefix: --threads=
      separate: false
  - id: platform
    type: string
    doc: "Select the sequencing platform of the input. Possible options: {ont,hifi,ilmn}."
    inputBinding:
      position: 101
      prefix: --platform=
      separate: false
  - id: output
    type: string
    doc: "VCF/GVCF output directory."
    inputBinding:
      position: 101
      prefix: --output=
      separate: false
  - id: bed_fn
    type:
      - 'null'
      - File
    doc: "Call variants only in the provided bed regions."
    inputBinding:
      position: 101
      prefix: --bed_fn=
      separate: false
  - id: vcf_fn
    type:
      - 'null'
      - File
    doc: "Candidate sites VCF file input, variants will only be called at the sites in the VCF file if provided."
    inputBinding:
      position: 101
      prefix: --vcf_fn=
      separate: false
  - id: ctg_name
    type:
      - 'null'
      - string
    doc: "The name of the sequence to be processed."
    inputBinding:
      position: 101
      prefix: --ctg_name=
      separate: false
  - id: sample_name
    type:
      - 'null'
      - string
    doc: "Define the sample name to be shown in the VCF file."
    inputBinding:
      position: 101
      prefix: --sample_name=
      separate: false
  - id: qual
    type:
      - 'null'
      - int
    doc: "If set, variants with >$qual will be marked PASS, or LowQual otherwise."
    inputBinding:
      position: 101
      prefix: --qual=
      separate: false
  - id: samtools
    type:
      - 'null'
      - string
    doc: "Path of samtools, samtools version >= 1.10 is required."
    inputBinding:
      position: 101
      prefix: --samtools=
      separate: false
  - id: python
    type:
      - 'null'
      - string
    doc: "Path of python, python3 >= 3.6 is required."
    inputBinding:
      position: 101
      prefix: --python=
      separate: false
  - id: pypy
    type:
      - 'null'
      - string
    doc: "Path of pypy3, pypy3 >= 3.6 is required."
    inputBinding:
      position: 101
      prefix: --pypy=
      separate: false
  - id: parallel
    type:
      - 'null'
      - string
    doc: "Path of parallel, parallel >= 20191122 is required."
    inputBinding:
      position: 101
      prefix: --parallel=
      separate: false
  - id: whatshap
    type:
      - 'null'
      - string
    doc: "Path of whatshap, whatshap >= 1.0 is required."
    inputBinding:
      position: 101
      prefix: --whatshap=
      separate: false
  - id: longphase
    type:
      - 'null'
      - string
    doc: "Path of longphase, longphase >= 1.0 is required."
    inputBinding:
      position: 101
      prefix: --longphase=
      separate: false
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: "The size of each chuck for parallel processing, default: 5000000."
    inputBinding:
      position: 101
      prefix: --chunk_size=
      separate: false
  - id: pileup_only
    type:
      - 'null'
      - boolean
    doc: "Use the pileup model only when calling, default: disable."
    inputBinding:
      position: 101
      prefix: --pileup_only
  - id: print_ref_calls
    type:
      - 'null'
      - boolean
    doc: "Show reference calls (0/0) in VCF file, default: disable."
    inputBinding:
      position: 101
      prefix: --print_ref_calls
  - id: include_all_ctgs
    type:
      - 'null'
      - boolean
    doc: "Call variants on all contigs, otherwise call in chr{1..22,X,Y} and {1..22,X,Y}, default: disable."
    inputBinding:
      position: 101
      prefix: --include_all_ctgs
  - id: gvcf
    type:
      - 'null'
      - boolean
    doc: "Enable GVCF output, default: disable."
    inputBinding:
      position: 101
      prefix: --gvcf
  - id: use_whatshap_for_intermediate_phasing
    type:
      - 'null'
      - boolean
    doc: "Phase high-quality heterozygous variants using whatshap for full-alignment model calling, default: enable."
    inputBinding:
      position: 101
      prefix: --use_whatshap_for_intermediate_phasing
  - id: use_longphase_for_intermediate_phasing
    type:
      - 'null'
      - boolean
    doc: "Phase high-quality heterozygous variants using longphase for full-alignment model calling, default: disable."
    inputBinding:
      position: 101
      prefix: --use_longphase_for_intermediate_phasing
  - id: use_whatshap_for_final_output_phasing
    type:
      - 'null'
      - boolean
    doc: "Phase the output variants using whatshap, default: disable."
    inputBinding:
      position: 101
      prefix: --use_whatshap_for_final_output_phasing
  - id: use_longphase_for_final_output_phasing
    type:
      - 'null'
      - boolean
    doc: "Phase the output variants using longphase, default: disable."
    inputBinding:
      position: 101
      prefix: --use_longphase_for_final_output_phasing
  - id: use_whatshap_for_final_output_haplotagging
    type:
      - 'null'
      - boolean
    doc: "Haplotag input BAM using output phased variants using whatshap, default: disable."
    inputBinding:
      position: 101
      prefix: --use_whatshap_for_final_output_haplotagging
  - id: enable_phasing
    type:
      - 'null'
      - boolean
    doc: "It means `--use_whatshap_for_final_output_phasing`. The option is retained for backward compatibility."
    inputBinding:
      position: 101
      prefix: --enable_phasing
  - id: longphase_for_phasing
    type:
      - 'null'
      - boolean
    doc: "It means `--use_longphase_for_intermediate_phasing`. The option is retained for backward compatibility."
    inputBinding:
      position: 101
      prefix: --longphase_for_phasing
  - id: disable_c_impl
    type:
      - 'null'
      - boolean
    doc: "Disable C implement with cffi for pileup and full-alignment create tensor, default: enable."
    inputBinding:
      position: 101
      prefix: --disable_c_impl
  - id: remove_intermediate_dir
    type:
      - 'null'
      - boolean
    doc: "Remove intermediate directory, including intermediate phased BAM, pileup and full-alignment results. default: disable."
    inputBinding:
      position: 101
      prefix: --remove_intermediate_dir
  - id: snp_min_af
    type:
      - 'null'
      - float
    doc: "Minimum SNP AF required for a candidate variant. Lowering the value might increase a bit of sensitivity in trade of speed and accuracy, default: ont:0.08,hifi:0.08,ilmn:0.08."
    inputBinding:
      position: 101
      prefix: --snp_min_af=
      separate: false
  - id: indel_min_af
    type:
      - 'null'
      - float
    doc: "Minimum Indel AF required for a candidate variant. Lowering the value might increase a bit of sensitivity in trade of speed and accuracy, default: ont:0.15,hifi:0.08,ilmn:0.08."
    inputBinding:
      position: 101
      prefix: --indel_min_af=
      separate: false
  - id: var_pct_full
    type:
      - 'null'
      - float
    doc: "EXPERIMENTAL: Specify an expected percentage of low quality 0/1 and 1/1 variants called in the pileup mode for full-alignment mode calling, default: 0.3."
    inputBinding:
      position: 101
      prefix: --var_pct_full=
      separate: false
  - id: ref_pct_full
    type:
      - 'null'
      - float
    doc: "EXPERIMENTAL: Specify an expected percentage of low quality 0/0 variants called in the pileup mode for full-alignment mode calling, default: 0.3 for ilmn and hifi, 0.1 for ont."
    inputBinding:
      position: 101
      prefix: --ref_pct_full=
      separate: false
  - id: var_pct_phasing
    type:
      - 'null'
      - float
    doc: "EXPERIMENTAL: Specify an expected percentage of high quality 0/1 variants used in WhatsHap phasing, default: 0.8 for ont guppy5 and 0.7 for other platforms."
    inputBinding:
      position: 101
      prefix: --var_pct_phasing=
      separate: false
  - id: pileup_model_prefix
    type:
      - 'null'
      - string
    doc: "EXPERIMENTAL: Model prefix in pileup calling, including $prefix.data-00000-of-00002, $prefix.data-00001-of-00002 $prefix.index. default: pileup."
    inputBinding:
      position: 101
      prefix: --pileup_model_prefix=
      separate: false
  - id: fa_model_prefix
    type:
      - 'null'
      - string
    doc: "EXPERIMENTAL: Model prefix in full-alignment calling, including $prefix.data-00000-of-00002, $prefix.data-00001-of-00002 $prefix.index, default: full_alignment."
    inputBinding:
      position: 101
      prefix: --fa_model_prefix=
      separate: false
  - id: min_mq
    type:
      - 'null'
      - int
    doc: "EXPERIMENTAL: If set, reads with mapping quality with <$min_mq are filtered, default: 5."
    inputBinding:
      position: 101
      prefix: --min_mq=
      separate: false
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: "EXPERIMENTAL: Minimum coverage required to call a variant, default: 2."
    inputBinding:
      position: 101
      prefix: --min_coverage=
      separate: false
  - id: min_contig_size
    type:
      - 'null'
      - int
    doc: "EXPERIMENTAL: If set, contigs with contig size<$min_contig_size are filtered, default: 0."
    inputBinding:
      position: 101
      prefix: --min_contig_size=
      separate: false
  - id: fast_mode
    type:
      - 'null'
      - boolean
    doc: "EXPERIMENTAL: Skip variant candidates with AF <= 0.15, default: disable."
    inputBinding:
      position: 101
      prefix: --fast_mode
  - id: haploid_precise
    type:
      - 'null'
      - boolean
    doc: "EXPERIMENTAL: Enable haploid calling mode. Only 1/1 is considered as a variant, default: disable."
    inputBinding:
      position: 101
      prefix: --haploid_precise
  - id: haploid_sensitive
    type:
      - 'null'
      - boolean
    doc: "EXPERIMENTAL: Enable haploid calling mode. 0/1 and 1/1 are considered as a variant, default: disable."
    inputBinding:
      position: 101
      prefix: --haploid_sensitive
  - id: no_phasing_for_fa
    type:
      - 'null'
      - boolean
    doc: "EXPERIMENTAL: Call variants without whatshap phasing in full alignment calling, default: disable."
    inputBinding:
      position: 101
      prefix: --no_phasing_for_fa
  - id: call_snp_only
    type:
      - 'null'
      - boolean
    doc: "EXPERIMENTAL: Call candidates pass SNP minimum AF only, ignore Indel candidates, default: disable."
    inputBinding:
      position: 101
      prefix: --call_snp_only
  - id: enable_variant_calling_at_sequence_head_and_tail
    type:
      - 'null'
      - boolean
    doc: "EXPERIMENTAL: Enable variant calling in sequence head and tail start or end regions that flanking 16bp windows having no read support. Default: disable."
    inputBinding:
      position: 101
      prefix: --enable_variant_calling_at_sequence_head_and_tail
  - id: output_all_contigs_in_gvcf_header
    type:
      - 'null'
      - boolean
    doc: "EXPERIMENTAL: Enable output all contigs in gvcf header. Default: disable."
    inputBinding:
      position: 101
      prefix: --output_all_contigs_in_gvcf_header
  - id: enable_long_indel
    type:
      - 'null'
      - boolean
    doc: "EXPERIMENTAL: Call long Indel variants(>50 bp), default: disable."
    inputBinding:
      position: 101
      prefix: --enable_long_indel
  - id: keep_iupac_bases
    type:
      - 'null'
      - boolean
    doc: "EXPERIMENTAL: Keep IUPAC reference and alternate bases, default: convert all IUPAC bases to N."
    inputBinding:
      position: 101
      prefix: --keep_iupac_bases
  - id: base_err
    type:
      - 'null'
      - float
    doc: "EXPERIMENTAL: Estimated base error rate when enabling gvcf option, default: 0.001."
    inputBinding:
      position: 101
      prefix: --base_err=
      separate: false
  - id: gq_bin_size
    type:
      - 'null'
      - int
    doc: "EXPERIMENTAL: Default gq bin size for merge non-variant block when enabling gvcf option, default: 5."
    inputBinding:
      position: 101
      prefix: --gq_bin_size=
      separate: false
outputs:
  - id: output_dir
    type: Directory
    doc: VCF/GVCF output directory
    outputBinding:
      glob: $(inputs.output)
  - id: merge_output
    type: File
    doc: Final variant calls (merged pileup and full-alignment calls)
    secondaryFiles:
      - pattern: .tbi
        required: false
    outputBinding:
      glob: $(inputs.output)/merge_output.vcf.gz
  - id: merge_output_gvcf
    type:
      - 'null'
      - File
    doc: Final GVCF (with --gvcf)
    secondaryFiles:
      - pattern: .tbi
        required: false
    outputBinding:
      glob: $(inputs.output)/merge_output.gvcf.gz
  - id: phased_merge_output
    type:
      - 'null'
      - File
    doc: Phased final variant calls (with --enable_phasing or final output phasing)
    secondaryFiles:
      - pattern: .tbi
        required: false
    outputBinding:
      glob: $(inputs.output)/phased_merge_output.vcf.gz
  - id: pileup_vcf
    type:
      - 'null'
      - File
    doc: Pileup model calls
    outputBinding:
      glob: $(inputs.output)/pileup.vcf.gz
  - id: full_alignment_vcf
    type:
      - 'null'
      - File
    doc: Full-alignment model calls
    outputBinding:
      glob: $(inputs.output)/full_alignment.vcf.gz
  - id: log
    type:
      - 'null'
      - File
    doc: Run log
    outputBinding:
      glob: $(inputs.output)/run_clair3.log
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clair3:1.2.0--py310h779eee5_0
