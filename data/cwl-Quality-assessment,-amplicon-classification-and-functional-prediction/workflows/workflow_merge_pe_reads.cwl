#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow
requirements:
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}
  MultipleInputFeatureRequirement: {}

label: Merge multiple PE reads
doc: |
    !! this is not interleaving !!
    Merge (cat) fastq paired end reads when multiple files.
    Also converts single file array to a non array object.

    Output is as single (non array) file object for each read end. 
    This (non array files) is usually required for tool inputs 

inputs:
  filename:
    type: string?
    doc: |
        Filename prefix to be used when reads are going to merged. File extensions are preserved.
        This is only used when multiple reads are given. default "merged"
    label: Filename prefix
    default: "merged"
  forward_reads:
    type: File[]
    doc: Forward sequence reads file(s). Can be compressed. Do not mix filetypes.
    label: Forward reads
    loadListing: no_listing
  reverse_reads:
    type: File[]
    doc: Reverse sequence reads file(s). Can be compressed. Do not mix filetypes.
    label: Reverse reads
    loadListing: no_listing

outputs:
    forward_reads_out:
        type: File
        outputSource: 
            - fastq_merge_fwd/output
            - fastq_fwd_array_to_file/file
        pickValue: first_non_null
    reverse_reads_out:
        type: File
        outputSource: 
            - fastq_merge_rev/output
            - fastq_rev_array_to_file/file
        pickValue: first_non_null

#############################################
#### merging of FASTQ files to only one
steps:
  fastq_merge_fwd:
    label: Merge forward reads
    doc: Merge multiple forward fastq reads to a single file
    when: $(inputs.infiles.length > 1)
    run: ../tools/bash/concatenate.cwl
    in:
      infiles: forward_reads
      outname: 
        source: filename
        valueFrom: |
          ${
            return self+"_1"+inputs.infiles[0].basename.match(/\.(fastq|fq)(\.gz)?$/)[0];
          }
    out: [output]

  fastq_merge_rev:
    label: Merge reverse reads
    doc: Merge multiple reverse fastq reads to a single file
    when: $(inputs.infiles.length > 1)
    run: ../tools/bash/concatenate.cwl
    in:
      infiles: reverse_reads
      outname: 
        source: filename
        valueFrom: |
          ${
            return self+"_2"+inputs.infiles[0].basename.match(/\.(fastq|fq)(\.gz)?$/)[0];
          }
    out: [output]
#############################################
#### Single fastq file array to file object
  fastq_fwd_array_to_file:
    label: Fwd reads array to file
    doc: Forward file of single file array to file object
    when: $(inputs.files.length === 1)
    run: ../tools/expressions/array_to_file_tool.cwl
    in:
      files: forward_reads
    out: [file]
  fastq_rev_array_to_file:
    label: Rev reads array to file
    doc: Forward file of single file array to file object
    when: $(inputs.files.length === 1)
    run: ../tools/expressions/array_to_file_tool.cwl
    in:
      files: reverse_reads
    out: [file]

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateCreated: "2025-04-04"
s:dateModified: "2025-04-30"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/