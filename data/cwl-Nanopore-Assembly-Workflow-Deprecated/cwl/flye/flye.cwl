#!/usr/bin/env cwltool

cwlVersion: v1.2
class: CommandLineTool

# hints:
#   SoftwareRequirement:
#     packages:
#       flye:
#         version: ["2.9"]
#         specs: ["https://anaconda.org/bioconda/flye"]

baseCommand: [ /unlock/infrastructure/binaries/Flye-2.9/bin/flye ] 

label: "De novo assembler for single molecule sequencing reads, with a focus in Oxford Nanopore Technologies reads"

doc: |
    Flye v2.9 assembler with a focus in reads from Oxford Nanopore Technologies.

arguments:
  - valueFrom: "flye_output" #name of output directory
    prefix: --out-dir

inputs:
  nano_raw: # FASTQ read, not FAST5
    type: File?
    inputBinding:
      prefix: --nano-raw
  nano_corrected:
    type: File?
    inputBinding:
      prefix: --nano-corr
  nano_high_quality:
    type: File?
    inputBinding:
      prefix: --nano-hq
  threads:
    type: int
    default: 1
    inputBinding:
      prefix: --threads
  polishing_iterations:
    label: Flye will carry out polishing multiple times as determined here
    type: int
    default: 1
    inputBinding:
      prefix: --iterations
  metagenome:
    label: Set to true if assembling a metagenome
    type: boolean
    # default: true
    inputBinding:
      prefix: --meta
  debug_mode:
    label: Set to true to display debug output while running
    type: boolean
    default: false
    inputBinding:
      prefix: --debug

outputs:
  flye_outdir:
    label: Directory containing all output produced by flye
    type: Directory
    outputBinding:
      glob: flye_output
  00_assembly:
    type: Directory
    outputBinding:
      glob: flye_output/00-assembly
  10_consensus:
    type: Directory
    outputBinding:
      glob: flye_output/10-consensus
  20_repeat:
    type: Directory
    outputBinding:
      glob: flye_output/20-repeat
  30_contigger:
    type: Directory
    outputBinding:
      glob: flye_output/30-contigger
  40_polishing:
    type: Directory
    outputBinding:
      glob: flye_output/40-polishing
  assembly:
    label: Polished assembly created by flye, main output for after polishing with next tool
    type: File
    outputBinding:
      glob: flye_output/assembly.fasta
  assembly_info:
    type: File
    outputBinding:
      glob: flye_output/assembly_info.txt
  flye_log:
    type: File
    outputBinding:
      glob: flye_output/flye.log
  params:
    type: File
    outputBinding:
      glob: flye_output/params.json

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0002-5516-8391
    s:email: mailto:german.royvalgarcia@wur.nl
    s:name: Germán Royval
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-8172-8981
    s:email: mailto:jasper.koehorst@wur.nl
    s:name: Jasper Koehorst
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateCreated: "2021-11-29"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
