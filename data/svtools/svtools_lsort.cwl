cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svtools
  - lsort
label: svtools_lsort
doc: 'Combine and sort multiple VCF files.


  Tool homepage: https://github.com/hall-lab/svtools'
inputs:
  - id: vcf_files
    type:
      - 'null'
      - type: array
        items: File
    doc: VCF files to combine and sort (may be gzipped)
    inputBinding:
      position: 101
  - id: vcf_list
    type:
      - 'null'
      - File
    doc: File containing a line-delimited list of VCF files to combine and sort
    inputBinding:
      position: 1
      prefix: --vcf-list
  - id: listed_vcf_files
    type:
      - 'null'
      - type: array
        items: File
    doc: VCF files named in the --vcf-list file; staged in the working directory so
      the listed names resolve
  - id: include_reference
    type:
      - 'null'
      - boolean
    doc: Whether or not to include homozygous reference or missing calls in the output
    inputBinding:
      position: 1
      prefix: --include-reference
  - id: tempdir
    type:
      - 'null'
      - string
    doc: Temporary directory
    inputBinding:
      position: 1
      prefix: --tempdir
  - id: batchsize
    type:
      - 'null'
      - int
    doc: Number of files to sort in batch
    inputBinding:
      position: 1
      prefix: --batchsize
outputs:
  - id: out_vcf
    type: stdout
    doc: Combined and sorted VCF
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.listed_vcf_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtools:0.5.1--py_0
stdout: svtools_lsort.vcf
