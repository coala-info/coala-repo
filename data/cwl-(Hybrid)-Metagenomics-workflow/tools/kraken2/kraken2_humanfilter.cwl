#!/usr/bin/env cwltool

cwlVersion: v1.2
class: CommandLineTool

label: "Kraken2 human filter"
doc: |
    Filter human reads from a dataset using Kraken2.
    This relies on the docker container with built-in the human pan genome database. (k2_HPRC_20230810)
    
    Inspired by the tool nohuman https://github.com/mbhall/nohuman where also the database comes from.

    NOTE: This needs the docker container to function properly.

hints:
  SoftwareRequirement:
    packages:
      kraken2:
        version: ["2.1.5"]
        specs: ["https://anaconda.org/bioconda/kraken2", "doi.org/10.1186/s13059-019-1891-0","identifiers.org/RRID:SCR_026838"]

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - entry: "$({class: 'Directory', listing: []})"
        entryname: "kraken2_output"
        writable: true
      - entryname: kraken2_nohuman.sh
        entry: |-
          #!/bin/bash
          kraken2 $@
          threads=$4
          
          for file in *.f*q; do
            echo "Compressing: $file"
            pigz -p $threads "$file"
          done

  DockerRequirement:
    dockerPull: docker-registry.wur.nl/m-unlock/docker/kraken2_humanpandb:2.1.5

baseCommand: [bash, kraken2_nohuman.sh] # See script in requirements

arguments:
  - valueFrom: "/dev/null"
    prefix: --output
    position: 2
  - valueFrom: $(inputs.identifier)_nohuman_report.txt
    prefix: --report
    position: 3
  - valueFrom: "/k2_HPRC_20230810/db"
    prefix: --db
    position: 4
  - ${
      if (inputs.keep_human_reads){
        return '--classified-out';
      } else {
        return '--unclassified-out';
      }
    }
  - |
    ${
      if (inputs.keep_human_reads){
        if (inputs.paired_end) {
          return inputs.identifier + "_humanreads#.fq";
        } else {
          return inputs.identifier + "_humanreads.fastq";
        }
      } else {
        if (inputs.paired_end) {
          return inputs.identifier + "_nohuman#.fq";
        } else {
          return inputs.identifier + "_nohuman.fastq";
        }
      }
    }

inputs:
  threads:
    type: int?
    inputBinding:
      prefix: --threads
      position: 1
  identifier:
    type: string
    doc: Identifier for this dataset used for output file prefix
    label: identifier

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
  paired_end:
    type: boolean?
    label: Paired end
    doc: Data is paired end (separate files)
    inputBinding:
      position: 2
      prefix: "--paired"

  single_end_reads:
    type: File?
    label: Nanopore reads
    doc: Single end reads, for example long reads. (fastx/gzip)
    inputBinding:
      position: 102

  keep_human_reads:
    type: boolean
    label: Keep human reads
    doc: Output human reads. Default false

  confidence:
    type: float?
    label: Confidence
    doc: Confidence score threshold (default 0.0) must be in [0, 1]
    inputBinding:
      position: 4
      prefix: --confidence
  
  gzip:
    type: boolean?
    label: Gzip input
    doc: "input data is gzip compressed"
    inputBinding:
      position: 3
      prefix: '--gzip-compressed'
  bzip2:
    type: boolean
    label: Bzip2 input
    doc: "input data is gzip compressed"
    inputBinding:
      position: 3
      prefix: '--bzip2-compressed'
  
  memory_mapping:
    type: boolean
    label: Memory mapping
    doc: "Avoids loading database into RAM. Default false"
    inputBinding:
      position: 6
      prefix: '--memory-mapping'


outputs:
  report:
    type: File
    outputBinding:
      glob: $(inputs.identifier)_nohuman_report.txt
  filtered_forward_reads:
    type: File?
    outputBinding:
      glob: '*_1.fq.gz'
  filtered_reverse_reads:
    type: File?
    outputBinding:
      glob: '*_2.fq.gz'
  filter_single_end_reads:
    type: File?
    outputBinding:
      glob: '*.fastq.gz'

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateCreated: "2025-04-23"
s:dateModified: "2025-04-23"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/