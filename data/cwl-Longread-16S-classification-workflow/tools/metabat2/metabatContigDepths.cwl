#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

label: "jgi_summarize_bam_contig_depths"

doc: |
    Summarize contig read depth from bam file for metabat2 binning.

requirements:
 - class: InlineJavascriptRequirement

hints:
  SoftwareRequirement:
    packages:
      metabat2:
        version: ["2.15"]
        specs: ["https://anaconda.org/bioconda/metabat2", "doi.org/10.7717%2Fpeerj.7359"]
  DockerRequirement:
    dockerPull: quay.io/biocontainers/metabat2:2.15--h4da6f23_2
    
baseCommand: [jgi_summarize_bam_contig_depths]

arguments:
  - position: 1
    prefix: '--outputDepth'
    valueFrom:  $(inputs.identifier)_contigdepths.tsv

inputs:
  identifier:
    type: string
    doc: Name of the output file
    label: output file name

  bamFile:
    type: File
    inputBinding:
      position: 2

outputs:
  depths:
    type: File
    outputBinding:
      glob: $(inputs.identifier)_contigdepths.tsv

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse
  - class: s:Person
    s:identifier: https://orcid.org/0009-0001-1350-5644
    s:email: mailto:changlin.ke@wur.nl
    s:name: Changlin Ke
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-8172-8981
    s:email: mailto:jasper.koehorst@wur.nl
    s:name: Jasper Koehorst

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateModified: "2025-05-30"
s:dateCreated: "2020-00-00"
s:license: https://spdx.org/licenses/CC0-1.0.html 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
 s: http://schema.org/
