#!/usr/bin/env cwltool

cwlVersion: v1.2
class: CommandLineTool

label: SnpEff, a variant annotation and effect prediction tool

doc: |
  Genetic variant annotation, and functional effect prediction toolbox. 
  It annotates and predicts the effects of genetic variants on genes and proteins (such as amino acid changes).
  Documentation on how to install and run SnpEff can be found here:
  https://pcingola.github.io/SnpEff/snpeff/introduction/

requirements:
  InlineJavascriptRequirement: {}

hints:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/snpeff:5.2--hdfd78af_1
  SoftwareRequirement:
    packages:
      snpeff:
        version: ["5.2.1"]
        specs: ["identifiers.org/RRID:SCR_005191"]
  
baseCommand: [ "java", "-jar", "/usr/local/share/snpeff-5.2-1/snpEff.jar", "ann" ]

inputs:
  genome:
    type: string
    label: genome or database
    doc: The genome or database to use for annotation (e.g. 'GRCh37.75' for human, or your custom database for microbial strains).
    inputBinding:
      position: 1
  variants:
    type: File
    label: Variant File (VCF or BED)
    doc: The variant file to annotate, which can be in VCF or BED format. Default is VCF, if using BED, also set ($inputs.input_format) to 'bed'.
    inputBinding:
      position: 2
  config_file:
    type: File?
    label: SNPeff Config File
    doc: |
      Path to an external SNPeff configuration file.
      For a custom database, a new entry must be made in this config file in the format of "($inputs.genome).genome:($inputs.genome)".
      An alternative codon table should be added if relevant.
    inputBinding:
      prefix: -config
  database_dir:
    type: Directory
    label: SNPeff database folder
    doc: The directory containing a built or downloaded SNPeff database. (needs to contain snpEffectPredictor.bin and ($inputs.genome).bin)
    inputBinding:
      prefix: -dataDir
  no_log:
    type: boolean?
    label: no logging to server
    doc: Set to true to not report usage statistics to SNPeff server.
    inputBinding:
      prefix: -noLog
#  threads:  # this flag is mentioned in the documentation but not implemented in the tool as of version 5.2.1
#    type: int?
#    doc: Use multiple threads, default is 'off'
#    inputBinding:
#      prefix: -t
  no_download:
    type: boolean?
    label: do not download database
    doc: Makes sure that the default behavior of downloading a database when not present is turned off, otherwise with improper settings a database will be downloaded seperately in each container.
    inputBinding:
      prefix: -nodownload
  input_format:
    type: 
      - type: enum
        symbols: [ vcf, bed ]
    label: input format type
    doc: Set input format type, defaults to VCF.
    inputBinding:
      prefix: -i
  file_list:
    type: boolean?
    label: file list input
    doc: Set to true to enable a list of files as input.
    inputBinding:
      prefix: -fileList
  output_format:
    type: 
      - type: enum
        symbols: [ vcf, gatk, bed, bedAnn ]
    label: output format type
    doc: Set output format type, defaults to VCF.
    inputBinding:
      prefix: -o
  stats_file:
    type: string?
    label: SNPeff summary report 
    doc: Summary report file path, defaults to "./snpEff_summary.html".
    inputBinding:
      prefix: -stats
  csv_stats:
    type: string?
    label: CSV summary report
    doc: Create a CSV summary report file path.
    inputBinding:
      prefix: -csvStats
  no_stats:
    type: boolean?
    label: no summary statistics
    doc: Set to true to not omit reporting summary statistics, overridden when specifying a summary rerport file.
    inputBinding:
      prefix: -noStats
  no_upstream:
    type: boolean?
    label: no upstream changes
    doc: Set to true to omit upstream changes.
    inputBinding:
      prefix: -no-upstream
  no_downstream:
    type: boolean?
    label: no downstream changes
    doc: Set to true to omit downstream changes.
    inputBinding:
      prefix: -no-downstream

## Annotation options
  cancer:
    type: boolean?
    label: enable cancer comparisons
    doc: Set to true to perform 'cancer' comparisons (Somatic vs Germline).
    inputBinding:
      prefix: -cancer
  cancer_samples:
    type: File?
    label: cancer samples file
    doc: Two-column TXT file defining 'original \\t derived' samples.
    inputBinding:
      prefix: -cancerSamples
  fasta_prot:
    type: string?
    label: fasta protein output
    doc: Specify an output file containing the resulting protein sequences.
    inputBinding:
      prefix: -fastaProt
  format_eff:
    type: boolean?
    label: use EFF command
    doc: Set to true to use 'EFF' field compatible with older versions (instead of 'ANN').
    inputBinding:
      prefix: -formatEff
  gene_id:
    type: boolean?
    label: use Gene ID
    doc: Set to true to use gene ID instead of gene name in VCF output.
    inputBinding:
      prefix: -geneId
  hgvs:
    type: boolean?
    label: use HGVS
    doc: Uses HGVS annotations for amino acid sub-field, defaults to true.
    inputBinding:
      prefix: -hgvs
  hgvs_old:
    type: boolean?
    label: use old HGVS
    doc: Set to true to use old HGVS annotations.
    inputBinding:
      prefix: -hgvsOld
  hgvs_1_letter_aa:
    type: boolean?
    label: use one letter amino acids
    doc: Set to true to use one leter Amino acid codes in HGVS annotation.
    inputBinding:
      prefix: -hgvs1LetterAa
  hgvs_transcript_id:
    type: boolean?
    label: use transcript ID
    doc: Set to true to use transcript ID in HGVS annotation.
    inputBinding:
      prefix: -hgvsTrId
  lof:
    type: boolean?
    label: add LOF tags
    doc: Set to true to add loss of function (LOF) and Nonsense mediated decay (NMD) tags.
    inputBinding:
      prefix: -lof
  no_hgvs:
    type: boolean?
    label: no HGVS
    doc: Set to true to not add HGVS annotations.
    inputBinding:
      prefix: -noHgvs
  no_lof:
    type: boolean?
    label: no LOF
    doc: Set to true to not add LOF and NMD annotations.
    inputBinding:
      prefix: -noLof
  no_shift_hgvs:
    type: boolean?
    label: no shift HGVS
    doc: Set to true to not shift variants according to HGVS notation.
    inputBinding:
      prefix: -cancer
  oicr:
    type: boolean?
    label: OICR Tag
    doc: Set to true to add OICR tag in VCF file.
    inputBinding:
      prefix: -oicr
  sequence_ontology:
    type: boolean?
    label: sequence ontology
    doc: Uses sequence ontology terms, defaults to true.
    inputBinding:
      prefix: -sequenceOntology

outputs:
  annotated_vcf:
    type: File
    label: annotated VCF
    doc: The final annotated VCF file produced by SnpEff 
    outputBinding:
      glob: "snpeff_output.vcf"
  summary_report:
    type: File?
    outputBinding:
      glob: "*.html"
  summary_report_csv:
    type: File?
    outputBinding:
      glob: "*.csv"
  fasta_prot_file:
    type: File?
    label: protein file
    doc: The output file containing protein sequences(if $inputs.fasta_prot is used).
    outputBinding:
      glob: "*.fa"
stdout: snpeff_output.vcf

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
s:dateModified: "2025-02-26"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"