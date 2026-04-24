#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow
requirements:
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}
  MultipleInputFeatureRequirement: {}

label: Merge multiple SE reads
doc: |
    Merge (cat) fastq Single End reads (e.g. long reads) when multiple files.
    Also converts single file array to a non array object.

    Output is as single (non array) file object. 
    This (non array files) is usually required for tool inputs 

inputs:
  filename:
    type: string?
    doc: |
        Filename prefix to be used when reads are going to merged. File extensions are preserved.
        This is only used when multiple reads are given. default "merged"
    label: Filename prefix
  reads:
    type: File[]
    doc: Single end reads reads. E.g Nanopore or PacBio. Can be compressed. Do not mix filetypes.
    label: Singe end reads
    loadListing: no_listing

outputs:
    merged_reads:
        type: File
        outputSource: 
            - fastq_merge_se/output
            - fastq_se_array_to_file/file
        pickValue: first_non_null

#############################################
#### merging of FASTQ files to only one
steps:
  fastq_merge_se:
    label: Merge SE reads
    doc: Merge multiple forward single end reads to a single file
    when: $(inputs.infiles.length > 1)
    run: ../tools/bash/concatenate.cwl
    in:
      infiles: reads
      outname: 
        source: filename
        valueFrom: |
          ${
            return self+inputs.infiles[0].basename.match(/\.(fastq|fq)(\.gz)?$/)[0];
          }
    out: [output]

#############################################
#### Single fastq file array to file object
  fastq_se_array_to_file:
    label: SE reads array to file
    doc: Forward file of single file array to file object
    when: $(inputs.files.length === 1)
    run: ../tools/expressions/array_to_file_tool.cwl
    in:
      files: reads
    out: [file]

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateCreated: "2025-04-30"
s:dateModified: "2025-04-30"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/