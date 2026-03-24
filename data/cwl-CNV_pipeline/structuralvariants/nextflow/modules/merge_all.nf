process MERGE_ALL {
  tag { "merge all" }
  container 'quay.io/biocontainers/bedtools:2.26.0gx--he513fc3_4'

  publishDir "${params.outputDir}", mode: 'copy'

  input:
    path input

  output:
    path "all.all.filtered.sorted.merged.bed"

  script:
  """
  INPUT_FILE="${input}"
  OUTPUT_FILE=\$(basename "\$INPUT_FILE" .bed).sorted.merged.bed

  tr -s ' ' '\\t' < "\$INPUT_FILE" | cut -f4-5 | sort -u | grep -E '(DEL|DUP)\$' | \
  while read i j ; do
    grep -E "\$i[[:space:]]+\$j" "\$INPUT_FILE" | tr -s ' ' '\\t' | bedtools sort | bedtools merge -c 6,7 -o collapse | awk -v sample=\$i -v type=\$j '{ \
      print \$1,\$2,\$3,sample,type,\$4,\$5 \
    }' OFS="\\t" >> "\${OUTPUT_FILE}"
  done
  """
}
