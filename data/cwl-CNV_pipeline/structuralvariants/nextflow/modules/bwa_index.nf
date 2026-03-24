process BWA_INDEX {
  tag { "bwa index" }
  container 'quay.io/biocontainers/bwa:0.7.17--h84994c4_5'

  input:
    path input

  output:
    path "*.{amb,ann,bwt,pac,sa}", emit: indexs

  script:
  def algoType = params.algoType ? "-a $params.algoType" : ""
  """
  bwa index $algoType $input
  """
}
