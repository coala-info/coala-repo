process GRIDSS_FILTER {
  tag { "gridss filter" }

  input:
    path input
    path samples
    val max_len
    val min_len
    val min_q

  output:
    path "*.gridss.filtered.bed"

  script:
  """
  sh $projectDir/templates/gridss_filter.sh $input $samples $min_len $max_len $min_q
  """
}
