process CODEX_FILTER {
  tag { "codex filter" }

  input:
    path input
    path samples
    val max_len
    val min_len
    val min_lratio

  output:
    path "*.CODEX.filtered.bed"

  script:
  """
  sh $projectDir/templates/codex_filter.sh $input $samples $min_len $max_len $min_lratio
  """
}
