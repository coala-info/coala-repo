#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool
label: "compress a file multithreaded with pigz"

hints:
  SoftwareRequirement:
    packages:
      pigz:
        version: ["2.8"]
        specs: ["https://anaconda.org/conda-forge/pigz"]
  DockerRequirement:
    dockerPull: quay.io/biocontainers/pigz:2.8

baseCommand: [pigz, -c]

arguments:
  - valueFrom: $(inputs.inputfile)

stdout: $(inputs.inputfile.basename).gz

inputs:
  inputfile:
    type: File
  threads:
    type: int?
    default: 1
    inputBinding:
      prefix: '-p'

outputs:
  outfile:
    type: File
    outputBinding:
        glob: $(inputs.inputfile.basename).gz


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
s:dateCreated: "2020-00-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"


$namespaces:
  s: https://schema.org/