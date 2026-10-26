cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - varlociraptor
  - call
  - variants
label: varlociraptor_call_variants_generic
doc: 'Call variants for a given scenario specified with the varlociraptor calling
  grammar and a VCF/BCF with candidate variants.


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
  - id: scenario
    type: File
    doc: Scenario defined in the varlociraptor calling grammar.
    inputBinding:
      position: 100
      prefix: --scenario
  - id: sample_observations
    type:
      type: array
      items: varlociraptor_obs_sample
      inputBinding:
        valueFrom: $(self.sample_name)=$(self.observations.path)
    doc: BCF files with varlociraptor preprocess results for samples defined in the
      given scenario (sample name and BCF path).
    inputBinding:
      position: 101
      prefix: --obs
arguments:
  - position: 50
    valueFrom: generic
outputs:
  - id: calls_bcf
    type:
      - 'null'
      - File
    doc: Variant calls in BCF format
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: SchemaDefRequirement
    types:
      - name: varlociraptor_obs_sample
        type: record
        fields:
          - name: sample_name
            type: string
            doc: Sample name as defined in the scenario
          - name: observations
            type: File
            doc: BCF file with varlociraptor preprocess results
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varlociraptor:8.9.5--h24073b4_0
