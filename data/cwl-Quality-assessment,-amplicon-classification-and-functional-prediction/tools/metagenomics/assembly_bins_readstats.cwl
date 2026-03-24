#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

label: "Bin read mapping stats"

doc: |
    Table of general read mapping statistics of the bins and assembly
    
    id
    reads
    assembly_size
    contigs
    n50
    largest_contig
    mapped reads (percentage)
    bins
    total_binned_size
    unbinned_size
    binned (percentage)
    reads_mapped_to_bins (percentage)
    binned_contigs

requirements:
  - class: InlineJavascriptRequirement

hints:
  SoftwareRequirement:
    packages:
      python3:
        version: ["3.12.0"]
        specs: ["https://anaconda.org/conda-forge/python"]
      pysam:
        version: ["0.23.2"]
        specs: ["https://anaconda.org/bioconda/pysam"]       
  DockerRequirement:
    dockerPull: docker-registry.wur.nl/m-unlock/docker/scripts:e197a628

baseCommand: ["python3", "/scripts/metagenomics/assembly_bins_readstats.py"]

inputs:
  identifier:
    type: string
    doc: Identifier for this dataset used in this workflow
    label: identifier used
    inputBinding:
      prefix: --identifier

  bin_dir:
    type: Directory?
    doc: Directory containing bins in fasta format from metagenomic binning
    label: Bins directory
    inputBinding:
      prefix: --bin_dir
  bin_files:
    type: File[]?
    doc: Array of bin files in fasta format
    label: Bin files
    inputBinding:
      prefix: --bin_files
  bam_file:
    type: File
    doc: BAM file with reads mapped to the assembly
    label: BAM file
    inputBinding:
      prefix: --bam


stdout: $(inputs.identifier)_binning-stats.tsv

outputs:
  binReadStats:
    type: File
    outputBinding:
      glob: $(inputs.identifier)_binning-stats.tsv

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
s:dateModified: 2025-09-05
s:dateCreated: "2022-12-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
