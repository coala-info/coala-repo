cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - PathSeqBuildReferenceTaxonomy
label: gatk_PathSeqBuildReferenceTaxonomy
doc: Build an annotated taxonomy datafile for a given microbe reference. The 
  output file from this tool is required to run the PathSeq pipeline.
inputs:
  - id: output
    type: string
    doc: Local path for the output file. By convention, the extension should be 
      ".db"
    inputBinding:
      position: 101
      prefix: --output
  - id: reference
    type:
      - 'null'
      - File
    secondaryFiles:
      - .fai
    doc: Reference sequence file
    inputBinding:
      position: 101
      prefix: --reference
  - id: tax_dump
    type:
      - 'null'
      - File
    doc: Local path to taxonomy dump tarball (taxdump.tar.gz available at 
      ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/)
    inputBinding:
      position: 101
      prefix: --tax-dump
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
      these buckets cannot be accessed. User must have storage.buckets.get 
      permission on the bucket being accessed.
    inputBinding:
      position: 101
      prefix: --gcs-project-for-requester-pays
  - id: genbank_catalog
    type:
      - 'null'
      - File
    doc: Local path to Genbank catalog file (gbXXX.catalog.XXX.txt.gz at 
      ftp://ftp.ncbi.nlm.nih.gov/genbank/catalog/)
    inputBinding:
      position: 101
      prefix: --genbank-catalog
  - id: min_non_virus_contig_length
    type:
      - 'null'
      - int
    doc: Minimum reference contig length for non-viruses
    inputBinding:
      position: 101
      prefix: --min-non-virus-contig-length
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
    inputBinding:
      position: 101
      prefix: --QUIET
  - id: refseq_catalog
    type:
      - 'null'
      - File
    doc: Local path to catalog file (RefSeq-releaseXX.catalog.gz available at 
      ftp://ftp.ncbi.nlm.nih.gov/refseq/release/release-catalog/)
    inputBinding:
      position: 101
      prefix: --refseq-catalog
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
    doc: Local path for the output file. By convention, the extension should be 
      ".db"
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
