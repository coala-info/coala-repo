process SAMTOOLS_FAIDX {
  tag { "samtools faidx" }
  container 'quay.io/biocontainers/samtools:1.5--2'

  input:
    path reference_genome
  output:
    path "*.fai", emit: fai

  script:
  """
  samtools faidx $reference_genome
  """
}
