cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - varlociraptor
  - call
  - variants
label: varlociraptor_call_variants_tumor-normal
doc: 'Call somatic and germline variants from a tumor-normal sample pair and a VCF/BCF
  with candidate variants.


  Tool homepage: https://varlociraptor.github.io'
inputs:
  - id: full_prior
    type:
      - 'null'
      - boolean
    doc: Compute the full prior distribution for any allele frequency combination.
    inputBinding:
      position: 10
      prefix: --full-prior
  - id: omit_alt_locus_bias
    type:
      - 'null'
      - boolean
    doc: Do not consider alt locus bias when calculating the probability of an artifact.
    inputBinding:
      position: 10
      prefix: --omit-alt-locus-bias
  - id: omit_homopolymer_artifact_detection
    type:
      - 'null'
      - boolean
    doc: Do not perform PCR homopolymer artifact detection when calculating the probability
      of an artifact.
    inputBinding:
      position: 10
      prefix: --omit-homopolymer-artifact-detection
  - id: omit_read_orientation_bias
    type:
      - 'null'
      - boolean
    doc: Do not consider read orientation bias when calculating the probability of
      an artifact.
    inputBinding:
      position: 10
      prefix: --omit-read-orientation-bias
  - id: omit_read_position_bias
    type:
      - 'null'
      - boolean
    doc: Do not consider read position bias when calculating the probability of an
      artifact.
    inputBinding:
      position: 10
      prefix: --omit-read-position-bias
  - id: omit_softclip_bias
    type:
      - 'null'
      - boolean
    doc: Do not consider softclip bias when calculating the probability of an artifact.
    inputBinding:
      position: 10
      prefix: --omit-softclip-bias
  - id: omit_strand_bias
    type:
      - 'null'
      - boolean
    doc: Do not consider strand bias when calculating the probability of an artifact.
    inputBinding:
      position: 10
      prefix: --omit-strand-bias
  - id: testcase_anonymous
    type:
      - 'null'
      - boolean
    doc: Anonymize any identifiers (via uuid4) and the sequences (by randomly permuting
      the alphabet) in the test case.
    inputBinding:
      position: 10
      prefix: --testcase-anonymous
  - id: log_mode
    type:
      - 'null'
      - string
    doc: 'Specify how progress should be logged: default or each-record'
    inputBinding:
      position: 10
      prefix: --log-mode
  - id: output_path
    type:
      - 'null'
      - string
    doc: Output variant calls to given path (in BCF format). If omitted, prints calls
      to STDOUT.
    inputBinding:
      position: 10
      prefix: --output
  - id: propagate_info_fields
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional INFO fields in the input BCF that shall be propagated to the output
      BCF.
    inputBinding:
      position: 10
      prefix: --propagate-info-fields
  - id: testcase_locus
    type:
      - 'null'
      - string
    doc: Create a test case for the given locus in the form CHROM:POS, or all for
      single variant VCFs.
    inputBinding:
      position: 10
      prefix: --testcase-locus
  - id: testcase_prefix
    type:
      - 'null'
      - string
    doc: Create test case files in the given directory.
    inputBinding:
      position: 10
      prefix: --testcase-prefix
  - id: normal
    type:
      - 'null'
      - File
    doc: BCF file with varlociraptor preprocess results for the normal sample.
    inputBinding:
      position: 100
      prefix: --normal
  - id: purity
    type:
      - 'null'
      - float
    doc: 'Purity of tumor sample. [default: 1.0]'
    inputBinding:
      position: 100
      prefix: --purity
  - id: tumor
    type:
      - 'null'
      - File
    doc: BCF file with varlociraptor preprocess results for the tumor sample.
    inputBinding:
      position: 100
      prefix: --tumor
arguments:
  - position: 50
    valueFrom: tumor-normal
outputs:
  - id: calls_bcf
    type:
      - 'null'
      - File
    doc: Variant calls in BCF format
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varlociraptor:8.9.5--h24073b4_0
