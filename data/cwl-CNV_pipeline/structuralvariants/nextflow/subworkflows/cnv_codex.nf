/*
 * Include for cnv_codex
*/
include {
    BATCH_PARSER
}from "../modules/batch_parser"
include {
    CODEX
}from "../modules/codex"
include {
    CODEX_FILTER
}from "../modules/codex_filter"
include {
    BEDOPS_UNION as CODEX_UNION
} from "../modules/bedops_union"
include {
    COLLAPSE as CODEX_MERGE
} from "../modules/collapse"

/*
* Subworkflow cnv_codex
*/
workflow SUB_CNV_CODEX {
    take:
      bamsChr
      bed
      samples
      max_len
      min_len
      min_lratio

    main:
        BATCH_PARSER(bamsChr.collect(), samples)
        batchParserChr = BATCH_PARSER.out.flatten()
        bamsParsedChr = batchParserChr.combine(bamsChr.collect())
        CODEX(bamsParsedChr, bed)
        CODEX_FILTER(CODEX.out, samples, max_len, min_len, min_lratio)
        CODEX_UNION(CODEX_FILTER.out.collect())
        CODEX_MERGE(CODEX_UNION.out)

    emit:
        output = CODEX_MERGE.out
}
