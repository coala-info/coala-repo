/*
 * Includes for bwa_index
 */
include {
 SAMTOOLS_FAIDX
} from "../modules/samtools_faidx"
include {
  BWA_INDEX
} from "../modules/bwa_index"

/*
* Subworkflow bwa_index
*/
workflow SUB_BWA_INDEX {
  take:
    reference_fasta

  main:
    SAMTOOLS_FAIDX(reference_fasta)
    BWA_INDEX(reference_fasta)

  emit:
    fai = SAMTOOLS_FAIDX.out
    indexs = BWA_INDEX.out
}
