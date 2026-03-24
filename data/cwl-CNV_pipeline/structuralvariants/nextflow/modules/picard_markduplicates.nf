process PICARD_MARKDUPLICATES {
  tag { "picard MarkDuplicates "}
  container 'quay.io/biocontainers/picard:2.10.6--py35_0'

  input:
    path input

  output:
    path "*.sorted.dedup.bam", emit: alignments
    path "*.sorted.dedup.metrics.txt", emit: metrics

  script:
  """
  name=\$(basename $input)
  outputName=\$(echo \${name%.*})

  picard MarkDuplicates \\
    INPUT=${input[0]} \\
    OUTPUT=\$outputName.dedup.bam \\
    METRICS_FILE=\$outputName.dedup.metrics.txt \\
    ASSUME_SORTED=TRUE
  """
}
