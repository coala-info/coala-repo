#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

label: CoverM

doc: |
    CoverM calculates coverage of genomes/MAGs coverm genome or individual contigs coverm contig. 
    Calculating coverage by read mapping, its input can either be BAM files sorted by reference, or raw reads and reference genomes in various formats.
    
    Currently only bam files and genome directory input is implemented in this CWL.

requirements:
  - class: InlineJavascriptRequirement

hints:
  SoftwareRequirement:
    packages:
      coverm:
        version: ["0.7.0"]
        specs: ["https://anaconda.org/bioconda/coverm", "https://doi.org/10.1093/bioinformatics/btaf147"]
  DockerRequirement:
    dockerPull: quay.io/biocontainers/coverm:0.7.0--hcb7b614_4

baseCommand: ["coverm","genome"]

inputs:
  identifier:
    type: string
    doc: Identifier for this dataset used in this workflow
    label: identifier used
  genome_fasta_files:
    type: File[]?
    label: Genome files 
    doc: Path to genome file(s) in fasta format.
    inputBinding:
      prefix: --genome-fasta-files
  genome_fasta_directory:
    type: Directory?
    label: Genome fasta directory 
    doc: Directory containing genome fasta files
    inputBinding:
        prefix: --genome-fasta-directory
  genome_fasta_extension:
    type: string?
    doc: File extension of genomes in the directory specified with genome-fasta-directory. (default; fna)
    label: Genome fasta extension
    inputBinding:
      prefix: --genome-fasta-extension
  bam_files:
    type: File[]
    label: BAM files
    doc: |
        Path to BAM file(s). These must be reference sorted (e.g. with samtools sort).
    inputBinding:
      prefix: --bam-files

  min_covered_fraction:
    type: float?
    doc: Genomes with less covered bases than this are reported as having zero coverage.(default; 10)
    label: Minimum covered fraction
    inputBinding:
      prefix: --min-covered-fraction

  method:
    type:
      - type: enum
        symbols:
          - relative_abundance
          - mean
          - trimmed_mean
          - coverage_histogram
          - covered_bases
          - length
          - count
          - reads_per_base
          - anir
          - rpkm
          - tpm
    doc: Method to calculate coverage (default; relative_abundance)
    label: Method to calculate coverage
    inputBinding:
      prefix: --methods

stdout: coverm.tsv

outputs:
  coverm_tsv:
    type: File
    outputBinding:
      glob: coverm.tsv
      outputEval: ${self[0].basename=inputs.identifier+"_coverm.tsv"; return self;}
    

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateModified: "2025-09-03"
s:dateCreated: "2025-09-03"
s:license: https://spdx.org/licenses/Apache-2.0
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
