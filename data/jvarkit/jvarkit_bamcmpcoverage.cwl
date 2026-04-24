cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamcmpcoverage
label: jvarkit_bamcmpcoverage
doc: "Calculate coverage statistics for BAM files.\n\nTool homepage: https://github.com/lindenb/jvarkit"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: Input BAM files
    inputBinding:
      position: 1
  - id: bed_file
    type:
      - 'null'
      - boolean
    doc: restrict to region
    inputBinding:
      position: 102
      prefix: --bed
  - id: filter
    type:
      - 'null'
      - string
    doc: A JEXL Expression that will be used to filter out some sam-records (see
      https://software.broadinstitute.org/gatk/documentation/article.php?id=1255).
      An expression should return a boolean value (true=exclude, false=keep the 
      read). An empty expression keeps everything. The variable 'record' is the 
      current observed read, an instance of SAMRecord 
      (https://samtools.github.io/htsjdk/javadoc/htsjdk/htsjdk/samtools/SAMRecord.html).
      record.getReadFailsVendorQualityCheckFlag() || 
      record.isSecondaryOrSupplementary()
    inputBinding:
      position: 102
      prefix: --filter
  - id: groupby
    type:
      - 'null'
      - string
    doc: 'Group Reads by. Data partitioning using the SAM Read Group (see https://gatkforums.broadinstitute.org/gatk/discussion/6472/
      ). It can be any combination of sample, library.... Possible Values: [readgroup,
      sample, library, platform, center, sample_by_platform, sample_by_center, sample_by_platform_by_center,
      any]'
    inputBinding:
      position: 102
      prefix: --groupby
  - id: help_format
    type:
      - 'null'
      - string
    doc: What kind of help. One of [usage,markdown,xml].
    inputBinding:
      position: 102
      prefix: --helpFormat
  - id: max_depth
    type:
      - 'null'
      - int
    doc: max depth
    inputBinding:
      position: 102
      prefix: --maxDepth
  - id: min_depth
    type:
      - 'null'
      - int
    doc: min depth
    inputBinding:
      position: 102
      prefix: --minDepth
  - id: region
    type:
      - 'null'
      - string
    doc: restrict to region
    inputBinding:
      position: 102
      prefix: --region
  - id: width
    type:
      - 'null'
      - int
    doc: image width
    inputBinding:
      position: 102
      prefix: --width
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: 'Output file. Optional . Default: stdout'
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
