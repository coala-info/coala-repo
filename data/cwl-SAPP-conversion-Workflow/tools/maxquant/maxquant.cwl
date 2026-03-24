#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

label: MaxQuant

doc: MaxQuant is a quantitative proteomics software package designed for analyzing large mass-spectrometric data sets. It is specifically aimed at high-resolution MS data. Several labeling techniques as well as label-free quantification are supported. MaxQuant is freely available and can be downloaded from https://maxquant.org.

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - entry: $(inputs.raw_data_dir)
        writable: true
      - entryname: script.sh
        entry: |-
          #!/bin/bash
          echo "Running mqpar.xml conversion"
          mono /MaxQuant_2.4.0.0/bin/MaxQuantCmd.exe $@
          echo "Running MaxQuant"
          mono /MaxQuant_2.4.0.0/bin/MaxQuantCmd.exe $HOME/changed_mqpar.xml

hints:
  SoftwareRequirement:
    packages:
      mono:
        version: ["6.12.0.90"]
        specs: ["https://anaconda.org/conda-forge/mono"]
      dotnet:
        version: ["3.1.426"] # ["7.0.102"]
        specs: ["https://anaconda.org/conda-forge/dotnet"]
      maxquant:
        version: ["2.4.2.0"]
        specs: ["https://maxquant.org", "doi.org/10.1038/nbt.1511"]
  DockerRequirement:
    dockerPull: docker-registry.wur.nl/m-unlock/docker/maxquant:2.4.2.0

baseCommand: [ "bash", "-x", "script.sh" ]

inputs:
  mqpar:
    type: File
    inputBinding:
      position: 1
      prefix: ""
    doc: MaxQuant parameter file (mqpar.xml)
    label: MaxQuant parameter file
  fasta:
    type: Directory
    inputBinding:
      position: 3
      prefix: ""
    doc: Directory containing the required FASTA files as described in the mqpar.xml file.
    label: FASTA directory
  raw_data_dir:
    type: Directory
    inputBinding:
      position: 4
      prefix: ""
    doc: Directory containing raw data files
    label: Directory containing raw data files

arguments:
  - valueFrom: "changed_mqpar.xml"
    position: 2
    prefix: "--changeFolder="
    separate: false
    shellQuote: false

stdout: MaxQuant.log

outputs:
  log:
    type: File
    label: Log
    doc: Log file recording the core steps of MaxBin algorithm
    outputBinding:
      glob: MaxQuant.log
  mqpar:
    type: File
    label: New MaxQuant parameter file
    doc: The newly generated MaxQuant parameter file
    outputBinding:
      glob: "changed_mqpar.xml"
  output:
    type: Directory
    label: MaxQuant result directory
    doc: The result directory of a MaxQuant run
    outputBinding:
      glob: $(inputs.raw_data_dir.basename)/combined

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
s:dateCreated: "2023-05-22"
s:license: https://spdx.org/licenses/Apache-2.0
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
