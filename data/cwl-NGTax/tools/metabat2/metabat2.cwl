#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

label: "MetaBAT2 binning"

doc: |
    Metagenome Binning based on Abundance and Tetranucleotide frequency (MetaBat2)

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

baseCommand: [metabat2]

arguments:
  - prefix: "--outFile"
    valueFrom: metabat2_bins/$(inputs.identifier)_metabat2_bin
    
inputs:
  identifier:
    type: string
    doc: Identifier for this dataset used in this workflow
    label: identifier used
  threads:
    type: int
    label: Number of threads to use
    inputBinding:
      position: 0
      prefix: --numThreads
  assembly:
    type: File
    label: The input assembly in fasta format
    inputBinding:
      position: 4
      prefix: --inFile
  depths:
    type: File
    inputBinding:
      position: 5
      prefix: --abdFile
  write_unbinned:
    type: boolean?
    doc: Export unbinned contigs as fasta file
    label: Write unbinned
    inputBinding:
      prefix: --unbinned

stdout: $(inputs.identifier)_metabat2.log

outputs:
  bin_dir:
    type: Directory
    label: Bin directory
    doc: Bin directory
    outputBinding:
      glob: metabat2_bins
  unbinned:
    type: File?
    label: Unbinned contigs
    doc: Unbinned contig fasta files
    outputBinding:
      glob: metabat2_bins/$(inputs.identifier)_metabat2_bin.unbinned.fa
  log:
    type: File
    label: Log
    doc: MetaBat2 log file
    outputBinding:
        glob: $(inputs.identifier)_metabat2.log

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
s:dateModified: 2025-05-30
s:dateCreated: "2022-10-00"
s:license: https://spdx.org/licenses/Apache-2.0
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
