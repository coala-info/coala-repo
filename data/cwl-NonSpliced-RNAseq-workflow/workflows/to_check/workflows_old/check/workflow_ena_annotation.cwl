#!/usr/bin/env cwl-runner

cwlVersion: v1.2

class: Workflow

label: "Genome synchronisation with EBI"

doc: |
    Runs the genome annotation workflow with genomes from ENA

requirements:
 - class: InlineJavascriptRequirement
 - class: ScatterFeatureRequirement
 - class: MultipleInputFeatureRequirement
 - class: SubworkflowFeatureRequirement

inputs:
  enaBrowserTools:
    type: string
    doc: Path of the local enaBrowserTools git repository
    label: enaBrowserTools location
    default: /unlock/infrastructure/binaries/enaBrowserTools
  gca:
    type: string
    doc: Genome Accession number according to ENA
    label: Genome accession number (GCA_....)
  bacteria:
    type: boolean?
    doc: When accession number corresponds to a bacteria
    label: bacteria
    default: false
  threads:
    type: int?
    doc: number of threads to use for computational processes
    label: number of threads
    default: 2
  memory:
    type: int?
    doc: maximum memory usage in megabytes
    label: memory usage (mb)
    default: 4000
  codon:
    type: int
    doc: Codon table number for gene prediction and translation
    label: codon table

outputs:
  x11:
    type: File[]
    outputSource: [workflow_sapp_microbes/output, workflow_sapp_others/output]

steps:
  #########################################
  # The ENA downloader
  enaBrowserTools:
    run: ../ena/enabrowsertools.cwl
    in:
      enaBrowserTools: enaBrowserTools
      gca: gca
    out: [gz, xml, dat]
  #########################################
  decompress:
    when: $(inputs.dat == null)
    run: ../bash/decompress.cwl
    in:
      infile: enaBrowserTools/gz
      # When no dat files are found decompress gz and prepare for workflow
      dat: enaBrowserTools/dat
    out: [outfile]
  # #########################################
  merge: 
    when: $(inputs.infiles != null)
    run: ../bash/concatenate.cwl
    in:
      infiles: enaBrowserTools/dat
      outname: gca
    out: [outfile]
  #########################################
  # SAPP...
  workflow_sapp_microbes:
    # Alternatif when codon == 11 || codon == 4
    when: $(inputs.bacteria)
    run: ../workflows/workflow_sapp_microbes.cwl
    scatter: embl
    scatterMethod: dotproduct
    in:
      bacteria: bacteria
      embl:
        source: [merge/outfile, decompress/outfile]
        linkMerge: merge_flattened
        pickValue: all_non_null
      identifier: gca
      codon: codon
      single:
        default: true
      threads: threads
    out: [output]
  workflow_sapp_others:
    when: $(inputs.bacteria == false)
    run: ../workflows/workflow_sapp_others.cwl
    scatter: embl
    scatterMethod: dotproduct
    in:
      bacteria: bacteria
      embl: 
        source: [merge/outfile, decompress/outfile]
        linkMerge: merge_flattened
        pickValue: all_non_null
      identifier: gca
      threads: threads
    out: [output]

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-8172-8981
    s:email: mailto:jasper.koehorst@wur.nl
    s:name: Jasper Koehorst

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateCreated: "2020-00-00"
s:dateModified: "2022-05-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
