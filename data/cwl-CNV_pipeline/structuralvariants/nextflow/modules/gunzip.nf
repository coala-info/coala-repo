process GUNZIP {
  tag { "gunzip "}
  container 'ubuntu:xenial'

  input:
    path input_fasta

  output:
    path "${input_fasta.simpleName}.fa"

  script:
  """
  reference_fasta=\$(echo $input_fasta | sed 's/.gz//g')

  if [ "${input_fasta.extension}" == "gz" ]; then
    gunzip -c $input_fasta >> \$reference_fasta
  fi
  """
}
