/*
 * Include for cnv_gridss
*/
include {
    GRIDSS
} from "../modules/gridss"
include {
    STRUCTURAL_VARIANTS
} from "../modules/structural_variants"
include {
    GRIDSS_FILTER
} from "../modules/gridss_filter"
include {
    BEDOPS_UNION as GRIDSS_UNION
} from "../modules/bedops_union"
include {
    COLLAPSE as GRIDSS_MERGE
} from "../modules/collapse"


/*
* Subworkflow cnv_gridss
*/
workflow SUB_CNV_GRIDSS {
    take:
        bamsbedChr
        reference_fasta
        indexFiles
        samples
        blacklist
        max_len
        min_len
        min_q

    main:
        GRIDSS(bamsbedChr, reference_fasta, indexFiles, params.threads_gridss, blacklist)
        STRUCTURAL_VARIANTS(GRIDSS.out)
        GRIDSS_FILTER(STRUCTURAL_VARIANTS.out, samples, max_len, min_len, min_q)
        GRIDSS_UNION(GRIDSS_FILTER.out.collect())
        GRIDSS_MERGE(GRIDSS_UNION.out)

    emit:
      output = GRIDSS_MERGE.out
}
