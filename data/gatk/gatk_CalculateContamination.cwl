cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - CalculateContamination
label: gatk_CalculateContamination
doc: Calculate the fraction of reads coming from cross-sample contamination
inputs:
  - id: input
    type: File
    doc: The input table
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type: string
    doc: The output table
    inputBinding:
      position: 101
      prefix: --output
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 101
      prefix: --arguments_file
  - id: gatk_config_file
    type:
      - 'null'
      - string
    doc: A configuration file to use with the GATK.
    inputBinding:
      position: 101
      prefix: --gatk-config-file
  - id: gcs_max_retries
    type:
      - 'null'
      - int
    doc: If the GCS bucket channel errors out, how many times it will attempt to
      re-initiate the connection
    inputBinding:
      position: 101
      prefix: --gcs-max-retries
  - id: gcs_project_for_requester_pays
    type:
      - 'null'
      - string
    doc: Project to bill when accessing "requester pays" buckets. If unset, 
      these buckets cannot be accessed.
    inputBinding:
      position: 101
      prefix: --gcs-project-for-requester-pays
  - id: high_coverage_ratio_threshold
    type:
      - 'null'
      - float
    doc: The maximum coverage relative to the mean.
    inputBinding:
      position: 101
      prefix: --high-coverage-ratio-threshold
  - id: low_coverage_ratio_threshold
    type:
      - 'null'
      - float
    doc: The minimum coverage relative to the median.
    inputBinding:
      position: 101
      prefix: --low-coverage-ratio-threshold
  - id: matched_normal
    type:
      - 'null'
      - File
    doc: The matched normal input table
    inputBinding:
      position: 101
      prefix: --matched-normal
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
    inputBinding:
      position: 101
      prefix: --QUIET
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Temp directory to use.
    inputBinding:
      position: 101
      prefix: --tmp-dir
  - id: tumor_segmentation
    type: string
    doc: The output table containing segmentation of the tumor by minor allele 
      fraction
    inputBinding:
      position: 101
      prefix: --tumor-segmentation
  - id: use_jdk_deflater
    type:
      - 'null'
      - boolean
    doc: Whether to use the JdkDeflater (as opposed to IntelDeflater)
    inputBinding:
      position: 101
      prefix: --use-jdk-deflater
  - id: use_jdk_inflater
    type:
      - 'null'
      - boolean
    doc: Whether to use the JdkInflater (as opposed to IntelInflater)
    inputBinding:
      position: 101
      prefix: --use-jdk-inflater
  - id: show_hidden
    type:
      - 'null'
      - boolean
    doc: display hidden arguments
    inputBinding:
      position: 101
      prefix: --showHidden
outputs:
  - id: output_output
    type: File
    doc: The output table
    outputBinding:
      glob: $(inputs.output)
  - id: output_tumor_segmentation
    type:
      - 'null'
      - File
    doc: The output table containing segmentation of the tumor by minor allele 
      fraction
    outputBinding:
      glob: $(inputs.tumor_segmentation)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:latest
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
