cwlVersion: v1.2
class: CommandLineTool
baseCommand: umi_reformat_sra_fastq
label: umitools_reformat_sra_fastq
doc: "A script to process reads in from UMI small RNA-seq. This script can handle\n\
  gzipped files transparently. This script is also known as umitools\nextract_small.\n\
  \nTool homepage: https://github.com/weng-lab/umitools"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: More output for debugging
    inputBinding:
      position: 101
      prefix: --debug
  - id: errors_allowed
    type:
      - 'null'
      - int
    doc: "Setting it to >=1 allows errors in UMIs. Otherwise, no\nerrors are allowed
      in UMIs."
    inputBinding:
      position: 101
      prefix: --errors-allowed
  - id: input
    type: File
    doc: the input fastq file.
    inputBinding:
      position: 101
      prefix: --input
  - id: umi_pattern_3
    type:
      - 'null'
      - string
    doc: "Set the UMI pattern at the 3' end. Use ACGT for fixed\nnt and N for variable
      nt in UMI. If there are multiple\npatterns, separate them using comma"
    inputBinding:
      position: 101
      prefix: --umi-pattern-3
  - id: umi_pattern_5
    type:
      - 'null'
      - string
    doc: "Set the UMI pattern at the 5' end. Use ACGT for fixed\nnt and N for variable
      nt in UMI. If there are multiple\npatterns, separate them using comma"
    inputBinding:
      position: 101
      prefix: --umi-pattern-5
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Also include detailed run info
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type: File
    doc: "the output fastq file containing reads that are not\nduplicates"
    outputBinding:
      glob: $(inputs.output)
  - id: pcr_duplicate
    type: File
    doc: The output fastq file containing PCR duplicates
    outputBinding:
      glob: $(inputs.pcr_duplicate)
  - id: reads_with_improper_umi
    type:
      - 'null'
      - File
    doc: "The output fastq file containing reads with improper\nUMIs. The default
      is to throw away these reads. This\nis for debugging purposes"
    outputBinding:
      glob: $(inputs.reads_with_improper_umi)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/umitools:0.3.4--py36_0
