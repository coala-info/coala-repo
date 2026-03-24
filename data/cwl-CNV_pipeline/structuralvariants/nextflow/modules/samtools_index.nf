params.bamsDir = ""

process SAMTOOLS_INDEX {
  tag { "samtools index" }
  container 'quay.io/biocontainers/samtools:1.5--2'

  publishDir "${params.outputDir}/${params.bamsDir}", enabled: params.bamsDir, mode: 'copy'

  input:
    path input

  output:
    tuple path(input), path("*.sorted*.bai"), emit: output

  script:
  """
  samtools index -b $input
  """
}
