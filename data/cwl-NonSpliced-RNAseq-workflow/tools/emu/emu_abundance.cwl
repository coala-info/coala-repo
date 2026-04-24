#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

label: Emu

doc: Emu abundance; species-level taxonomic abundance for full-length 16S read

requirements:
  - class: InlineJavascriptRequirement

hints:
  SoftwareRequirement:
    packages:
      emu:
        version: ["3.4.5"]
        specs: ["https://anaconda.org/bioconda/emu", "doi.org/10.1038/s41592-022-01520-4"]
  DockerRequirement:
    dockerPull: quay.io/biocontainers/emu:3.5.1--hdfd78af_0

baseCommand: ["emu","abundance"]

inputs:
  reads:
    type: File
    label: Read file 
    doc: Read file in FASTA or FASTQ format (can be gz)
    inputBinding:
      position: 10
  identifier:
    type: string?
    doc: Identifier for this dataset
    label: identifier used
    inputBinding:
      position: 1
      prefix: --output-basename
  reference_db:
    type: Directory
    doc: Path to emu database containing; names_df.tsv, nodes_df.tsv, species_taxid.fasta, unqiue_taxids.tsv
    label: Emu database
    inputBinding:
      position: 2
      prefix: --db
  mapping_type:
    type:
      - type: enum
        symbols:
          - map-pb
          - map-ont
    doc: (map-ont, map-pb, or sr) short-read; sr, Pac-Bio:map-pb, ONT:map-ont. default map-ont
    label: Denote sequencer 
    inputBinding:
      position: 3
      prefix: --type
  threads:
    type: int?
    inputBinding:
      prefix: --threads

  keep_files:
    type: boolean?
    inputBinding:
      position: 4
      prefix: --keep-files
  keep_counts:
    type: boolean?
    inputBinding:
      position: 5
      prefix: --keep-counts
  keep_read_assignments:
    type: boolean?
    inputBinding:
      prefix: --keep-read-assignments
  output_unclassified:
    type: boolean?
    inputBinding:
      position: 6
      prefix: --output-unclassified

outputs:
  abundance:
    type: File
    outputBinding:
      glob: results/$(inputs.identifier)_rel-abundance.tsv
  alignments:
    type: File?
    outputBinding:
      glob: results/$(inputs.identifier)_emu_alignments.sam
  read_assignment_distributions:
    type: File?
    outputBinding:
      glob: results/$(inputs.identifier)_read-assignment-distributions.tsv
  unclassified:
    type: File?
    outputBinding:
      glob: results/$(inputs.identifier)_unclassified.fa

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
s:dateCreated: "2022-06-00"
s:license: https://spdx.org/licenses/Apache-2.0
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
