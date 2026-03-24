#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool
label: HUMAnN3 humann_unpack_pathways

doc: |
  Runs the HUMAnN 3 humann_unpack_pathways function.
  This utility will unpack the pathways to show the genes for each. 
  It adds another level of stratification to the pathway abundance table by including the gene families (or EC) abundances.

requirements:
 - class: InlineJavascriptRequirement

hints:
  SoftwareRequirement:
    packages:
      humann:
        version: ["3.8"]
        specs: ["https://anaconda.org/bioconda/humann", "doi.org/10.7554/eLife.65088"]      
  DockerRequirement:
    dockerPull: quay.io/biocontainers/humann:3.9--py312hdfd78af_0

baseCommand: [humann_unpack_pathways]

arguments:
  - prefix: "--output"
    valueFrom: $(inputs.identifier)_HUMAnN_pathways_unpacked.tsv

inputs:
  identifier:
    type: string
    doc: Identifier for output files.
    label: Identifier

  input_genes:
    type: File
    doc: A file containing the gene families (or EC) abundance table (tsv format)
    label: Input genes
    inputBinding:
      prefix: --input-genes

  input_pathways:
    type: File
    doc: A file containing the pathways abundance table (tsv format)
    label: Input pathways
    inputBinding:
      prefix: --input-pathways

outputs:
  pathway_genes_abundances:
    type: File
    outputBinding:
      glob:  $(inputs.identifier)_HUMAnN_pathways_unpacked.tsv


s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-8172-8981
    s:email: mailto:jasper.koehorst@wur.nl
    s:name: Jasper Koehorst
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse
  - class: s:Person
    s:identifier: https://orcid.org/0009-0001-1350-5644
    s:email: mailto:changlin.ke@wur.nl
    s:name: Changlin Ke

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateModified: "2025-02-14"
s:dateCreated: "2024-05-22"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
