/*
 * Include for picard_markduplicates
*/
include {
    PICARD_MARKDUPLICATES
} from "../modules/picard_markduplicates"
include {
    SAMTOOLS_INDEX
} from "../modules/samtools_index"

/*
* Subworkflow picard_markduplicates
*/
workflow SUB_PICARD_MARKDUPLICATES {
    take:
        input

    main:
        PICARD_MARKDUPLICATES(input)
        SAMTOOLS_INDEX(PICARD_MARKDUPLICATES.out.alignments)

    emit:
        alignments = SAMTOOLS_INDEX.out
        metrics = PICARD_MARKDUPLICATES.out.metrics
}
