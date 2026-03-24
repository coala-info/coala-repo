fastqcOutputFolder = "${params.outputDir}/output_fastqc"

process FASTQC {
  tag { "fastqc" }
  container 'quay.io/biocontainers/fastqc:0.11.8--1'

  publishDir fastqcOutputFolder, mode: 'copy'

  input:
    tuple val(srr_id), path(fastq1), path(fastq2)
    val threads

  output:
    path "*_fastqc.*"

  script:
  def threadsArgument = params.threads_fastqc ? "--threads ${threads}" : ''
  """
  fastqc ${threadsArgument} $fastq1 $fastq2
  """
}
