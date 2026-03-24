/*
 * Include for samtools_view_sam2bam
*/
include {
    SAMTOOLS_VIEW_SAM2BAM as SAMTOOLS_VIEW_SAM2BAM_PAIRED
} from "../modules/samtools_view_sam2bam"
include {
    SAMTOOLS_VIEW_SAM2BAM as SAMTOOLS_VIEW_SAM2BAM_UNPAIRED1
} from "../modules/samtools_view_sam2bam"
include {
    SAMTOOLS_VIEW_SAM2BAM as SAMTOOLS_VIEW_SAM2BAM_UNPAIRED2
} from "../modules/samtools_view_sam2bam"


/*
* Subworkflow samtools_view_sam2bam
*/
workflow SUB_SAMTOOLS_VIEW_SAM2BAM {
  take:
    paired
    unpairedR1
    unpairedR2

  main:
    SAMTOOLS_VIEW_SAM2BAM_PAIRED(paired)
    SAMTOOLS_VIEW_SAM2BAM_UNPAIRED1(unpairedR1)
    SAMTOOLS_VIEW_SAM2BAM_UNPAIRED2(unpairedR2)

  emit:
    paired = SAMTOOLS_VIEW_SAM2BAM_PAIRED.out
    unpairedR1 = SAMTOOLS_VIEW_SAM2BAM_UNPAIRED1.out
    unpairedR2 = SAMTOOLS_VIEW_SAM2BAM_UNPAIRED2.out
}
