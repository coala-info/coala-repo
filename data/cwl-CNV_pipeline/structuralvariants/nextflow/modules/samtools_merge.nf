process SAMTOOLS_MERGE {
  tag { "samtools merge" }
  container 'quay.io/biocontainers/samtools:1.5--2'

  input:
    path paired
    path unpairedR1
    path unpairedR2

  output:
    path "${paired.simpleName}.sorted.bam", emit: output

  script:
  def threadsArgument = params.threads_samtools ? "--threads $params.threads_samtools" : ""
  """
  samtools merge -f $threadsArgument ${paired.simpleName}.sorted.bam $paired $unpairedR1 $unpairedR2
  """
}
