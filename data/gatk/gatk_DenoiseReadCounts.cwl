cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - DenoiseReadCounts
label: gatk_DenoiseReadCounts
doc: Denoises read counts to produce denoised copy ratios
inputs:
  - id: denoised_copy_ratios
    type: string
    doc: Output file for denoised copy ratios.
    inputBinding:
      position: 101
      prefix: --denoised-copy-ratios
  - id: input
    type:
      - 'null'
      - File
    doc: Input TSV or HDF5 file containing integer read counts in genomic 
      intervals for a single case sample (output of CollectReadCounts).
    inputBinding:
      position: 101
      prefix: --input
  - id: standardized_copy_ratios
    type: string
    doc: Output file for standardized copy ratios. GC-bias correction will be 
      performed if annotations for GC content are provided.
    inputBinding:
      position: 101
      prefix: --standardized-copy-ratios
  - id: annotated_intervals
    type:
      - 'null'
      - File
    doc: Input file containing annotations for GC content in genomic intervals 
      (output of AnnotateIntervals). Intervals must be identical to and in the 
      same order as those in the input read-counts file. If a panel of normals 
      is provided, this input will be ignored.
    inputBinding:
      position: 101
      prefix: --annotated-intervals
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 101
      prefix: --arguments_file
  - id: count_panel_of_normals
    type:
      - 'null'
      - File
    doc: Input HDF5 file containing the panel of normals (output of 
      CreateReadCountPanelOfNormals).
    inputBinding:
      position: 101
      prefix: --count-panel-of-normals
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
  - id: number_of_eigensamples
    type:
      - 'null'
      - int
    doc: Number of eigensamples to use for denoising. If not specified or if the
      number of eigensamples available in the panel of normals is smaller than 
      this, all eigensamples will be used.
    inputBinding:
      position: 101
      prefix: --number-of-eigensamples
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
  - id: output_denoised_copy_ratios
    type: File
    doc: Output file for denoised copy ratios.
    outputBinding:
      glob: $(inputs.denoised_copy_ratios)
  - id: output_standardized_copy_ratios
    type: File
    doc: Output file for standardized copy ratios. GC-bias correction will be 
      performed if annotations for GC content are provided.
    outputBinding:
      glob: $(inputs.standardized_copy_ratios)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:latest
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
