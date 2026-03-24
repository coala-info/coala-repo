#!/usr/bin/env cwltool

cwlVersion: v1.2
class: CommandLineTool

label: gunzip

doc: Unzipping files with gunzip.

requirements:
  InlineJavascriptRequirement: {}

baseCommand: ["gunzip", "-c"]

inputs:
  input_gz:
    type: File
    inputBinding:
      position: 1

outputs:
  unzipped_file:
    type: File
    outputBinding:
      glob: $(inputs.input_gz.basename.replace(/\.gz$/, ""))

stdout: $(inputs.input_gz.basename.replace(/\.gz$/, ""))

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