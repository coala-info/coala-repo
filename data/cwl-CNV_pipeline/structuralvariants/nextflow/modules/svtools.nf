process SVTOOLS {
  tag { "svtools" }
  container 'quay.io/biocontainers/svtools:0.5.1--py_0'

  input:
    path input

  output:
    path "*.manta.raw.bed"

  script:
  """
  svtools vcftobedpe -i $input -o \$(basename $input .vcf.gz).bed
  """
}
