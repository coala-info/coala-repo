/*
 * Include for final_filtering
*/
include {
    BEDOPS_UNION as UNION
} from "../modules/bedops_union"
include {
    MERGE_ALL as MERGE
} from "../modules/merge_all"

/*
* Subworkflow final_filtering
*/
workflow SUB_FINAL_FILTERING {
    take:
      cnv_results

    main:
        UNION(cnv_results.collect())
        MERGE(UNION.out)

    emit:
        output = MERGE.out
}
