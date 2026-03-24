process GRIDSS {
  tag { "gridss" }
  container 'quay.io/biocontainers/gridss:2.9.3--0'

  input:
    tuple path(bam), path(bai), path(bed), path(bed_tbi)
    path reference_genome
    path indexs
    val threads
    path blacklist

  output:
    path "*.gridss.raw.vcf.gz"

  script:
  def threadsArgument = params.threads_gridss ? "--threads ${threads}" : ''
  """
  gridss --reference $reference_genome \\
         --output ${bam.simpleName}.gridss.raw.vcf.gz \\
         --assembly $params.assemblyFilename \\
         $threadsArgument \\
         --jar /usr/local/share/gridss-2.9.3-0/gridss.jar \\
         --blacklist $blacklist \\
         $bam
  """
}
