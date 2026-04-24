#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

label: "MetaBAT2 binning"

doc: |
    Metagenome Binning based on Abundance and Tetranucleotide frequency (MetaBat2)

requirements:
 - class: InlineJavascriptRequirement

inputs:

  identifier:
    type: string
    doc: Identifier for this dataset used in this workflow
    label: identifier used

  threads:
    type: int?
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

arguments:
  - valueFrom: "--unbinned"
  - prefix: "--outFile"
    valueFrom: MetaBAT2_bins/$(inputs.identifier)_bin
    
baseCommand: [/unlock/infrastructure/binaries/MetaBAT/metabat_v2.12.1/metabat2]

stdout: $(inputs.identifier)_MetaBAT2.log

outputs:
  bin_dir:
    type: Directory
    outputBinding:
      glob: MetaBAT2_bins
  bins:
    type: File[]
    outputBinding:
      glob: MetaBAT2_bins/$(inputs.identifier)_bin*
  log:
    type: File
    outputBinding:
        glob: $(inputs.identifier)_MetaBAT2.log
