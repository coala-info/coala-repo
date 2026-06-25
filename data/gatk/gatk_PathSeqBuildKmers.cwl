cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - PathSeqBuildKmers
label: gatk_PathSeqBuildKmers
doc: Produce a set of k-mers from the given host reference. The output file from
  this tool is required to run the PathSeq pipeline.
inputs:
  - id: output
    type: string
    doc: File for k-mer set output. Extension will be automatically added if not
      present (.hss for hash set or .bfi for Bloom filter)
    inputBinding:
      position: 101
      prefix: --output
  - id: reference
    type:
      - 'null'
      - File
    secondaryFiles:
      - .fai
    doc: Reference FASTA file path on local disk
    inputBinding:
      position: 101
      prefix: --reference
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 101
      prefix: --arguments_file
  - id: bloom_false_positive_probability
    type:
      - 'null'
      - float
    doc: If non-zero, creates a Bloom filter with this false positive 
      probability
    inputBinding:
      position: 101
      prefix: --bloom-false-positive-probability
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
      these buckets cannot be accessed. User must have storage.buckets.get 
      permission on the bucket being accessed.
    inputBinding:
      position: 101
      prefix: --gcs-project-for-requester-pays
  - id: kmer_mask
    type:
      - 'null'
      - string
    doc: Comma-delimited list of base indices (starting with 0) to mask in each 
      k-mer
    inputBinding:
      position: 101
      prefix: --kmer-mask
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: K-mer size, must be odd and less than 32
    inputBinding:
      position: 101
      prefix: --kmer-size
  - id: kmer_spacing
    type:
      - 'null'
      - int
    doc: Spacing between successive k-mers
    inputBinding:
      position: 101
      prefix: --kmer-spacing
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
    type: File
    doc: File for k-mer set output. Extension will be automatically added if not
      present (.hss for hash set or .bfi for Bloom filter)
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:latest
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
