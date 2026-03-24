/*
 * Include for bwa_mem
*/
include {
    BWA_MEM_PAIRED as BWA_MEM_PAIRED
} from "../modules/bwa_mem_paired"
include {
    BWA_MEM_UNPAIRED as BWA_MEM_UNPAIRED1
} from "../modules/bwa_mem_unpaired"
include {
    BWA_MEM_UNPAIRED as BWA_MEM_UNPAIRED2
} from "../modules/bwa_mem_unpaired"

/*
* Subworkflow bwa_mem
*/
workflow SUB_BWA_MEM {
  take:
    reads
    indexFiles

  main:

    srr_id = reads.map{it[0]}
    paired1 = reads.map{it[1]}
    paired2 = reads.map{it[2]}
    unpaired1 = reads.map{it[3]}
    unpaired2 = reads.map{it[4]}

    BWA_MEM_PAIRED(srr_id, paired1, paired2, indexFiles)
    BWA_MEM_UNPAIRED1(srr_id, unpaired1, indexFiles)
    BWA_MEM_UNPAIRED2(srr_id, unpaired2, indexFiles)

  emit:
    paired = BWA_MEM_PAIRED.out
    unpairedR1 = BWA_MEM_UNPAIRED1.out
    unpairedR2 = BWA_MEM_UNPAIRED2.out
}
