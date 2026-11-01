cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - CollectSVEvidence
label: gatk_CollectSVEvidence
doc: |-
  Gathers paired-end and split read evidence files for use in the GATK-SV pipeline. Output files are a file containing the location of and orientation of read pairs marked as discordant, and a file containing the clipping location of all soft clipped reads and the orientation of the clipping.

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
  - id: input
    type:
      type: array
      items: File
      inputBinding:
        prefix: --input
    inputBinding:
      position: 101
    doc: BAM/SAM/CRAM file containing reads This argument must be specified at least
      once.
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
  - id: sample_name
    type: string
    inputBinding:
      position: 101
      prefix: --sample-name
    doc: Sample name
  - id: depth_evidence_file
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --depth-evidence-file
    doc: Output file for depth evidence
  - id: depth_evidence_intervals
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --depth-evidence-intervals
    doc: Input feature file specifying intervals where depth evidence will be gathered
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .idx
        required: false
  - id: depth_evidence_min_mapq
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --depth-evidence-min-mapq
    doc: 'minimum mapping quality for read to be counted as depth evidence Default
      value: 0.'
  - id: depth_summary_file
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --depth-summary-file
    doc: Output file for depth evidence summary statistics
  - id: disable_sequence_dictionary_validation
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --disable-sequence-dictionary-validation
    doc: 'If specified, do not check the sequence dictionaries from our inputs for
      compatibility. Use at your own risk! Default value: false. Possible values:
      {true, false}'
  - id: exclude_intervals
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --exclude-intervals
    inputBinding:
      position: 101
    doc: One or more genomic intervals to exclude from processing This argument may
      be specified 0 or more times.
  - id: intervals
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --intervals
    inputBinding:
      position: 101
    doc: One or more genomic intervals over which to operate This argument may be
      specified 0 or more times.
  - id: pe_file
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --pe-file
    doc: Output file for paired end evidence
  - id: reference
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --reference
    doc: Reference sequence
    secondaryFiles:
      - pattern: .fai
        required: false
      - pattern: ^.dict
        required: false
      - pattern: .gzi
        required: false
      - pattern: ^^.dict
        required: false
  - id: sd_file
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --sd-file
    doc: Output file for site depth counts
  - id: sequence_dictionary
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --sequence-dictionary
    doc: Use the given sequence dictionary as the master/canonical sequence dictionary.
      Must be a .dict file.
  - id: site_depth_locs_vcf
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --site-depth-locs-vcf
    doc: Input VCF of SNPs marking loci for site depth counts
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .idx
        required: false
  - id: site_depth_min_baseq
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --site-depth-min-baseq
    doc: 'minimum base call quality for SNP to be counted toward site depth Default
      value: 20.'
  - id: site_depth_min_mapq
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --site-depth-min-mapq
    doc: 'minimum mapping quality for read to be counted toward site depth Default
      value: 30.'
  - id: sr_file
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --sr-file
    doc: Output file for split read evidence
outputs:
  - id: depth_evidence_file_out
    type:
      - 'null'
      - File
    doc: Output file for depth evidence
    outputBinding:
      glob: $(inputs.depth_evidence_file)
  - id: depth_summary_file_out
    type:
      - 'null'
      - File
    doc: Output file for depth evidence summary statistics
    outputBinding:
      glob: $(inputs.depth_summary_file)
  - id: pe_file_out
    type:
      - 'null'
      - File
    doc: Output file for paired end evidence
    outputBinding:
      glob: $(inputs.pe_file)
  - id: sd_file_out
    type:
      - 'null'
      - File
    doc: Output file for site depth counts
    outputBinding:
      glob: $(inputs.sd_file)
  - id: sr_file_out
    type:
      - 'null'
      - File
    doc: Output file for split read evidence
    outputBinding:
      glob: $(inputs.sr_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://gatk.broadinstitute.org/
$namespaces:
  s: https://schema.org/
