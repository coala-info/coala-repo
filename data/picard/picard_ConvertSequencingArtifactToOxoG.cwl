cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - ConvertSequencingArtifactToOxoG
label: picard_ConvertSequencingArtifactToOxoG
doc: Extract OxoG metrics from generalized artifacts metrics. This tool extracts
  8-oxoguanine (OxoG) artifact metrics from the output of 
  CollectSequencingArtifactsMetrics and converts them to the CollectOxoGMetrics 
  tool's output format.
inputs:
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 101
      prefix: --arguments_file
  - id: bait_bias_in
    type:
      - 'null'
      - File
    doc: The bait bias input file. Defaults to a filename based on the input 
      basename
    inputBinding:
      position: 101
      prefix: --BAIT_BIAS_IN
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Compression level for all compressed files created (e.g. BAM and VCF).
    inputBinding:
      position: 101
      prefix: --COMPRESSION_LEVEL
  - id: create_index
    type:
      - 'null'
      - boolean
    doc: Whether to create an index when writing VCF or coordinate sorted BAM 
      output.
    inputBinding:
      position: 101
      prefix: --CREATE_INDEX
  - id: create_md5_file
    type:
      - 'null'
      - boolean
    doc: Whether to create an MD5 digest for any BAM or FASTQ files created.
    inputBinding:
      position: 101
      prefix: --CREATE_MD5_FILE
  - id: input_base
    type:
      - 'null'
      - File
    doc: Basename of the input artifact metrics file (output by 
      CollectSequencingArtifactMetrics). If this is not specified, you must 
      specify PRE_ADAPTER_IN and BAIT_BIAS_IN
    inputBinding:
      position: 101
      prefix: --INPUT_BASE
  - id: max_records_in_ram
    type:
      - 'null'
      - int
    doc: When writing files that need to be sorted, this will specify the number
      of records stored in RAM before spilling to disk.
    inputBinding:
      position: 101
      prefix: --MAX_RECORDS_IN_RAM
  - id: output_base
    type: string
    doc: Basename for output OxoG metrics. Defaults to same basename as input 
      metrics
    inputBinding:
      position: 101
      prefix: --OUTPUT_BASE
  - id: oxog_out
    type: string
    doc: File for the output OxoG metrics. Defaults to a filename based on the 
      output basename
    inputBinding:
      position: 101
      prefix: --OXOG_OUT
  - id: pre_adapter_in
    type:
      - 'null'
      - File
    doc: The pre adapter details input file. Defaults to a filename based on the
      input basename
    inputBinding:
      position: 101
      prefix: --PRE_ADAPTER_IN
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
    inputBinding:
      position: 101
      prefix: --QUIET
  - id: reference_sequence
    type: File
    doc: Reference sequence file.
    inputBinding:
      position: 101
      prefix: --REFERENCE_SEQUENCE
  - id: tmp_dir
    type:
      - 'null'
      - type: array
        items: Directory
    doc: One or more directories with space available to be used by this program
      for temporary storage of working files
    inputBinding:
      position: 101
      prefix: --TMP_DIR
  - id: use_jdk_deflater
    type:
      - 'null'
      - boolean
    doc: Use the JDK Deflater instead of the Intel Deflater for writing 
      compressed output
    inputBinding:
      position: 101
      prefix: --USE_JDK_DEFLATER
  - id: use_jdk_inflater
    type:
      - 'null'
      - boolean
    doc: Use the JDK Inflater instead of the Intel Inflater for reading 
      compressed input
    inputBinding:
      position: 101
      prefix: --USE_JDK_INFLATER
  - id: validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for all SAM files read by this program. Possible values:
      {STRICT, LENIENT, SILENT}'
    inputBinding:
      position: 101
      prefix: --VALIDATION_STRINGENCY
  - id: show_hidden
    type:
      - 'null'
      - boolean
    doc: display hidden arguments
    inputBinding:
      position: 101
      prefix: --showHidden
outputs:
  - id: output_output_base
    type:
      - 'null'
      - File
    doc: Basename for output OxoG metrics. Defaults to same basename as input 
      metrics
    outputBinding:
      glob: $(inputs.output_base)
  - id: output_oxog_out
    type:
      - 'null'
      - File
    doc: File for the output OxoG metrics. Defaults to a filename based on the 
      output basename
    outputBinding:
      glob: $(inputs.oxog_out)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
s:url: http://broadinstitute.github.io/picard/
$namespaces:
  s: https://schema.org/
