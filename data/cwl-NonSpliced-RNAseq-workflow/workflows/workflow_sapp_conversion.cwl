#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow
requirements:
   - class: StepInputExpressionRequirement
   - class: InlineJavascriptRequirement
   - class: MultipleInputFeatureRequirement

label: SAPP conversion Workflow
doc: |
      Workflow for converting annotation tool output into a GBOL RDF file (TTL/HDT) using SAPP.
      Current implemented tools:
          - Bakta (embl)
          - InterProScan
          - eggNOG-mapper
          - Kofamscan

outputs:
  # embl_conversion:
  #   type: File?
  #   outputSource: embl_conversion/output
  # genome_conversion:
  #   type: File?
  #   outputSource: genome_conversion/output
  # sapp_kofamscan:
  #   type: File?
  #   outputSource: sapp_kofamscan/kofamscan_ttl
  # sapp_interproscan:
  #   type: File?
  #   outputSource: sapp_interproscan/interproscan_ttl
  # sapp_eggnog:
  #   type: File?
  #   outputSource: sapp_eggnog/eggnog_ttl
  # turtle_to_hdt:
  #   type: File?
  #   outputSource: turtle_to_hdt/output
  hdt_file:
    type: File
    doc: Output directory
    outputSource: compress_hdt/outfile  


inputs:
  genome_fasta:
    type: File?
    label: FASTA input file
    doc: Genome sequence in FASTA format

  embl_file:
    type: File?

  # input_file:
  #   type:
  #     - type: record
  #       fields:
  #         genome_fasta:
  #           type: File?
  #     - type: record
  #       fields:
  #         embl_file:
  #           type: File?

  identifier:
    type: string
    doc: Identifier of the sample being converted
    label: Identifier
  codon_table:
    type: int
    doc: The codon table used for gene prediction
    label: Codon table

  # prodigal_faa:
  #   type: File?
  # prodigal_gff:
  #   type: File?
  # prodigal_ffa:
  #   type: File?

  interproscan_output:
    type: File?
    label: InterProScan output
    doc: InterProScan output file. JSON or TSV (optional)

  kofamscan_output:
    type: File?
    label: kofamscan output
    doc: KoFamScan / KoFamKOALA output file. detail-tsv (optional)
  kofamscan_limit:
    type: int?
    label: SAPP kofamscan filter
    doc:  Limit the number of hits per locus tag to be converted (0=no limit) (optional). Default 0

  eggnog_output:
    label: eggnog-mapper output
    doc: eggnog-mapper output file. Annotations tsv file (optional)
    type: File?

  threads:
    type: int?

  destination:
    type: string?
    label: Output Destination
    doc: Output destination used for cwl-prov reporting.

steps:
  genome_conversion:
    when: $(inputs.fasta != null)
    run: ../tools/sapp/conversion.cwl
    in:
      identifier: identifier
      fasta: genome_fasta
      codon_table: codon_table
    out: [output]

  embl_conversion:
    when: $(inputs.embl != null)
    run: ../tools/sapp/conversion.cwl
    in:
      identifier: identifier
      embl: embl_file
      codon_table: codon_table
    out: [output]
############################
  # prodigal:
  #   run: ../tools/sapp/conversion/conversion_prodigal.cwl
  #   in:
  #     ttl: genome_conversion/output
  #     faa: prodigal_faa
  #     gff: prodigal_gff
  #     ffa: prodigal_ffa
  #     output_prefix: identifier
  #   out: [prodigal_ttl]
############################
  sapp_kofamscan:
    label: "Kofamscan conversion"
    when: $(inputs.resultfile !== null)
    run: ../tools/sapp/conversion/conversion_kofamscan.cwl
    in:
      output_prefix: identifier
      rdf: embl_conversion/output
      limit: kofamscan_limit
      resultfile: kofamscan_output
    out: [kofamscan_ttl]
############################    
  sapp_interproscan:
    label: "InterProScan conversion"
    when: $(inputs.resultfile !== null)
    run: ../tools/sapp/conversion/conversion_interproscan.cwl
    in:
      output_prefix: identifier
      rdf: 
        source:
          - sapp_kofamscan/kofamscan_ttl
          - embl_conversion/output
        pickValue: first_non_null
      resultfile: interproscan_output
    out: [interproscan_ttl]
############################    
  sapp_eggnog:
    label: "eggNOG conversion"
    when: $(inputs.resultfile !== null)
    run: ../tools/sapp/conversion/conversion_eggnog.cwl
    in:
      output_prefix: identifier
      rdf:
        source:
          - sapp_interproscan/interproscan_ttl
          - sapp_kofamscan/kofamscan_ttl
          - embl_conversion/output
        pickValue: first_non_null    
      resultfile: eggnog_output
    out: [eggnog_ttl]
############################
  turtle_to_hdt:
    label: "TTL to HDT"
    run: ../tools/sapp/toHDT.cwl
    in:
      input: 
        source:
        - sapp_eggnog/eggnog_ttl
        - sapp_interproscan/interproscan_ttl
        - sapp_kofamscan/kofamscan_ttl
        - embl_conversion/output
        pickValue: first_non_null
      output:
        source: identifier
        valueFrom: $(self).SAPP.hdt
    out: [hdt_output]
############################
  compress_hdt:
    label: "Compress HDT"
    run: ../tools/bash/pigz.cwl
    in:
      threads: threads
      inputfile: turtle_to_hdt/hdt_output
    out:
      [outfile]

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0009-0001-1350-5644
    s:email: mailto:changlin.ke@wur.nl
    s:name: Changlin Ke
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
s:dateCreated: "2021-00-00"
s:dateModified: "2025-05-05"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/