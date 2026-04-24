#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool
label: "Compress a directory (tar)"
doc: "Multithreaded compression of a directory using tar and pigz"

requirements:
  - class: ShellCommandRequirement
  - class: InlineJavascriptRequirement

hints:
  SoftwareRequirement:
    packages:
      tar:
        version: ["1.34"]
        specs: ["https://anaconda.org/conda-forge/tar"]
      pigz:
        version: ["2.8"]
        specs: ["https://anaconda.org/conda-forge/pigz"]
  DockerRequirement:
    dockerPull: docker-registry.wur.nl/m-unlock/docker/pigz:latest

baseCommand: tar

arguments:
  - valueFrom: $('--use-compress-program="pigz -p'+inputs.threads+' -k "')
    shellQuote: false
  - valueFrom: "-chf"
  - valueFrom: $(inputs.indir.basename).tar.gz
  - valueFrom: "-C"
  - valueFrom: $(inputs.indir.path)/..
  - valueFrom: $(inputs.indir.basename)

inputs:
  indir:
    type: Directory
  threads: 
    type: int?

outputs:
  outfile:
    type: File
    outputBinding:
        glob: $(inputs.indir.basename).tar.gz

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
s:dateModified: "2025-02-27"
s:dateCreated: "2021-00-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/