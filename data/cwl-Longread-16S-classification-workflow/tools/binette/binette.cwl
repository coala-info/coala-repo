#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool
label: Binette

doc: | 
    Binette is a fast and accurate binning refinement tool designed to construct high-quality MAGs from the output of multiple binning tools.
    The docker image contains the already downloaded checkm2 database.

requirements:
 - class: InlineJavascriptRequirement

hints:
  SoftwareRequirement:
    packages:
      binette:
        version: ["1.1.2"]
        specs: ["https://anaconda.org/bioconda/binette","https://doi.org/10.21105/joss.06782"]
      checkm2:
        version: ["1.1.0"]
        specs: ["https://anaconda.org/bioconda/checkm2","https://doi.org/10.1038/s41592-020-00923-9"]
  DockerRequirement:
    dockerPull: docker-registry.wur.nl/m-unlock/docker/binette:1.1.2_uniref100

baseCommand: [binette]

inputs:
  threads:
    type: int?
    doc: Maximum threads to use. Default 1
    label: Threads
    inputBinding:
      prefix: --threads
    default: 1
  
  checkm2_db:
    type: Directory?
    doc: CheckM2 database location. Optional when using the container image, it has the database already downloaded.
    label: CheckM2 database
    inputBinding:
      prefix: --checkm2_db

  bins_dirs:
    type: Directory[]?
    doc: Array of bin folders containing each bin in a fasta file.
    label: Bins directories
    inputBinding:
      prefix: --bin_dirs
  contig2bin_tables:
    type: File?
    doc: List of contig2bin table with two columns separated with a tabulation; contig, bin
    label: Contig2Bin table
    inputBinding:
      prefix: --contig2bin_tables

  contigs:
    type: File?
    doc: Contigs in fasta format.
    label: Contigs
    inputBinding:
      prefix: --contigs
  proteins:
    type: File?
    doc: FASTA file of predicted proteins in Prodigal format
    label: Proteins
    inputBinding:
      prefix: --proteins

  min_completeness:
    type: int
    doc: Minimum completeness required for final bin selections. Default 40
    label: Minimum completeness
    inputBinding:
      prefix: --min_completeness
    default: 40
  contamination_weight:
    type: float
    doc: Bin are scored as follow; completeness - weight * contamination. A low contamination_weight favor complete bins over low contaminated bins. Default 2
    label: Contamination weight
    inputBinding:
      prefix: --contamination_weight
    default: 2.0
  
  low_mem:
    type: boolean
    doc: Use low mem mode when running diamond. Defaullt false
    label: Low memory
    inputBinding:
      prefix: --low_mem
    default: false
  verbose:
    type: boolean
    doc: Verbose output. Default false
    label: Verbose
    inputBinding:
      prefix: --verbose
    default: false
  debug:
    type: boolean
    doc: Debug output. Default false
    label: Debug
    inputBinding:
      prefix: --debug
    default: false

outputs:
  final_bins:
    type: Directory
    doc: This directory stores all the selected bins in fasta format.
    outputBinding: 
      glob: "results/final_bins"  
  final_bins_quality_report:
    type: File
    doc: This is a TSV (tab-separated values) file containing quality information about the final selected bins.
    outputBinding: 
      glob: "results/final_bins_quality_reports.tsv"
  input_bins_quality_reports:
    type: Directory
    doc: A directory storing quality reports for the input bin sets, with files following the same structure as final_bins_quality_reports.tsv
    outputBinding: 
      glob: "results/input_bins_quality_reports"

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateModified: "2025-09-02"
s:dateCreated: "2025-05-02"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
