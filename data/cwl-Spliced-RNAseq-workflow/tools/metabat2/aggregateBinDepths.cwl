#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

label: "aggregateBinDepths"

doc: |
    Aggregate bin depths using MetaBat2 using the script aggregateBinDepths.pl

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

#baseCommand: [aggregateBinDepths.pl]
baseCommand: [perl, /usr/local/bin/aggregateBinDepths.pl]

inputs:
  identifier:
    type: string
    doc: Name of the output file
    label: output file name

  metabatdepthsFile:
    type: File
    doc: Contig depths files obtained from metabat2 script jgi_summarize_bam_contig_depths
    label: contigs depths
    inputBinding:
      position: 1
  
  # Add bin folder option. 
  # Will need to be converted to a list of files because that is how the tools needs it as input.

  bins:
    type: File[]
    doc: Bin fasta files
    label: Bin fasta files
    inputBinding:
      position: 2

stdout: $(inputs.identifier)_bindepths.tsv
outputs:
  binDepths:
    type: File
    outputBinding:
        glob: $(inputs.identifier)_bindepths.tsv

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
s:dateModified: 2024-10-07
s:dateCreated: "2021-00-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
