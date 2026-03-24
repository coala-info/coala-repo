process MANTA_FILTER {
  tag { "manta filter" }

  input:
    path input
    path samples
    val max_len
    val min_len
    val min_q

  output:
    path "*.manta.filtered.bed"

  script:
  """
  sh $projectDir/templates/manta_filter.sh $input $samples $min_len $max_len $min_q
  """
}
