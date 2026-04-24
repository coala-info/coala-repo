cwlVersion: v1.2
class: CommandLineTool
baseCommand: gstacks
label: stacks_gstacks
doc: "De novo and reference-based mode for variant calling.\n\nTool homepage: https://catchenlab.life.illinois.edu/stacks/"
inputs:
  - id: bam_dir
    type:
      - 'null'
      - Directory
    doc: input directory containing BAM files
    inputBinding:
      position: 101
      prefix: -I
  - id: bam_file
    type:
      - 'null'
      - type: array
        items: File
    doc: input BAM file(s)
    inputBinding:
      position: 101
      prefix: -B
  - id: details
    type:
      - 'null'
      - boolean
    doc: write a heavier output
    inputBinding:
      position: 101
  - id: gt_alpha
    type:
      - 'null'
      - float
    doc: 'alpha threshold for calling genotypes (default: 0.05)'
    inputBinding:
      position: 101
  - id: ignore_pe_reads
    type:
      - 'null'
      - boolean
    doc: ignore paired-end reads even if present in the input
    inputBinding:
      position: 101
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: 'kmer length for the de Bruijn graph (default: 31, max. 31)'
    inputBinding:
      position: 101
  - id: max_clipped
    type:
      - 'null'
      - float
    doc: 'maximum soft-clipping level, in fraction of read length (default: 0.20)'
    inputBinding:
      position: 101
  - id: max_debruijn_reads
    type:
      - 'null'
      - int
    doc: 'maximum number of reads to use in the de Bruijn graph (default: 1000)'
    inputBinding:
      position: 101
  - id: max_insert_len
    type:
      - 'null'
      - int
    doc: 'maximum allowed sequencing insert length (default: 1000)'
    inputBinding:
      position: 101
  - id: methyl_status
    type:
      - 'null'
      - boolean
    doc: assumes a methylation-aware molecular protocol used; calls methylated 
      bases.
    inputBinding:
      position: 101
  - id: min_kmer_cov
    type:
      - 'null'
      - int
    doc: 'minimum coverage to consider a kmer (default: 2)'
    inputBinding:
      position: 101
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: 'minimum PHRED-scaled mapping quality to consider a read (default: 10)'
    inputBinding:
      position: 101
  - id: model
    type:
      - 'null'
      - string
    doc: model to use to call variants and genotypes; one of marukilow 
      (default), marukihigh, or snp
    inputBinding:
      position: 101
  - id: phasing_cooccurrences_thr_range
    type:
      - 'null'
      - string
    doc: 'range of edge coverage thresholds to iterate over when building the graph
      of allele cooccurrences for SNP phasing (default: 1,2)'
    inputBinding:
      position: 101
  - id: phasing_dont_prune_hets
    type:
      - 'null'
      - boolean
    doc: don't try to ignore dubious heterozygote genotypes during phasing
    inputBinding:
      position: 101
  - id: popmap
    type: File
    doc: path to a population map giving the list of samples
    inputBinding:
      position: 101
      prefix: -M
  - id: rm_pcr_duplicates
    type:
      - 'null'
      - boolean
    doc: remove all but one set ofread pairs of the same sample that have the 
      same insert length (implies --rm-unpaired-reads)
    inputBinding:
      position: 101
  - id: rm_unpaired_reads
    type:
      - 'null'
      - boolean
    doc: discard unpaired reads
    inputBinding:
      position: 101
  - id: stacks_dir
    type:
      - 'null'
      - Directory
    doc: input directory containg '*.matches.bam' files created by the de novo 
      Stacks pipeline, ustacks-cstacks-sstacks-tsv2bam
    inputBinding:
      position: 101
      prefix: -P
  - id: suffix
    type:
      - 'null'
      - string
    doc: "suffix to use to build BAM file names: by default this is just '.bam', i.e.
      the program expects 'SAMPLE_NAME.bam'"
    inputBinding:
      position: 101
      prefix: -S
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: unpaired
    type:
      - 'null'
      - boolean
    doc: ignore read pairing (only for paired-end GBS; treat READ2's as if they 
      were READ1's)
    inputBinding:
      position: 101
  - id: var_alpha
    type:
      - 'null'
      - float
    doc: 'alpha threshold for discovering SNPs (default: 0.01 for marukilow)'
    inputBinding:
      position: 101
  - id: write_alignments
    type:
      - 'null'
      - boolean
    doc: save read alignments (heavy BAM files)
    inputBinding:
      position: 101
outputs:
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: 'output directory (default: none with -B; with -P same as the input directory)'
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stacks:2.68--h077b44d_3
