params.bamsDir = "output_bams"

/*
 * Include for bam_filtering
*/
include {
    SAMTOOLS_VIEW
} from "../modules/samtools_view"
include {
    SAMTOOLS_INDEX
} from "../modules/samtools_index" params([*:params, "bamsDir": ""])


/*
* Subworkflow bam_filtering
*/
workflow SUB_BAM_FILTERING {
    take:
      input

    main:
        SAMTOOLS_VIEW(input)
        SAMTOOLS_INDEX(SAMTOOLS_VIEW.out)

    emit:
      bams = SAMTOOLS_INDEX.out
}
