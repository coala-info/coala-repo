/*
 * Includes for trimmed_fastq
 */
include {
  FASTQC as FASTQC_RAW_DATA
} from "../modules/fastqc"
include {
  FASTP
} from "../modules/fastp"
include {
  FASTQC as FASTQC_PRE_PROCESSED
} from "../modules/fastqc"

/*
* Subworkflow trimmed_fastq
* Quality Control (raw data), Raw Data trimming and Quality Control (pre-processed)
*/
workflow SUB_TRIMMED_FASTQ {
  take:
    fastq

  main:
    FASTQC_RAW_DATA(fastq,
                    params.threads_fastqc)

    FASTP(fastq,
          params.threads_fastp,
          params.cut_right_window_size,
          params.cut_right_mean_quality,
          params.trim_tail1,
          params.length_required)

    FASTQC_PRE_PROCESSED(FASTP.out.paired_fastq,
                         params.threads_fastqc)

  emit:
    reads = FASTP.out.reads
}
