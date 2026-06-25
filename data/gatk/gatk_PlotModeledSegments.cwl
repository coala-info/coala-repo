cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - PlotModeledSegments
label: gatk_PlotModeledSegments
doc: Creates plots of denoised and segmented copy-ratio and 
  minor-allele-fraction estimates
inputs:
  - id: output
    type: string
    doc: Output directory. This will be created if it does not exist.
    inputBinding:
      position: 101
      prefix: --output
  - id: output_prefix
    type: string
    doc: Prefix for output filenames.
    inputBinding:
      position: 101
      prefix: --output-prefix
  - id: segments
    type:
      - 'null'
      - File
    doc: Input file containing modeled segments (output of ModelSegments).
    inputBinding:
      position: 101
      prefix: --segments
  - id: sequence_dictionary
    type:
      - 'null'
      - File
    doc: File containing a sequence dictionary, which specifies the contigs to 
      be plotted and their relative lengths.
    inputBinding:
      position: 101
      prefix: --sequence-dictionary
  - id: allelic_counts
    type:
      - 'null'
      - File
    doc: Input file containing allelic counts at heterozygous sites (.hets.tsv 
      output of ModelSegments).
    inputBinding:
      position: 101
      prefix: --allelic-counts
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 101
      prefix: --arguments_file
  - id: denoised_copy_ratios
    type:
      - 'null'
      - File
    doc: Input file containing denoised copy ratios (output of 
      DenoiseReadCounts).
    inputBinding:
      position: 101
      prefix: --denoised-copy-ratios
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
    doc: Project to bill when accessing "requester pays" buckets.
    inputBinding:
      position: 101
      prefix: --gcs-project-for-requester-pays
  - id: maximum_copy_ratio
    type:
      - 'null'
      - float
    doc: Maximum copy ratio to be plotted. If Infinity, the maximum copy ratio 
      will be automatically determined.
    inputBinding:
      position: 101
      prefix: --maximum-copy-ratio
  - id: minimum_contig_length
    type:
      - 'null'
      - int
    doc: Threshold length (in bp) for contigs to be plotted.
    inputBinding:
      position: 101
      prefix: --minimum-contig-length
  - id: point_size_allele_fraction
    type:
      - 'null'
      - float
    doc: Point size to use for plotting allele-fraction points.
    inputBinding:
      position: 101
      prefix: --point-size-allele-fraction
  - id: point_size_copy_ratio
    type:
      - 'null'
      - float
    doc: Point size to use for plotting copy-ratio points.
    inputBinding:
      position: 101
      prefix: --point-size-copy-ratio
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
  - id: output_output
    type: Directory
    doc: Output directory. This will be created if it does not exist.
    outputBinding:
      glob: $(inputs.output)
  - id: output_output_prefix
    type: File[]
    doc: Prefix for output filenames.
    outputBinding:
      glob: $(inputs.output_prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:latest
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
