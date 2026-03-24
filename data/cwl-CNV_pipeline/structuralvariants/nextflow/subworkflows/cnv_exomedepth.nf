/*
 * Include for cnv_exomedepth
*/
include {
    BATCH_PARSER
}from "../modules/batch_parser"
include {
    EXOME_DEPTH
}from "../modules/exome_depth"
include {
    EXOMEDEPTH_FILTER
}from "../modules/exomedepth_filter"
include {
    BEDOPS_UNION as EXOMEDEPTH_UNION
} from "../modules/bedops_union"
include {
    COLLAPSE as EXOMEDEPTH_MERGE
} from "../modules/collapse"

/*
* Subworkflow cnv_exomedepth
*/
workflow SUB_CNV_EXOMEDEPTH {
    take:
      bamsChr
      bed
      reference_genome
      samples
      max_len
      min_len
      min_bf

    main:
        BATCH_PARSER(bamsChr.collect(), samples)
        batchParserChr = BATCH_PARSER.out.flatten()
        bamsParsedChr = batchParserChr.combine(bamsChr.collect())
        EXOME_DEPTH(bamsParsedChr, bed, reference_genome)
        EXOMEDEPTH_FILTER(EXOME_DEPTH.out, samples, max_len, min_len, min_bf)
        EXOMEDEPTH_UNION(EXOMEDEPTH_FILTER.out.collect())
        EXOMEDEPTH_MERGE(EXOMEDEPTH_UNION.out)

    emit:
        output = EXOMEDEPTH_MERGE.out
}
