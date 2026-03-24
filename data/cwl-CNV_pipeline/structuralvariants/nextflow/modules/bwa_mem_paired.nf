process BWA_MEM_PAIRED {
  tag { "bwa mem" }
  container 'quay.io/biocontainers/bwa:0.7.17--h84994c4_5'

  input:
    val srr_id
    path paired1
    path paired2
    path indexs

  output:
    path "*.R1R2.sam"

  script:
  def threadsArgument = params.threads_bwa_mem ? "-t $params.threads_bwa_mem" : ""
  """
  INDEX=`find -L ./ -name "*.amb" | sed 's/.amb//'`

  bwa mem \\
    $threadsArgument \\
    \$INDEX \\
    $paired1 $paired2 \\
    -R "@RG\\tID:${srr_id}\\tSM:NA19206\\tPL:ILLUMINA\\tCN:CBRA\\tLB:Fragment" >> ${srr_id}.R1R2.sam
  """
}
