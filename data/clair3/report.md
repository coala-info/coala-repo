# clair3 CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| clair3_run_clair3.sh | PASS |  |

## clair3_run_clair3.sh

### Tool Description
Clair3 germline small variant caller: run_clair3.sh --bam_fn=BAM --ref_fn=REF --output=OUTPUT_DIR --threads=THREADS --platform=PLATFORM --model_path=MODEL_PREFIX

### Metadata
- **Docker Image**: quay.io/biocontainers/clair3:1.2.0--py310h779eee5_0
- **Homepage**: https://github.com/HKU-BAL/Clair3
- **Package**: https://anaconda.org/channels/bioconda/packages/clair3/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: run_clair3.sh --bam_fn=BAM --ref_fn=REF --output=OUTPUT_DIR --threads=THREADS --platform=PLATFORM --model_path=MODEL_PREFIX [--bed_fn=BED] [options]

Required parameters:
  -b, --bam_fn=FILE             BAM file input. The input file must be samtools indexed.
  -f, --ref_fn=FILE             FASTA reference file input. The input file must be samtools indexed.
  -m, --model_path=STR          The folder path containing a Clair3 model (requiring six files in the folder, including pileup.data-00000-of-00002, pileup.data-00001-of-00002 pileup.index, full_alignment.data-00000-of-00002, full_alignment.data-00001-of-00002 and full_alignment.index).
  -t, --threads=INT             Max #threads to be used. The full genome will be divided into small chunks for parallel processing. Each chunk will use 4 threads. The #chunks being processed simultaneously is ceil(#threads/4)*3. 3 is the overloading factor.
  -p, --platform=STR            Select the sequencing platform of the input. Possible options: {ont,hifi,ilmn}.
  -o, --output=PATH             VCF/GVCF output directory.


Optional parameters (Use "=value" instead of " value". E.g., "--bed_fn=fn.bed" instead of "--bed_fn fn.bed".):
      --bed_fn=FILE             Call variants only in the provided bed regions.
      --vcf_fn=FILE             Candidate sites VCF file input, variants will only be called at the sites in the VCF file if provided.
      --ctg_name=STR            The name of the sequence to be processed.
      --sample_name=STR         Define the sample name to be shown in the VCF file.
      --qual=INT                If set, variants with >$qual will be marked PASS, or LowQual otherwise.
      --samtools=STR            Path of samtools, samtools version >= 1.10 is required.
      --python=STR              Path of python, python3 >= 3.6 is required.
      --pypy=STR                Path of pypy3, pypy3 >= 3.6 is required.
      --parallel=STR            Path of parallel, parallel >= 20191122 is required.
      --whatshap=STR            Path of whatshap, whatshap >= 1.0 is required.
      --longphase=STR           Path of longphase, longphase >= 1.0 is required.
      --chunk_size=INT          The size of each chuck for parallel processing, default: 5000000.
      --pileup_only             Use the pileup model only when calling, default: disable.
      --print_ref_calls         Show reference calls (0/0) in VCF file, default: disable.
      --include_all_ctgs        Call variants on all contigs, otherwise call in chr{1..22,X,Y} and {1..22,X,Y}, default: disable.
      --gvcf                    Enable GVCF output, default: disable.
      --use_whatshap_for_intermediate_phasing
                                           Phase high-quality heterozygous variants using whatshap for full-alignment model calling, default: enable.
      --use_longphase_for_intermediate_phasing
                                           Phase high-quality heterozygous variants using longphase for full-alignment model calling, default: disable.
      --use_whatshap_for_final_output_phasing
                                           Phase the output variants using whatshap, default: disable.
      --use_longphase_for_final_output_phasing
                                           Phase the output variants using longphase, default: disable.
      --use_whatshap_for_final_output_haplotagging
                                           Haplotag input BAM using output phased variants using whatshap, default: disable.
      --enable_phasing          It means `--use_whatshap_for_final_output_phasing`. The option is retained for backward compatibility.
      --longphase_for_phasing   It means `--use_longphase_for_intermediate_phasing`. The option is retained for backward compatibility.
      --disable_c_impl          Disable C implement with cffi for pileup and full-alignment create tensor, default: enable.
      --remove_intermediate_dir Remove intermediate directory, including intermediate phased BAM, pileup and full-alignment results. default: disable.
      --snp_min_af=FLOAT        Minimum SNP AF required for a candidate variant. Lowering the value might increase a bit of sensitivity in trade of speed and accuracy, default: ont:0.08,hifi:0.08,ilmn:0.08.
      --indel_min_af=FLOAT      Minimum Indel AF required for a candidate variant. Lowering the value might increase a bit of sensitivity in trade of speed and accuracy, default: ont:0.15,hifi:0.08,ilmn:0.08.
      --var_pct_full=FLOAT      EXPERIMENTAL: Specify an expected percentage of low quality 0/1 and 1/1 variants called in the pileup mode for full-alignment mode calling, default: 0.3.
      --ref_pct_full=FLOAT      EXPERIMENTAL: Specify an expected percentage of low quality 0/0 variants called in the pileup mode for full-alignment mode calling, default: 0.3 for ilmn and hifi, 0.1 for ont.
      --var_pct_phasing=FLOAT   EXPERIMENTAL: Specify an expected percentage of high quality 0/1 variants used in WhatsHap phasing, default: 0.8 for ont guppy5 and 0.7 for other platforms.
      --pileup_model_prefix=STR EXPERIMENTAL: Model prefix in pileup calling, including $prefix.data-00000-of-00002, $prefix.data-00001-of-00002 $prefix.index. default: pileup.
      --fa_model_prefix=STR     EXPERIMENTAL: Model prefix in full-alignment calling, including $prefix.data-00000-of-00002, $prefix.data-00001-of-00002 $prefix.index, default: full_alignment.
      --min_mq=INT              EXPERIMENTAL: If set, reads with mapping quality with <$min_mq are filtered, default: 5.
      --min_coverage=INT        EXPERIMENTAL: Minimum coverage required to call a variant, default: 2.
      --min_contig_size=INT     EXPERIMENTAL: If set, contigs with contig size<$min_contig_size are filtered, default: 0.
      --fast_mode               EXPERIMENTAL: Skip variant candidates with AF <= 0.15, default: disable.
      --haploid_precise         EXPERIMENTAL: Enable haploid calling mode. Only 1/1 is considered as a variant, default: disable.
      --haploid_sensitive       EXPERIMENTAL: Enable haploid calling mode. 0/1 and 1/1 are considered as a variant, default: disable.
      --no_phasing_for_fa       EXPERIMENTAL: Call variants without whatshap phasing in full alignment calling, default: disable.
      --call_snp_only           EXPERIMENTAL: Call candidates pass SNP minimum AF only, ignore Indel candidates, default: disable.
      --enable_variant_calling_at_sequence_head_and_tail
                                           EXPERIMENTAL: Enable variant calling in sequence head and tail start or end regions that flanking 16bp windows having no read support. Default: disable.
      --output_all_contigs_in_gvcf_header
                                           EXPERIMENTAL: Enable output all contigs in gvcf header. Default: disable.
      --enable_long_indel       EXPERIMENTAL: Call long Indel variants(>50 bp), default: disable.
      --keep_iupac_bases        EXPERIMENTAL: Keep IUPAC reference and alternate bases, default: convert all IUPAC bases to N.
      --base_err=FLOAT          EXPERIMENTAL: Estimated base error rate when enabling gvcf option, default: 0.001.
      --gq_bin_size=INT         EXPERIMENTAL: Default gq bin size for merge non-variant block when enabling gvcf option, default: 5.
```


## Metadata
- **Skill**: generated

