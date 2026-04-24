#!/usr/bin/env cwltool

cwlVersion: v1.2
class: CommandLineTool

label: Flye, de novo assembler for single molecule sequencing reads using repeat graphs 

doc: |
  Flye is a de novo assembler for single-molecule sequencing reads, such as those produced by PacBio and Oxford Nanopore Technologies.
  It is designed for a wide range of datasets, from small bacterial projects to large mammalian-scale assemblies.
  The package represents a complete pipeline: it takes raw PacBio / ONT reads as input and outputs polished contigs.
  Flye also has a special mode for metagenome assembly.
  Documentation on how to install and run Flye can be found here:
  https://github.com/mikolmogorov/Flye/

hints:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/flye:2.9.3--py310h2b6aa90_0
  SoftwareRequirement:
    packages:
      flye:
        version: ["2.9.3"]
        specs: ["identifiers.org/RRID:SCR_017016"]

baseCommand: [flye]


inputs:
  output_folder_name:
    type: string?
    label: Output folder name
    doc: Output folder name
    inputBinding:
      prefix: --out-dir
  nano_raw: # FASTQ read, not FAST5
    type: File?
    #format: edam:format_1930
    label: ONT reads raw
    doc: ONT regular reads in FASTQ format, pre-Guppy5 (<20% error)
    inputBinding:
      prefix: --nano-raw
  nano_corrected:
    type: File?
    #format: edam:format_1930
    label: ONT corrected
    doc: ONT reads in FASTQ format that were corrected with other methods (<3% error)
    inputBinding:
      prefix: --nano-corr
  nano_high_quality:
    type: File?
    #format: edam:format_1930
    label: ONT high quality
    doc: ONT high-quality reads in FASTQ format, Guppy5 SUP or Q20 (<5% error)
    inputBinding:
      prefix: --nano-hq
  pacbio_raw:
    type: File?
    #format: edam:format_1930
    label: PacBio reads raw
    doc: PacBio regular CLR  reads in FASTQ format, (<20% error)
    inputBinding:
      prefix: --pacbio-raw
  pacbio_corrected:
    type: File?
    #format: edam:format_1930
    label: PacBio reads corrected
    doc: PacBio  reads in FASTQ format, that were corrected with other methods (<3% error)
    inputBinding:
      prefix: --pacbio-corr
  pacbio_hifi:
    type: File?
    #format: edam:format_1930
    label: PacBio HiFi reads
    doc: PacBio HiFi  reads in FASTQ format, (<1% error)
    inputBinding:
      prefix: --pacbio-hifi

  threads:
    type: int?
    inputBinding:
      prefix: --threads
  polishing_iterations:
    label: Flye will carry out polishing multiple times as determined here
    type: int?
    inputBinding:
      prefix: --iterations
  min_overlap:
    type: int?
    label: minimum overlap between reads
    inputBinding:
      prefix: --min-overlap
  coverage_threshold:
    type: int?
    label: assembly coverage
    doc: |
      Reduced coverage for the initial disjointig assembly. 
      If set, Flye will downsample the reads to the specified coverage before assembly.
      Useful for high-coverage datasets to reduce memory usage. 
      If not set, Flye will use all available reads.
    inputBinding:
      prefix: --asm-coverage
  metagenome:
    type: boolean?
    label: Metagenome
    doc: Set to true if assembling a metagenome
    inputBinding:
      prefix: --meta
  debug_mode:
    type: boolean?
    label: Debug mode
    doc: Set to true to display debug output while running
    inputBinding:
      prefix: --debug
  genome_size:
    type: string?
    label: Genome size
    doc: Estimated genome size (for example, 5m or 2.6g)
    inputBinding:
      prefix: --genome-size


outputs:
  # flye_outdir:
  #   label: Directory containing all output produced by flye
  #   type: Directory
  #   outputBinding:
  #     glob: $(inputs.output_folder_name)
  00_assembly:
    type: Directory
    outputBinding:
      glob: $(inputs.output_folder_name)/00-assembly
  10_consensus:
    type: Directory
    outputBinding:
      glob: $(inputs.output_folder_name)/10-consensus
  20_repeat:
    type: Directory
    outputBinding:
      glob: $(inputs.output_folder_name)/20-repeat
  30_contigger:
    type: Directory
    outputBinding:
      glob: $(inputs.output_folder_name)/30-contigger
  40_polishing:
    type: Directory
    outputBinding:
      glob: $(inputs.output_folder_name)/40-polishing
  assembly:
    doc: Polished assembly created by flye, main output for next tool.
    type: File
    outputBinding:
      glob: $(inputs.output_folder_name)/assembly.fasta
  assembly_info:
    type: File
    outputBinding:
      glob: $(inputs.output_folder_name)/assembly_info.txt
  flye_log:
    type: File
    outputBinding:
      glob: $(inputs.output_folder_name)/flye.log
  params:
    type: File
    outputBinding:
      glob: $(inputs.output_folder_name)/params.json
  assembly_graph:
    type: File
    outputBinding:
      glob: $(inputs.output_folder_name)/assembly_graph.gfa


$namespaces:
  s: https://schema.org/   
  edam: http://edamontology.org/ 
s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0009-0001-1350-5644
    s:email: mailto:changlin.ke@wur.nl
    s:name: Changlin Ke
  - class: s:Person
    s:identifier: https://orcid.org/0000-0002-5516-8391
    s:email: mailto:german.royvalgarcia@wur.nl
    s:name: Germán Royval
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-8172-8981
    s:email: mailto:jasper.koehorst@wur.nl
    s:name: Jasper Koehorst
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse
  - class: s:Person
    s:identifier: https://orcid.org/0009-0005-0017-0928
    s:email: mailto:martijn.melissen@wur.nl
    s:name: Martijn Melissen
s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateCreated: "2021-11-29"
s:dateModified: "2025-02-17"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"