cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - straingr
  - call
label: strainge_straingr_call
doc: 'StrainGR: strain-aware variant caller for metagenomic samples.


  Tool homepage: https://github.com/broadinstitute/strainge'
inputs:
  - id: reference
    type: File
    doc: Reference FASTA file. Can be GZIP compressed.
    inputBinding:
      position: 100
  - id: sample
    type: File
    doc: BAM file with the aligned reads of the sample against the reference
    inputBinding:
      position: 101
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
  - id: min_qual
    type:
      - 'null'
      - int
    doc: 'Minimum quality for a base to be considered. Default: 5.'
    inputBinding:
      position: 1
      prefix: --min-qual
  - id: min_pileup_qual
    type:
      - 'null'
      - int
    doc: 'Minimum sum of qualities for an allele to be trusted.for variant calling. Default: 50.'
    inputBinding:
      position: 1
      prefix: --min-pileup-qual
  - id: min_qual_frac
    type:
      - 'null'
      - float
    doc: 'Minimum fraction of the reads in the pileup required to confirm an allele (fractions are base
      quality weighted). Default: 0.1'
    inputBinding:
      position: 1
      prefix: --min-qual-frac
  - id: min_mapping_qual
    type:
      - 'null'
      - int
    doc: 'Minimum mapping quality of the whole read to be considered. Default: 5.'
    inputBinding:
      position: 1
      prefix: --min-mapping-qual
  - id: max_mismatches
    type:
      - 'null'
      - int
    doc: 'Ignore alignments with a higher number of mismatches than the given threshold. A value of 0
      disables this check. Default: 0.'
    inputBinding:
      position: 1
      prefix: --max-mismatches
  - id: min_gap
    type:
      - 'null'
      - int
    doc: 'Minimum size of gap to be considered as such. Default: 5000. Will be automatically scaled depending
      on coverage.'
    inputBinding:
      position: 1
      prefix: --min-gap
  - id: hdf5_out
    type: string
    doc: Output StrainGR variant calling data to the given HDF5 file. Required.
    inputBinding:
      position: 1
      prefix: --hdf5-out
  - id: summary
    type:
      - 'null'
      - string
    doc: Output a TSV with a summary of variant calling statistics to the given file. Defaults to stdout.
    inputBinding:
      position: 1
      prefix: --summary
  - id: vcf
    type:
      - 'null'
      - string
    doc: Output a VCF file with SNP's. Please be aware that we do not have a good insertion/deletion calling
      mechanism, but some information on possible indels is written to the VCF file.
    inputBinding:
      position: 1
      prefix: --vcf
  - id: verbose_vcf
    type:
      - 'null'
      - int
    doc: To be used with --vcf. Increase the verboseness of the generated VCF. By default it only outputs
      strong SNPs. A value of 1 will also output any weak calls.
    inputBinding:
      position: 1
      prefix: --verbose-vcf
  - id: tracks
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --tracks
    doc: 'Write track files that can be visualized in a genome viewer, use this option multiple times
      to generate multiple track types. Use ''all'' to generate all tracks. Available track types: coverage,
      callable, multimapped, lowmq, bad, high_coverage, gaps'
    inputBinding:
      position: 1
  - id: track_min_size
    type:
      - 'null'
      - int
    doc: 'For all tracks to generate, only include features (regions) of at least the given size. Default:
      1.'
    inputBinding:
      position: 1
      prefix: --track-min-size
outputs:
  - id: hdf5_out_result
    type: File
    doc: Output StrainGR variant calling data to the given HDF5 file. Required.
    outputBinding:
      glob: $(inputs.hdf5_out)
  - id: summary_result
    type:
      - 'null'
      - File
    doc: Output a TSV with a summary of variant calling statistics to the given file. Defaults to stdout.
    outputBinding:
      glob: $(inputs.summary)
  - id: vcf_result
    type:
      - 'null'
      - File
    doc: Output a VCF file with SNP's. Please be aware that we do not have a good insertion/deletion calling
      mechanism, but some information on possible indels is written to the VCF file.
    outputBinding:
      glob: $(inputs.vcf)
  - id: track_files
    type:
      type: array
      items: File
    doc: Track files written when --tracks is used (named after the HDF5 output).
    outputBinding:
      glob:
        - '*.wig'
        - '*.bed'
        - '*.bedgraph'
  - id: stdout
    type: stdout
    doc: Standard output
stdout: strainge_straingr_call.stdout.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
