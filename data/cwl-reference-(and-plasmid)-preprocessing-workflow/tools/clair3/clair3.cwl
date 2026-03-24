#!/usr/bin/env cwltool

cwlVersion: v1.2
class: CommandLineTool

label: Clair3 - Symphonizing pileup and full-alignment for high-performance long-read variant calling 

doc: |
  Clair3 is a germline small variant caller for long-reads.
  Clair3 makes the best of two major method categories:
  pileup calling handles most variant candidates with speed, and full-alignment tackles complicated candidates to maximize precision and recall.
  Clair3 runs fast and has superior performance, especially at lower coverage. Clair3 is simple and modular for easy deployment and integration.
  Documentation on how to install and run Clair3 can be found here:
  https://github.com/HKU-BAL/Clair3

requirements:
  InlineJavascriptRequirement: {}
  ShellCommandRequirement: {} # required?
  InitialWorkDirRequirement:
    listing:
      - entry: $(inputs.bam_file)
      - entry: $(inputs.indexed_bam_file)
      - entry: $(inputs.reference_file)
      - entry: $(inputs.indexed_fasta_file)

hints:
  DockerRequirement:
    dockerPull: docker-registry.wur.nl/m-unlock/docker/clair3_rerio:1.0.10
  SoftwareRequirement:
    packages:
      clair3:
        version: ["1.0.10"]
        specs: ["identifiers.org/RRID:SCR_026063"]
  
baseCommand: run_clair3.sh

inputs:
  bam_file:
    type: File
    label: input BAM file
    doc: BAM file input.
    inputBinding:
      prefix: --bam_fn=
      separate: false
  reference_file:
    type: File
    label: reference file
    doc: Reference FASTA file input.
    inputBinding:
      prefix: --ref_fn=
      separate: false
  indexed_bam_file:
    type: File
    label: indexed BAM file
    doc: Indexed BAM file input.
  indexed_fasta_file:
    type: File?
    label: indexed reference file
    doc: Indexed reference FASTA file input.
  model_path:
    type: string
    label: Clair3 Model Directory
    doc: Path to the Clair3 model inside the Docker container. Currently the only supported model is 'r1041_e82_400bps_sup_v500'.
    inputBinding:
      prefix: --model_path=
      separate: false
  threads:
    type: int?
    label: number of CPU threads
    doc: |
      Specifies the number of CPU threads to use for parallel processing.
      Higher values can speed up execution but require more computational resources.
    inputBinding:
      prefix: --threads=
      separate: false
  platform:
    type: 
      - type: enum
        symbols:
          - ont
          - hifi
          - ilm
    label: sequencing platform
    doc: Sequencing platform of the samples. Possible options are "ont, hifi, ilmn"
    inputBinding:
      prefix: --platform=
      separate: false
  output_folder:
    type: string
    label: output folder
    doc: Sets the output directory, defaults to "clair3_output".
    inputBinding:
      prefix: --output=
      separate: false
    default: clair3_output
  include_all_ctgs:
    type: boolean?
    label: include all contigs
    doc: Set to true to include all contigs (recommended for non-human species).
    default: true
    inputBinding:
      prefix: --include_all_ctgs
      separate: false
  haploid_sensitive:
    type: boolean? 
    label: haploid calling mode
    doc: Set to true to enable haploid calling mode, this is an experimental flag.
    inputBinding:
      prefix: --haploid_sensitive
      separate: false
  no_phasing_for_fa:
    type: boolean?
    label: no phasing in full alignment
    doc: Set to true to skip whatshap phasing in full alignment, this is an experimental flag.
    inputBinding:
      prefix: --no_phasing_for_fa
      separate: false

outputs:
  output_dir:
    type: Directory
    label: output directory
    doc: Clair3 output directory containing the vcf file.
    outputBinding:
      glob: "$(inputs.output_folder)"
  merge_output_vcf:
    type: File
    label: output VCF file
    doc: Clair3 final output VCF file (merge_output.vcf.gz) is produced in the output directory.
    outputBinding:
      glob: "$(inputs.output_folder)/merge_output.vcf.gz"
  log_file:
    type: File
    label: output log file
    doc: Output log file of settings and runtimes.
    outputBinding:
      glob: "$(inputs.output_folder)/run_clair3.log"

$namespaces:
  s: https://schema.org/   
  edam: http://edamontology.org/ 
s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse
  - class: s:Person
    s:identifier: https://orcid.org/0009-0005-0017-0928
    s:email: mailto:martijn.melissen@wur.nl
    s:name: Martijn Melissen
s:citation: https://m-unlock.nl
s:codeRepository: https://git.wur.nl/ssb/automated-data-analysis
s:dateCreated: "2025-02-11"
s:dateModified: "2025-03-06"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"