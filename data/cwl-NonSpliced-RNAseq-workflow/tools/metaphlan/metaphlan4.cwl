#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

label: MetaPhlAn 4

doc: |
  MetaPhlAn 4 is a computational tool for profiling the composition of microbial communities (Bacteria, Archaea and Eukaryotes) 
  from metagenomic shotgun sequencing data (i.e. not 16S) with species-level.

requirements:
  - class: InlineJavascriptRequirement

hints:
  SoftwareRequirement:
    packages:
      diamond :
        version: ["4.1.0"]
        specs: ["https://anaconda.org/bioconda/metaphlan", "doi.org/10.1101/2022.08.22.504593"]
  DockerRequirement:
    dockerPull: quay.io/biocontainers/metaphlan:4.1.1--pyhdfd78af_0

baseCommand: [ metaphlan ]

arguments:
  - prefix: "-o"
    position: 4
    valueFrom: $(inputs.identifier)_MetaPhlAn4_profile.txt
  - prefix: "--bowtie2out"
    position: 5
    valueFrom: $(inputs.identifier)_MetaPhlAn4.bowtie2.bz2

inputs:
  identifier:
    type: string?
    doc: Identifier for this dataset. Default "metagenome"
    label: identifier used
    default: metagenome

  reads:
    type: File
    doc: Input reads file
    label: Reads
    inputBinding:
      position: 1

  input_type:
    type: string
    doc: |
        set whether the input is the FASTA file of metagenomic reads or the SAM file of the mapping of the reads against the MetaPhlAn db. 
        fastq, fasta, bowtie2out, sam.
    label: Input type
    inputBinding:
      prefix: --input_type
      position: 2
  
  analysis_type:
    type:
      - type: enum
        symbols:
          - rel_ab
          - rel_ab_w_read_stats
          - reads_map
          - clade_profiles
          - marker_ab_table
          - marker_counts
          - marker_pres_table
          - clade_specific_strain_tracker
        inputBinding:
          prefix: -t
    doc: | 
        Type of analysis to perform
        * rel_ab: profiling a metagenomes in terms of relative abundances
        * rel_ab_w_read_stats: profiling a metagenomes in terms of relative abundances and estimate the number of reads coming from each clade.
        * reads_map: mapping from reads to clades (only reads hitting a marker)
        * clade_profiles: normalized marker counts for clades with at least a non-null marker
        * marker_ab_table: normalized marker counts (only when > 0.0 and normalized by metagenome size if --nreads is specified)
        * marker_counts: non-normalized marker counts [use with extreme caution]
        * marker_pres_table: list of markers present in the sample (threshold at 1.0 if not differently specified with --pres_th
        * clade_specific_strain_tracker: list of markers present for a specific clade, specified with --clade, and all its subclades
    label: Analysis type
    default: rel_ab

  bowtie2db:
    type: Directory
    doc: location of the metaphlan4 bowtie2 database
    label: Bowtie2 database
    inputBinding:
      prefix: --bowtie2db
      position: 3

  threads:
    type: int
    label: threads
    doc: Number of computational threads to use
    inputBinding:
      prefix: --nproc
      position: 4

outputs:
  profile:
    type: File
    outputBinding:
      glob: $(inputs.identifier)_MetaPhlAn4_profile.txt
  bowtie2out:
    type: File
    outputBinding:
      glob: $(inputs.identifier)_MetaPhlAn4.bowtie2.bz2

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
s:dateCreated: "2025-04-04"
s:license: https://spdx.org/licenses/Apache-2.0
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
