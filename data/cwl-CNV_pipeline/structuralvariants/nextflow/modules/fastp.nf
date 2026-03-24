fastpOutputFolder = "${params.outputDir}/output_fastp"

process FASTP {
  tag { "fastp" }
  container 'quay.io/biocontainers/fastp:0.20.0--hdbcaa40_0'

  publishDir fastpOutputFolder, mode: 'copy'

  input:
    tuple val(srr_id), path(fastq1), path(fastq2)
    val threads
    val cut_right_window_size
    val cut_right_mean_quality
    val trim_tail1
    val length_required

  output:
    tuple val(srr_id),
          path("${fastq1.simpleName}.trimmed.fastq"),
          path("${fastq2.simpleName}.trimmed.fastq"), emit: paired_fastq

    tuple val(srr_id),
          path("${fastq1.simpleName}.trimmed.fastq"),
          path("${fastq2.simpleName}.trimmed.fastq"),
          path("${fastq1.simpleName}.unpaired.trimmed.fastq"),
          path("${fastq2.simpleName}.unpaired.trimmed.fastq"), emit: reads

    path "*.html"
    path "*.json"

  script:
  def fastpthreadsArgument = params.threads_fastp ? "--thread ${threads}" : ''
  def fastpcut_rigthArgument = params.cut_right ? "--cut_right" : ''
  def fastpcut_rigth_window_sizeArgument = params.cut_right_window_size ? "--cut_right_window_size ${cut_right_window_size}" : ''
  def fastpcut_rigth_mean_qualityArgument = params.cut_right_mean_quality ? "--cut_right_mean_quality ${cut_right_mean_quality}" : ''
  def fastptrim_tail1Argument = params.trim_tail1 ? "--trim_tail1 ${trim_tail1}" : ''
  def fastplength_requiredArgument = params.length_required ? "--length_required ${length_required}" : ''
  """
  fastp \\
    -i $fastq1 \\
    -I $fastq2 \\
    -o ${fastq1.simpleName}.trimmed.fastq \\
    -O ${fastq2.simpleName}.trimmed.fastq \\
    --unpaired1 ${fastq1.simpleName}.unpaired.trimmed.fastq \\
    --unpaired2 ${fastq2.simpleName}.unpaired.trimmed.fastq \\
    --json ${srr_id}.fastp.json \\
    --html ${srr_id}.fastp.html \\
    ${fastpthreadsArgument} \\
    ${fastpcut_rigthArgument} \\
    ${fastpcut_rigth_mean_qualityArgument} \\
    ${fastpcut_rigth_window_sizeArgument} \\
    ${fastplength_requiredArgument} \\
    ${fastptrim_tail1Argument}
  """
}
