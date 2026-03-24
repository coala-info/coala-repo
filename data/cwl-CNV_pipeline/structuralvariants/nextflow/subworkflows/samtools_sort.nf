/*
 * Include for samtools_sort
*/
include {
    SAMTOOLS_SORT as SAMTOOLS_SORT_PAIRED
} from "../modules/samtools_sort"
include {
    SAMTOOLS_SORT as SAMTOOLS_SORT_UNPAIRED_R1
} from "../modules/samtools_sort"
include {
    SAMTOOLS_SORT as SAMTOOLS_SORT_UNPAIRED_R2
} from "../modules/samtools_sort"

/*
* Subworkflow samtools_sort
*/
workflow SUB_SAMTOOLS_SORT {
  take:
    paired
    unpaired_R1
    unpaired_R2

  main:
    SAMTOOLS_SORT_PAIRED(paired)
    SAMTOOLS_SORT_UNPAIRED_R1(unpaired_R1)
    SAMTOOLS_SORT_UNPAIRED_R2(unpaired_R2)

  emit:
    paired = SAMTOOLS_SORT_PAIRED.out
    unpairedR1 = SAMTOOLS_SORT_UNPAIRED_R1.out
    unpairedR2 = SAMTOOLS_SORT_UNPAIRED_R2.out
}
