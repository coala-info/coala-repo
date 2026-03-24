#!/usr/bin/env cwltool

cwlVersion: v1.2
class: CommandLineTool

label: Strainy, a long read graph-based assembly phasing tool

doc: |
  Strainy is a tool for phasing and assembly of bacterial strains from long-read sequencing data (either Oxford Nanopore or PacBio).
  Given a reference (or collapsed de novo assembly) and set of aligned reads as input, Strainy produces multi-allelic phasing, individual strain haplotypes and strain-specific variant calls.
  Documentation on how to install and run Strainy can be found here:
  https://github.com/katerinakazantseva/strainy

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - entry: "$({class: 'Directory', listing: []})"
        entryname: "strainy_output"
        writable: true

hints:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/strainy:1.2--pyhdfd78af_1
  SoftwareRequirement:
    packages:
      strainy:
        version: ["1.2"]
        specs: ["identifiers.org/RRID:SCR_026430"]
  
baseCommand: strainy


arguments:
  - valueFrom: "strainy_output"  # hardcoded to create strainy_output folder
    prefix: --output
    position: 1

inputs:
  reference:
    type: File?
    label: Input reference file
    doc: Input strain-collapsed graph (e.g. from de novo metagenomic assembly). Supports GFA formats (alternatively use --fasta_ref)
    inputBinding:
      prefix: --gfa_ref
  read_type:
    type: 
      - type: enum
        symbols: [hifi, nano]
    label: Read mode
    doc: Specifies the type of read - either 'hifi' or 'nano'
    inputBinding:
      prefix: --mode
  input_reads:
    type: File
    label: Input reads
    doc: Input FASTQ file with reads to phase / assemble
    inputBinding:
      prefix: --fastq
  threads:
    type: int?
    doc: The number of threads used, default is 4
    inputBinding:
      prefix: --threads
  reference_fasta: 
    type: File?
    label: Alternative reference file
    doc: Input reference fasta (for linear genome)
    inputBinding:
      prefix: --fasta_ref

outputs:
  strainy_outdir:
    type: Directory
    label: output directory
    doc: Strainy output directory.
    outputBinding:
      glob: "strainy_output"
  phased_alignment:
    type: File
    format: edam:format_2330
    streamable: true
    outputBinding:
      glob: "strainy_output/alignment_phased.bam"
  strain_unitigs_gfa:
    type: File
    label: strain unitigs GFA
    doc: Transformed graph that incorporates assembled strain haplotypes. These are "finer" strain unitigs that match the CSV tables with additional info below.
    outputBinding:
      glob: "strainy_output/strain_unitigs.gfa"
  strain_contigs_gfa:
    type: File
    label: Strain Contigs GFA
    doc: A simplified and extended version of the graph after final simplification. Some strain unitigs are joined into longer contigs, so these sequences may no longer have IDs matching to the CSV tables below.
    outputBinding:  
      glob: "strainy_output/strain_contigs.gfa"

  strain_variants_vcf:
    type: File
    label: Strain Variants VCF
    doc: A file with variants produced from assembled strain haplotypes in VCF format. In the INFO field, ALT_HAP refers to strain unitigs that support the ALT version of the variant, and REF_HAP correspond to the list of unitigs that contain no variant (reference state).
    outputBinding:
      glob: "strainy_output/strain_variants.vcf"

  reference_unitig_info_table_csv:
    type: File
    label: Reference Unitig Info Table
    doc: Additional statistics for reference sequences (such as length, coverage, SNP rate).
    outputBinding:  
      glob: "strainy_output/reference_unitig_info_table.csv"

  phased_unitig_info_table_csv:
    type: File
    label: Phased Unitig Info Table
    doc: Statistics for each phased strain unitig (matching the strain_unitigs.gfa file). For each strain unitig, its length, coverage, SNP rate, and other statistics are reported.
    outputBinding:  
      glob: "strainy_output/phased_unitig_info_table.csv"

  multiplicity_stats_txt:
    type: File
    label: Multiplicity Stats
    doc: Dataset-level summary of strain multiplicity and strain divergence, along with other assembly-based statistics.
    outputBinding:  
      glob: "strainy_output/multiplicity_stats.txt"

$namespaces:
  s: https://schema.org/   
  edam: http://edamontology.org/ 
s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse
  - class: s:Person
    s:identifier: https://orcid.org/0009-0005-0017-0928
    s:email: mailto:martijn.melissen@wur.nl
    s:name: Martijn Melissen
s:citation: https://m-unlock.nl
s:codeRepository: https://git.wur.nl/ssb/automated-data-analysis
s:dateCreated: "2025-02-11"
s:dateModified: "2025-02-14"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"