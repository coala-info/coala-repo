process MANTA {
  tag { "manta" }
  container 'quay.io/biocontainers/manta:1.6.0--py27_0'

  input:
    tuple path(bam), path(bai), path(bed), path(bed_tbi)
    path reference_genome
    path indexs
    val exome

  output:
    path "*.manta.raw.vcf.gz"

  script:
  def exomeArgument = exome ? "--exome" : ""
  """
  srr=\$(echo $bam | cut -f 1 -d '.')
  configManta.py --bam $bam --referenceFasta $reference_genome --runDir generated --callRegions $bed $exomeArgument
  python generated/runWorkflow.py
  cp generated/results/variants/diploidSV.vcf.gz ./\$srr.manta.raw.vcf.gz
  """
}
