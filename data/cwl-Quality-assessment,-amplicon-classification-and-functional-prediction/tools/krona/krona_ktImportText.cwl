#!/usr/bin/env cwltool

cwlVersion: v1.2
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement

hints:
  SoftwareRequirement:
    packages:
      krona :
        version: ["2.8.1"]
        specs: ["https://anaconda.org/bioconda/krona", "doi.org/10.1186/1471-2105-12-385"]
  DockerRequirement:
    dockerPull: quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1

baseCommand: [ ktImportText ]

label: Krona ktImportText
doc: |
    Creates a Krona chart from text files listing quantities and lineages.
    text  Tab-delimited text file. Each line should be a number followed by a list of wedges to contribute to (starting from the highest level). 
    If no wedges are listed (and just a quantity is given), it will contribute to the top level. 
    If the same lineage is listed more than once, the values will be added. Quantities can be omitted if -q is specified.
    Lines beginning with "#" will be ignored. By default, separate datasets will be created for each input.

arguments:
  - prefix: -o
    valueFrom: $(inputs.input.nameroot).html

inputs:
  input:
    type: File
    label: Tab-delimited text file
    inputBinding:
      position: 10 # Krona requires the input after the output flag
  highest_level:
    type: string?
    label: Highest level
    doc: Name of the highest level. Default 'all'
    inputBinding:
      position: 1
      prefix: -n
  no_quantity:
    type: boolean?
    label: No quantity
    doc: Fields do not have a field for quantity. Default false
    inputBinding:
      position: 2
      prefix: -q

outputs:
  krona_html:
    type: File
    outputBinding:
      glob: $(inputs.input.nameroot).html

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
s:dateCreated: "2024-04-10"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
