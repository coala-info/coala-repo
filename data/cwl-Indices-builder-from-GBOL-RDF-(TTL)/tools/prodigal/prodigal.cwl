#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

label: "Prodigal"
doc: "Prokaryotic gene prediction using Prodigal with compressed input fasta (gzip) files."

hints:
  SoftwareRequirement:
    packages:
      prodigal:
        version: ["2.6.3"]
        specs: ["https://anaconda.org/bioconda/prodigal", "doi.org/10.1186/1471-2105-11-119"]

  DockerRequirement:
    dockerPull: docker-registry.wur.nl/m-unlock/docker/prodigal:2.6.3

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - entry: "$({class: 'Directory', listing: []})"
        entryname: "prodigal_run"
        writable: true
      - entryname: script.sh
        entry: |-
          #!/bin/bash
          if [[ $1 == *.gz ]]; then
            gunzip -c $1 > $(inputs.identifier).fasta;
          else
            cp $1 $(inputs.identifier).fasta;
          fi
          shift;
          prodigal $@ < $(inputs.identifier).fasta;


baseCommand: [ bash, -x, script.sh ]

arguments:
  - valueFrom: $(inputs.input_fasta.path)
    shellQuote: False 
  # - valueFrom: "sco" # What is the sco format? It's Simple coordinate output
  #   prefix: "-f"
  - valueFrom: $(inputs.identifier).prodigal.gff
    prefix: "-o"
  - valueFrom: $(inputs.identifier).prodigal.ffn
    prefix: "-d"
  - valueFrom: $(inputs.identifier).prodigal.faa
    prefix: "-a"

outputs:
  predicted_proteins_out:
    type: File
    outputBinding:
      glob: $(inputs.identifier).prodigal.gff
  predicted_proteins_ffn:
    type: File
    outputBinding:
      glob: $(inputs.identifier).prodigal.ffn
  predicted_proteins_faa:
    type: File
    outputBinding:
      glob: $(inputs.identifier).prodigal.faa

inputs:
  input_fasta:
    type: File
    # inputBinding:
      # prefix: "-i"
  
  # This shoulbd be a selection
  mode:
    doc: Input is a meta-genome or an isolate genome
    type: 
      - 'null'
      - type: enum
        symbols: 
        - single
        - meta
    inputBinding:
      prefix: -p

  # meta_mode:
  #   type: boolean?
  #   doc: Input is a meta-genome
  #   inputBinding:
  #     prefix: -p
  #     valueFrom: meta
  # single_mode:
  #   type: boolean?
  #   doc: Input is an isolate genome
  #   inputBinding:
  #     prefix: -p
  #     valueFrom: single

  codon_table:
    type: int?
    doc: Codon table to use
    inputBinding:
      prefix: -g
  identifier:
    type: string
    doc: Identifier for the output files
    

  # mode:
  #   type:
  #     - type: record
  #       name: single
  #       fields:
  #         single:
  #           type: boolean?
  #           inputBinding:
  #             prefix: -p
  #             valueFrom: single
  #     - type: record
  #       name: meta
  #       fields:
  #         meta:
  #           type: boolean?
  #           inputBinding:
  #             prefix: -p
  #             valueFrom: meta

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
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-6867-2039
    s:name:  Ekaterina Sakharova

s:copyrightHolder': EMBL - European Bioinformatics Institute
s:license': "https://www.apache.org/licenses/LICENSE-2.0"

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateCreated: "2022-06-00"
s:dateModified: "2022-08-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"
s:copyrightNotice: " Copyright < 2022 EMBL - European Bioinformatics Institute
    This file has been modified by UNLOCK - Unlocking Microbial Potential
"

$namespaces:
  s: https://schema.org/