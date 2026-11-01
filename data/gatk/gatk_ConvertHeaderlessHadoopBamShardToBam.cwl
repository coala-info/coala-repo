cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - ConvertHeaderlessHadoopBamShardToBam
label: gatk_ConvertHeaderlessHadoopBamShardToBam
doc: 'This is a troubleshooting utility that converts a headerless BAM shard (e.g., a part-r-00000.bam,
  part-r-00001.bam, etc.), produced by a Spark tool with --sharded-output set to true, into a readable
  BAM file by adding a header and a BGZF terminator.


  Tool homepage: https://www.broadinstitute.org/gatk/'
inputs:
  - id: bam_shard
    type: File
    doc: Headerless Hadoop BAM shard to be converted into a readable BAM
    inputBinding:
      position: 101
      prefix: --bam-shard
  - id: bam_with_header
    type: File
    doc: Well-formed BAM whose header to use for the converted fragment
    inputBinding:
      position: 101
      prefix: --bam-with-header
  - id: output
    type: string
    doc: Location to write the converted BAM shard
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: output_out
    type: File
    doc: Location to write the converted BAM shard
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
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
