#!/usr/bin/env cwltool

cwlVersion: v1.2
class: CommandLineTool

label: "kreport2krona.py"
doc: |
    This program takes a Kraken report file and prints out a krona-compatible TEXT file

requirements:
  - class: InlineJavascriptRequirement

hints:
  SoftwareRequirement:
    packages:
      kronatools:
        version: ["1.2"]
        specs: ["https://anaconda.org/bioconda/krakentools"]

  DockerRequirement:
    dockerPull: quay.io/biocontainers/krakentools:1.2--pyh5e36f6f_0

baseCommand: [ kreport2krona.py ]

arguments:
  - valueFrom: $(inputs.report.nameroot)_krona.txt
    prefix: --output

inputs:
  report:
    type: File
    label: Report
    doc: Kraken report file
    inputBinding:
      prefix: --report

  no-intermediate-ranks:
    type: boolean
    label: No Intermediate Ranks
    doc: only output standard levels [D,P,C,O,F,G,S]. Default true
    inputBinding:
      prefix: --no-intermediate-ranks
    default: true

  intermediate-ranks:
    type: boolean
    label: Intermediate Ranks
    doc: Include non-standard levels. Default false
    inputBinding:
      prefix: --intermediate-ranks
    default: false

outputs:
  krona_txt: 
    type: File
    outputBinding:
      glob: $(inputs.report.nameroot)_krona.txt

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
s:dateModified: 2024-10-07
s:dateCreated: "2024-04-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/