cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - amdirt
  - convert
label: amdirt_convert
doc: "Converts filtered samples and libraries tables to eager, ameta, taxprofiler,
  and fetchNGS input tables\n\nTool homepage: https://github.com/SPAAM-community/AMDirT"
inputs:
  - id: samples
    type: File
    doc: path to filtered AncientMetagenomeDir samples tsv file
    inputBinding:
      position: 1
  - id: table_name
    type: string
    doc: name of table to convert
    inputBinding:
      position: 2
  - id: ameta
    type:
      - 'null'
      - boolean
    doc: Convert filtered samples and libraries tables to aMeta input tables
    inputBinding:
      position: 103
      prefix: --ameta
  - id: aspera
    type:
      - 'null'
      - boolean
    doc: Generate bash script with Aspera-based download commands for all libraries
      of samples in input table
    inputBinding:
      position: 103
      prefix: --aspera
  - id: bibliography
    type:
      - 'null'
      - boolean
    doc: Generate BibTeX file of all publications in input table
    inputBinding:
      position: 103
      prefix: --bibliography
  - id: curl
    type:
      - 'null'
      - boolean
    doc: Generate bash script with curl-based download commands for all libraries
      of samples in input table
    inputBinding:
      position: 103
      prefix: --curl
  - id: dates
    type:
      - 'null'
      - boolean
    doc: Generate AncientMetagenomeDir dates table of all samples in input table
    inputBinding:
      position: 103
      prefix: --dates
  - id: eager
    type:
      - 'null'
      - boolean
    doc: Convert filtered samples and libraries tables to eager input tables
    inputBinding:
      position: 103
      prefix: --eager
  - id: fetchngs
    type:
      - 'null'
      - boolean
    doc: Convert filtered samples and libraries tables to nf-core/fetchngs input tables
    inputBinding:
      position: 103
      prefix: --fetchngs
  - id: libraries
    type:
      - 'null'
      - File
    doc: (Optional) Path to a pre-filtered libraries table. Mutually exclusive with
      librarymetadata.
    inputBinding:
      position: 103
      prefix: --libraries
  - id: librarymetadata
    type:
      - 'null'
      - boolean
    doc: Generate AncientMetagenomeDir libraries table of all samples in input table.
      Mutually exclusive with libraries.
    inputBinding:
      position: 103
      prefix: --librarymetadata
  - id: mag
    type:
      - 'null'
      - boolean
    doc: Convert filtered samples and libraries tables to nf-core/mag input tables
    inputBinding:
      position: 103
      prefix: --mag
  - id: sratoolkit
    type:
      - 'null'
      - boolean
    doc: Generate bash script with SRA Toolkit fasterq-dump based download commands
      for all libraries of samples in input table
    inputBinding:
      position: 103
      prefix: --sratoolkit
  - id: tables
    type:
      - 'null'
      - File
    doc: (Optional) JSON file listing AncientMetagenomeDir tables
    inputBinding:
      position: 103
      prefix: --tables
  - id: taxprofiler
    type:
      - 'null'
      - boolean
    doc: Convert filtered samples and libraries tables to nf-core/taxprofiler input
      tables
    inputBinding:
      position: 103
      prefix: --taxprofiler
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: conversion output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amdirt:1.7.0--pyhdfd78af_0
