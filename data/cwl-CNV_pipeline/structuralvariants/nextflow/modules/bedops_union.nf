process BEDOPS_UNION {
  tag { "bedops union" }
  container 'quay.io/biocontainers/bedops:2.4.39--h7d875b9_1'

  input:
    path input

  output:
    path "${input[0].baseName.tokenize('.')[1]}.all.filtered.bed"

  script:
  """
  bedops -u $input > ${input[0].baseName.tokenize('.')[1]}.all.filtered.bed
  """
}
