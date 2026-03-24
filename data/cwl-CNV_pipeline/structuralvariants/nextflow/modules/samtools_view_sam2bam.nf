process SAMTOOLS_VIEW_SAM2BAM {
  tag { "samtools view sam2bam" }
  container 'quay.io/biocontainers/samtools:1.5--2'

  input:
    path input

  output:
    path "*.bam"

  script:
  def threadsArgument = params.threads_samtools ? "--threads $params.threads_samtools" : ""
  """
  name=\$(basename $input)
  outputName=\$(echo \${name%.*})
  
  samtools view $threadsArgument -bS $input -o \$outputName.bam
  """
}
