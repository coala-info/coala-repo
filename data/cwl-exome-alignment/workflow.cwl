cwlVersion: v1.0
class: Workflow
id: alignment-workflow
label: alignment_workflow

doc: |
  Exome Alignment Workflow

requirements:
  MultipleInputFeatureRequirement: {}

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/

$schemas:
 - https://schema.org/version/latest/schemaorg-current-https.rdf
 - http://edamontology.org/EDAM_1.18.owl

inputs:
  fastq_files: {type: 'File[]', doc: "List of paired-end input FASTQ files"}
  reference_fasta: {type: File, doc: "Compress FASTA files with the reference genome chromosomes"}
  readgroup: {type: string, doc: "Parsing header which should correlate to FASTQ files"}
  sample_name: {type: string, doc: "Sample name"}

outputs:
  sorted_bam: {type: File, outputSource: picard_markduplicates/output, doc: "Sorted aligned BAM file"}

steps:
  gunzip:
    run: tools/gunzip.cwl
    in:
      reference_genome: reference_fasta
    out: [output]

  picard_dictionary:
    run: tools/picard_dictionary.cwl
    in:
      reference_genome:
        source: gunzip/output
    out: [output]

  cutadapt:
    run: tools/cutadapt.cwl
    in:
      raw_sequences: fastq_files
    out: [output]

  bwa_index:
    run: tools/bwa-index.cwl
    in:
      reference_genome:
        source: gunzip/output
    out: [output]

  samtools_faidx:
    run: tools/samtools_faidx.cwl
    in:
      sequences:
        source: gunzip/output
    out: [output]

  bwa_mem:
    run: tools/bwa-mem.cwl
    in:
      sample_name: sample_name
      trimmed_fastq:
        source: cutadapt/output
      read_group: readgroup
      reference_genome:
        source: bwa_index/output
    out: [output]

  samtools_sort:
    run: tools/samtools_sort.cwl
    in:
      bam_unsorted:
        source: bwa_mem/output
    out: [output]

  picard_markduplicates:
    run: tools/picard_markduplicates.cwl
    in:
      alignments:
        source: samtools_sort/output
    out: [output]

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0003-4929-1219
    s:email: mailto:laura.rodriguez@bsc.es
    s:name: Laura Rodríguez-Navas

s:dateCreated: "2021-02-19"
s:license: https://spdx.org/licenses/Apache-2.0
