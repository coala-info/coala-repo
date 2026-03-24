process EXOMEDEPTH_FILTER {
  tag { "exomedepth filter" }

  input:
    path input
    path samples
    val max_len
    val min_len
    val min_bf

  output:
    path "*.exomeDepth.filtered.bed"

  script:
  """
  sh $projectDir/templates/exomedepth_filter.sh $input $samples $min_len $max_len $min_bf
  """
}
