cwlVersion: v1.2
class: CommandLineTool
baseCommand: ./run_clair3_trio.sh
label: clair3-trio_run_clair3_trio.sh
doc: "Clair3-Trio v0.7\n\nTool homepage: https://github.com/HKU-BAL/Clair3-Trio"
inputs:
  - id: bam_fn_c
    type: File
    doc: BAM file input, for child. The input file must be samtools indexed.
    inputBinding:
      position: 101
      prefix: --bam_fn_c
  - id: bam_fn_p1
    type: File
    doc: BAM file input, for parent1. The input file must be samtools indexed.
    inputBinding:
      position: 101
      prefix: --bam_fn_p1
  - id: bam_fn_p2
    type: File
    doc: BAM file input, for parent1. The input file must be samtools indexed.
    inputBinding:
      position: 101
      prefix: --bam_fn_p2
  - id: bed_fn
    type:
      - 'null'
      - File
    doc: Call variants only in the provided bed regions.
    inputBinding:
      position: 101
      prefix: --bed_fn
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: 'The size of each chuck for parallel processing, default: 5000000.'
    inputBinding:
      position: 101
      prefix: --chunk_size
  - id: ctg_name
    type:
      - 'null'
      - string
    doc: The name of the sequence to be processed.
    inputBinding:
      position: 101
      prefix: --ctg_name
  - id: enable_output_haplotagging
    type:
      - 'null'
      - boolean
    doc: 'Output enable_output_haplotagging BAM variants using whatshap, default:
      disable.'
    inputBinding:
      position: 101
      prefix: --enable_output_haplotagging
  - id: enable_output_phasing
    type:
      - 'null'
      - boolean
    doc: 'Output phased variants using whatshap, default: disable.'
    inputBinding:
      position: 101
      prefix: --enable_output_phasing
  - id: enable_phasing
    type:
      - 'null'
      - boolean
    doc: It means `--enable_output_phasing`. The option is retained for backward
      compatibility.
    inputBinding:
      position: 101
      prefix: --enable_phasing
  - id: gvcf
    type:
      - 'null'
      - boolean
    doc: 'Enable GVCF output, default: disable.'
    inputBinding:
      position: 101
      prefix: --gvcf
  - id: include_all_ctgs
    type:
      - 'null'
      - boolean
    doc: 'Call variants on all contigs, otherwise call in chr{1..22,X,Y} and {1..22,X,Y},
    inputBinding:
      position: 101
      prefix: --include_all_ctgs
  - id: indel_min_af
    type:
      - 'null'
      - float
    doc: 'Minimum Indel AF required for a candidate variant. Lowering the value might
      increase a bit of sensitivity in trade of speed and accuracy, default: ont:0.15,hifi:0.08,ilmn:0.08.'
    inputBinding:
      position: 101
      prefix: --indel_min_af
  - id: model_path_clair3
    type: string
    doc: The folder path containing a Clair3 model (requiring six files in the 
      folder, including pileup.data-00000-of-00002, pileup.data-00001-of-00002 
      pileup.index, full_alignment.data-00000-of-00002, 
      full_alignment.data-00001-of-00002  and full_alignment.index).
    inputBinding:
      position: 101
      prefix: --model_path_clair3
  - id: model_path_clair3_trio
    type: string
    doc: The folder path containing a Clair3-Trio model (files structure same as
      Clair3).
    inputBinding:
      position: 101
      prefix: --model_path_clair3_trio
  - id: parallel
    type:
      - 'null'
      - string
    doc: Path of parallel, parallel >= 20191122 is required.
    inputBinding:
      position: 101
      prefix: --parallel
  - id: pileup_model_prefix
    type:
      - 'null'
      - string
    doc: 'EXPERIMENTAL: Model prefix in pileup calling, including $prefix.data-00000-of-00002,
      $prefix.data-00001-of-00002 $prefix.index. default: pileup.'
    inputBinding:
      position: 101
      prefix: --pileup_model_prefix
  - id: pileup_only
    type:
      - 'null'
      - boolean
    doc: 'Use the pileup model only when calling, default: disable.'
    inputBinding:
      position: 101
      prefix: --pileup_only
  - id: pileup_phasing
    type:
      - 'null'
      - boolean
    doc: 'Use the pileup model calling and phasing, default: disable.'
    inputBinding:
      position: 101
      prefix: --pileup_phasing
  - id: print_ref_calls
    type:
      - 'null'
      - boolean
    doc: 'Show reference calls (0/0) in VCF file, default: disable.'
    inputBinding:
      position: 101
      prefix: --print_ref_calls
  - id: pypy
    type:
      - 'null'
      - string
    doc: Path of pypy3, pypy3 >= 3.6 is required.
    inputBinding:
      position: 101
      prefix: --pypy
  - id: python
    type:
      - 'null'
      - string
    doc: Path of python, python3 >= 3.6 is required.
    inputBinding:
      position: 101
      prefix: --python
  - id: qual
    type:
      - 'null'
      - int
    doc: If set, variants with >=$qual will be marked PASS, or LowQual 
      otherwise.
    inputBinding:
      position: 101
      prefix: --qual
  - id: ref_fn
    type: File
    doc: FASTA reference file input. The input file must be samtools indexed.
    inputBinding:
      position: 101
      prefix: --ref_fn
  - id: ref_pct_full
    type:
      - 'null'
      - float
    doc: 'EXPERIMENTAL: Specify an expected percentage of low quality 0/0 variants
      called in the pileup mode for full-alignment mode calling, default:  0.1 .'
    inputBinding:
      position: 101
      prefix: --ref_pct_full
  - id: sample_name_c
    type:
      - 'null'
      - string
    doc: Define the sample name for Child to be shown in the VCF file.
    inputBinding:
      position: 101
      prefix: --sample_name_c
  - id: sample_name_p1
    type:
      - 'null'
      - string
    doc: Define the sample name for Parent1 to be shown in the VCF file.
    inputBinding:
      position: 101
      prefix: --sample_name_p1
  - id: sample_name_p2
    type:
      - 'null'
      - string
    doc: Define the sample name for Parent2 to be shown in the VCF file.
    inputBinding:
      position: 101
      prefix: --sample_name_p2
  - id: samtools
    type:
      - 'null'
      - string
    doc: Path of samtools, samtools version >= 1.10 is required.
    inputBinding:
      position: 101
      prefix: --samtools
  - id: snp_min_af
    type:
      - 'null'
      - float
    doc: 'Minimum SNP AF required for a candidate variant. Lowering the value might
      increase a bit of sensitivity in trade of speed and accuracy, default: ont:0.08,hifi:0.08,ilmn:0.08.'
    inputBinding:
      position: 101
      prefix: --snp_min_af
  - id: threads
    type: int
    doc: 'Max #threads to be used. The full genome will be divided into small chunks
      for parallel processing. Each chunk will use 4 threads. The #chunks being processed
      simultaneously is ceil(#threads/4)*3. 3 is the overloading factor.'
    inputBinding:
      position: 101
      prefix: --threads
  - id: trio_model_prefix
    type:
      - 'null'
      - string
    doc: 'Model prefix in trio calling, including $prefix.data-00000-of-00002, $prefix.data-00001-of-00002
      $prefix.index, default: trio.'
    inputBinding:
      position: 101
      prefix: --trio_model_prefix
  - id: var_pct_full
    type:
      - 'null'
      - float
    doc: 'EXPERIMENTAL: Specify an expected percentage of low quality 0/1 and 1/1
      variants called in the pileup mode for full-alignment mode calling, default:
      0.3.'
    inputBinding:
      position: 101
      prefix: --var_pct_full
  - id: var_pct_phasing
    type:
      - 'null'
      - float
    doc: 'EXPERIMENTAL: Specify an expected percentage of high quality 0/1 variants
      used in WhatsHap phasing, default: 0.8 for ont guppy5 and 0.7 for other platforms.'
    inputBinding:
      position: 101
      prefix: --var_pct_phasing
  - id: vcf_fn
    type:
      - 'null'
      - File
    doc: Candidate sites VCF file input, variants will only be called at the 
      sites in the VCF file if provided.
    inputBinding:
      position: 101
      prefix: --vcf_fn
  - id: whatshap
    type:
      - 'null'
      - string
    doc: Path of whatshap, whatshap >= 1.0 is required.
    inputBinding:
      position: 101
      prefix: --whatshap
outputs:
  - id: output
    type: Directory
    doc: VCF/GVCF output directory.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clair3-trio:0.7--py39hd649744_2
