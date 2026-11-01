cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - DownsampleSam
label: gatk_DownsampleSam
doc: 'Downsample a SAM or BAM file.This tool applies a downsampling algorithm to a SAM or BAM file to
  retain only a (deterministically random) subset of the reads. Reads from the same template (e.g. read-pairs,
  secondary and supplementary reads) are all either kept or discarded as a unit, with the goal of retaining
  readsfrom PROBABILITY * input templates. The results will contain approximately PROBABILITY * input
  reads, however for very small PROBABILITIES this may not be the case. A number of different downsampling
  strategies are supported using the STRATEGY option: ConstantMemory: Downsamples a stream or file of
  SAMRecords using a hash-projection strategy such that it can run in constant memory. The downsampling
  is stochastic, and therefore the actual retained proportion will vary around the requested proportion.
  Due to working in fixed memory this strategy is good for large inputs, and due to the stochastic nature
  the accuracy of this strategy is highest with a high number of output records, and diminishes at low
  output volumes. HighAccuracy: Attempts (but does not guarantee) to provide accuracy up to a specified
  limit. Accuracy is defined as emitting a proportion of reads as close to the requested proportion as
  possible. In order to do so this strategy requires memory that is proportional to the number of template
  names in the incoming stream of reads, and will thus require large amounts of memory when running on
  large input files. Chained: Attempts to provide a compromise strategy that offers some of the advantages
  of both the ConstantMemory and HighAccuracy strategies. Uses a ConstantMemory strategy to downsample
  the incoming stream to approximately the desired proportion, and then a HighAccuracy strategy to finish.
  Works in a single pass, and will provide accuracy close to (but often not as good as) HighAccuracy while
  requiring memory proportional to the set of reads emitted from the ConstantMemory strategy to the HighAccuracy
  strategy. Works well when downsampling large inputs to small proportions (e.g. downsampling hundreds
  of millions of reads and retaining only 2%. Should be accurate 99.9% of the time when the input contains
  more than 50,000 templates (read names). For smaller inputs, HighAccuracy is recommended instead.


  Tool homepage: https://www.broadinstitute.org/gatk/'
inputs:
  - id: input
    type: File
    doc: The input SAM or BAM file to downsample.
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
      - pattern: .crai
        required: false
      - pattern: ^.crai
        required: false
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: output
    type: string
    doc: The output, downsampled, SAM, BAM or CRAM file to write.
    inputBinding:
      position: 101
      prefix: --OUTPUT
  - id: accuracy
    type:
      - 'null'
      - double
    doc: 'The accuracy that the downsampler should try to achieve if the selected strategy supports it.
      Note that accuracy is never guaranteed, but some strategies will attempt to provide accuracy within
      the requested bounds.Higher accuracy will generally require more memory. Default value: 1.0E-4.'
    inputBinding:
      position: 101
      prefix: --ACCURACY
  - id: create_index
    type:
      - 'null'
      - boolean
    doc: 'Whether to create an index when writing VCF or coordinate sorted BAM output. Default value:
      false. Possible values: {true, false}'
    inputBinding:
      position: 101
      prefix: --CREATE_INDEX
      valueFrom: $(String(self))
  - id: create_md5_file
    type:
      - 'null'
      - boolean
    doc: 'Whether to create an MD5 digest for any BAM or FASTQ files created. Default value: false. Possible
      values: {true, false}'
    inputBinding:
      position: 101
      prefix: --CREATE_MD5_FILE
      valueFrom: $(String(self))
  - id: metrics_file
    type:
      - 'null'
      - string
    doc: The metrics file (of type QualityYieldMetrics) which will contain information about the downsampled
      file.
    inputBinding:
      position: 101
      prefix: --METRICS_FILE
  - id: probability
    type:
      - 'null'
      - double
    doc: 'The probability of keeping any individual read, between 0 and 1. Default value: 1.0.'
    inputBinding:
      position: 101
      prefix: --PROBABILITY
  - id: random_seed
    type:
      - 'null'
      - int
    doc: 'Random seed used for deterministic results. Setting to null will cause multiple invocations
      to produce different results. The header if the file will be checked for any previous runs of DownsampleSam.
      If DownsampleSam has been run before on this data with the same seed, the seed will be updated in
      a deterministic fashion so the DownsampleSam will perform correctly, and still deterministically.
      Default value: 1.'
    inputBinding:
      position: 101
      prefix: --RANDOM_SEED
  - id: reference_sequence
    type:
      - 'null'
      - File
    doc: The reference sequence file.
    secondaryFiles:
      - .fai
      - ^.dict
    inputBinding:
      position: 101
      prefix: --REFERENCE_SEQUENCE
  - id: strategy
    type:
      - 'null'
      - string
    doc: 'The downsampling strategy to use. See usage for discussion. Default value: ConstantMemory. Possible
      values: {HighAccuracy, ConstantMemory, Chained}'
    inputBinding:
      position: 101
      prefix: --STRATEGY
  - id: validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for all SAM files read by this program. Setting stringency to SILENT can
      improve performance when processing a BAM file in which variable-length data (read, qualities, tags)
      do not otherwise need to be decoded. Default value: STRICT. Possible values: {STRICT, LENIENT, SILENT}'
    inputBinding:
      position: 101
      prefix: --VALIDATION_STRINGENCY
outputs:
  - id: output_out
    type: File
    doc: The output, downsampled, SAM, BAM or CRAM file to write.
    outputBinding:
      glob: $(inputs.output)
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
      - pattern: .crai
        required: false
      - pattern: ^.crai
        required: false
      - pattern: .sbi
        required: false
      - pattern: .md5
        required: false
  - id: metrics_file_out
    type:
      - 'null'
      - File
    doc: 'The metrics file (of type QualityYieldMetrics) which will contain information about the downsampled
      file. Default value: null.'
    outputBinding:
      glob: $(inputs.metrics_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
