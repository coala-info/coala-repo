process SAMTOOLS_VIEW {
    tag { "samtools view" }
    container 'quay.io/biocontainers/samtools:1.5--2'

    input:
      tuple path(bam), path(bai)

    output:
      path '*.filtered.bam'

    script:
    def min_mapping_qualityArgument = params.min_mapping_quality ? "-q $params.min_mapping_quality" : ''
    def bits_setArgument = params.bits_set ? "-F $params.bits_set" : ''
    def threadsArgument = params.threads_samtools ? "--threads $params.threads_samtools" : ''
    """
    name=\$(basename ${bam})
    outputName=\$(echo \${name%.*})

    samtools view $threadsArgument $min_mapping_qualityArgument $bits_setArgument $bam -o \$outputName.filtered.bam
    """
}
