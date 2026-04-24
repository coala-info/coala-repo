#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool
label: NoHuman

doc: Read reference filtering

requirements:
  InlineJavascriptRequirement: {}

hints:
  SoftwareRequirement:
    packages:
      nohuman:
        version: ["0.3.0"]
        specs: ["https://anaconda.org/bioconda/nohuman"]
  DockerRequirement:
    dockerPull: quay.io/biocontainers/nohuman:0.3.0--hc1c3326_1

baseCommand: [nohuman]
#stderr: $(inputs.output_filename_prefix+"_nohuman.log")

#--db /unlock/references/databases/Kraken2/k2_HPRC_20230810 -t 12 --out1 /data/filtered_1.fastq.gz --out2 /data/filtered_2.fastq.gz /data/SRR8960508_1.fastq.gz /data/SRR8960508_2.fastq.gz
arguments:
  - prefix: "--out1"
    valueFrom: $(inputs.output_filename_prefix+"_1.fastq.gz")
  - prefix: "--out2"
    valueFrom: $(inputs.output_filename_prefix+"_2.fastq.gz")
  - valueFrom: |
      ${
        if (inputs.kraken_output) {
          return '' + '--kraken-output';
        } else {
          return null;
        }
      }
  - valueFrom: |
      ${
        if (inputs.kraken_output) {
          return inputs.output_filename_prefix + '_kraken2_output.tsv';
        } else {
          return null;
        }
      }

inputs:
  output_filename_prefix:
    type: string
    doc: Name of the output file. (_1/_2).fastq.gz will be appended.
    label: Output filename (base)

  forward_reads:
    type: File?
    label: Forward reads
    doc: Illumina forward read file
    inputBinding:
      position: 100
  reverse_reads:
    type: File?
    label: Reverse reads
    doc: Illumina reverse read file
    inputBinding:
      position: 101 

  output_human:
    type: boolean
    doc:  Output human reads instead of removing them. (Default false)
    label: Output human reads
    inputBinding:
      prefix: --human

  kraken2_database:
    type: Directory
    doc: Kraken2 database Directory of the for filtering.
    label: Kraken2 database
    inputBinding:
      prefix: --db
      position: 10

  threads:
    type: int
    doc: Number of parallel threads to use. Default 4
    label: Threads
    inputBinding:
      prefix: --threads
      position: 101

  kraken_output:
    type: boolean
    doc: Write the Kraken2 read classification output to a file. (Default false)
    label: Kraken output

outputs:
  forward_reads_out:
    type: File[]
    outputBinding: {glob: '*_1.fastq.gz'}
  reverse_reads_out:
    type: File[]
    outputBinding: {glob: '*_2.fastq.gz'}
  kraken_output_out:
    type: File[]
    outputBinding: {glob: '*.tsv'}
  # log:
  #   type: File
  #   outputBinding:
  #     glob: $(inputs.output_filename_prefix + "_chopper.log")


s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateModified: "2025-03-05"
s:dateCreated: "2025-03-05"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
