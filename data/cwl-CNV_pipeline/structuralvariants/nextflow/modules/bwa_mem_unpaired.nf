process BWA_MEM_UNPAIRED {
  tag { "bwa mem" }
  container 'quay.io/biocontainers/bwa:0.7.17--h84994c4_5'

  input:
    val srr_id
    path unpaired
    path indexs

  output:
    path "*.sam"

  script:
  def threadsArgument = params.threads_bwa_mem ? "-t $params.threads_bwa_mem" : ""
  """
  INDEX=`find -L ./ -name "*.amb" | sed 's/.amb//'`
  nameReplaced=\$(echo  ${unpaired.simpleName} | sed 's/_/.R/g')

  bwa mem \\
    $threadsArgument \\
    \$INDEX \\
    $unpaired \\
    -R "@RG\\tID:${srr_id}\\tSM:NA19206\\tPL:ILLUMINA\\tCN:CBRA\\tLB:Fragment" >> \$nameReplaced.sam
  """
}
