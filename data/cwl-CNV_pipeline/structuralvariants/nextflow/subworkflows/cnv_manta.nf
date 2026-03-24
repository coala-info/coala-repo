/*
 * Include for cnv_manta
*/
include {
    MANTA
} from "../modules/manta"
include {
    SVTOOLS
} from "../modules/svtools"
include {
    MANTA_FILTER
} from "../modules/manta_filter"
include {
    BEDOPS_UNION as MANTA_UNION
} from "../modules/bedops_union"
include {
    COLLAPSE as MANTA_MERGE
} from "../modules/collapse"


/*
* Subworkflow cnv_manta
*/
workflow SUB_CNV_MANTA {
    take:
      bamsbedChr
      reference_fasta
      indexFiles
       samples
       exome
       max_len
       min_len
       min_q

    main:
        MANTA(bamsbedChr, reference_fasta, indexFiles, exome)
        SVTOOLS(MANTA.out)
        MANTA_FILTER(SVTOOLS.out, samples, max_len, min_len, min_q)
        MANTA_UNION(MANTA_FILTER.out.collect())
        MANTA_MERGE(MANTA_UNION.out)

    emit:
      output = MANTA_MERGE.out
}
