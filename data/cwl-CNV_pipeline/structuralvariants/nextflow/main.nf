#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

/*
 * Channels
*/
Channel
  .fromPath(params.fastq)
  .map { [it.getSimpleName().substring(0, it.getSimpleName().lastIndexOf("_")), it] }
  .groupTuple()
  .map { it.flatten() }
  .set { fastq }
Channel
  .fromPath(params.reference_fasta)
  .set{ reference_fasta }
Channel
  .fromPath(params.samples)
  .set{ samples }
Channel
  .fromPath(params.bed)
  .set{ bed }
Channel
  .fromPath(params.bed_tbi)
  .set{ bed_tbi }
Channel
  .fromPath(params.blacklist)
  .set{ blacklist }

/*
 * Define the default parameters
*/
params.threads_fastqc = 1
params.threads_fastp = 1
params.threads_bwa_mem = 1
params.threads_samtools = 1
params.threads_gridss = 1
params.cut_right = true
params.cut_right_window_size = 5
params.cut_right_mean_quality = 24
params.trim_tail1 = 1
params.length_required = 70
params.min_mapping_quality = 10
params.bits_set = 4
params.algoType = ''
params.assemblyFilename = "gridss.assembly.bam"
params.read_group = "@RG\\tID:SRR709972\\tSM:NA19206\\tPL:ILLUMINA\\tCN:CBRA\\tLB:Fragment"

/*
 * Include modules
*/
include { GUNZIP } from "./modules/gunzip"

/*
 * Include subworkflows
*/
include { SUB_BWA_INDEX } from './subworkflows/bwa_index'
include { SUB_TRIMMED_FASTQ } from './subworkflows/trimmed_fastq'
include { SUB_BWA_MEM } from './subworkflows/bwa_mem'
include { SUB_SAMTOOLS_VIEW_SAM2BAM } from './subworkflows/samtools_view_sam2bam'
include { SUB_SAMTOOLS_SORT } from './subworkflows/samtools_sort'
include { SAMTOOLS_MERGE } from './modules/samtools_merge'
include { SAMTOOLS_INDEX } from './modules/samtools_index'
include { SUB_PICARD_MARKDUPLICATES } from './subworkflows/picard_markduplicates'
include { SUB_BAM_FILTERING } from './subworkflows/bam_filtering'
include { SUB_CNV_MANTA } from './subworkflows/cnv_manta'
include { SUB_CNV_GRIDSS } from './subworkflows/cnv_gridss'
include { SUB_CNV_EXOMEDEPTH } from './subworkflows/cnv_exomedepth'
include { SUB_CNV_CODEX } from './subworkflows/cnv_codex'
include { SUB_FINAL_FILTERING } from './subworkflows/final_filtering'

workflow {

  GUNZIP(reference_fasta)
  reference_fasta = GUNZIP.out

  if(params.generate_bwa_indexes) {
    output_bwa_index = SUB_BWA_INDEX(reference_fasta)
    indexFiles = output_bwa_index.indexs.combine(output_bwa_index.fai).collect()
  }
  else {
    if (params.reference_fasta_indexs) { indexChr = Channel.fromPath(params.reference_fasta_indexs) }  else { indexChr = [file("no_indexs")] }
    indexFiles = indexChr.collect()
  }

  SUB_TRIMMED_FASTQ(fastq)

  SUB_BWA_MEM(
    SUB_TRIMMED_FASTQ.out.reads,
    indexFiles
  )

  SUB_SAMTOOLS_VIEW_SAM2BAM(
    SUB_BWA_MEM.out.paired,
    SUB_BWA_MEM.out.unpairedR1,
    SUB_BWA_MEM.out.unpairedR2
  )

  SUB_SAMTOOLS_SORT(
    SUB_SAMTOOLS_VIEW_SAM2BAM.out.paired,
    SUB_SAMTOOLS_VIEW_SAM2BAM.out.unpairedR1,
    SUB_SAMTOOLS_VIEW_SAM2BAM.out.unpairedR2
  )

  SAMTOOLS_MERGE(
    SUB_SAMTOOLS_SORT.out.paired,
    SUB_SAMTOOLS_SORT.out.unpairedR1,
    SUB_SAMTOOLS_SORT.out.unpairedR2
  )

  SAMTOOLS_INDEX(SAMTOOLS_MERGE.out.output)

  SUB_PICARD_MARKDUPLICATES(SAMTOOLS_INDEX.out.output)

  SUB_BAM_FILTERING(SUB_PICARD_MARKDUPLICATES.out.alignments)

  bamsChr = SUB_BAM_FILTERING.out
  refChr = reference_fasta.combine(indexFiles)
  bedChr = bed.combine(bed_tbi)
  bamsbedChr = bamsChr.combine(bedChr)

  cnv_manta_results = Channel.empty()
  cnv_gridss_results = Channel.empty()
  cnv_exomedepth_results = Channel.empty()
  cnv_codex_results = Channel.empty()

  if(params.enable_manta) {
    SUB_CNV_MANTA (
      bamsbedChr,
      reference_fasta,
      indexFiles,
      samples,
      params.manta_exome,
      params.manta_max_len,
      params.manta_min_len,
      params.manta_min_q
    )

    cnv_manta_results = SUB_CNV_MANTA.out.output
  }

  if(params.enable_gridss) {
    SUB_CNV_GRIDSS (
      bamsbedChr,
      reference_fasta,
      indexFiles,
      samples,
      blacklist,
      params.gridss_max_len,
      params.gridss_min_len,
      params.gridss_min_q
    )

    cnv_gridss_results = SUB_CNV_GRIDSS.out.output
  }

  if(params.enable_exomeDepth) {
    SUB_CNV_EXOMEDEPTH (
      bamsChr,
      bed,
      reference_fasta,
      samples,
      params.exomeDepth_max_len,
      params.exomeDepth_min_len,
      params.exomeDepth_min_bf

    )

    cnv_exomedepth_results = SUB_CNV_EXOMEDEPTH.out.output
  }

  if(params.enable_codex) {
    SUB_CNV_CODEX (
      bamsChr,
      bed,
      samples,
      params.codex_max_len,
      params.codex_min_len,
      params.codex_min_lratio

    )

    cnv_codex_results = SUB_CNV_CODEX.out.output
  }

  cnv_results = cnv_manta_results.mix(cnv_gridss_results, cnv_exomedepth_results, cnv_codex_results)
  SUB_FINAL_FILTERING(cnv_results)
}
