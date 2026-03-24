process SAMTOOLS_SORT {
  tag { "samtools sort" }
  container 'quay.io/biocontainers/samtools:1.5--2'

  input:
    path input

  output:
    path "*.sorted.bam"

  script:
  def threadsArgument = params.threads_samtools ? "--threads $params.threads_samtools" : ""
  """
  name=\$(basename $input)
  outputName=\$(echo \${name%.*})
  
  samtools sort $threadsArgument $input -o \$outputName.sorted.bam
  """
}
