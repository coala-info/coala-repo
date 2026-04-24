#!/usr/bin/env cwltool

cwlVersion: v1.2
class: CommandLineTool

requirements:
    InlineJavascriptRequirement: {}

hints:
  SoftwareRequirement:
    packages:
      flye:
        version: ["2.9.6"]
        specs: ["https://anaconda.org/bioconda/flye", "doi.org/10.1038/s41592-020-00971-x", "https://identifiers.org/RRID:SCR_017016"]

  DockerRequirement:
    dockerPull: quay.io/biocontainers/flye:2.9.6--py310h275bdba_0

baseCommand: [flye]

label: Flye
doc: Flye De novo assembler for single molecule sequencing reads, with a focus in Oxford Nanopore Technologies reads

arguments:
  - valueFrom: "flye_output"
    prefix: --out-dir

inputs:
  output_filename_prefix:
    type: string?
    doc: Prefix for output files. Underscore will be added after. Default none
    label: Output prefix

  nano_raw: # FASTQ read, not FAST5
    type: File?
    label: ONT reads raw
    doc: ONT regular reads in FASTQ format, pre-Guppy5 (<20% error)
    inputBinding:
      prefix: --nano-raw
  nano_corrected:
    type: File?
    label: ONT corrected
    doc: ONT reads in FASTQ format that were corrected with other methods (<3% error)
    inputBinding:
      prefix: --nano-corr
  nano_high_quality:
    type: File?
    label: ONT high quality
    doc: ONT high-quality reads in FASTQ format, Guppy5+ (SUP mode) and Q20 reads (3-5% error rate)
    inputBinding:
      prefix: --nano-hq
  pacbio_raw:
    type: File?
    label: PacBio reads raw
    doc: PacBio regular CLR  reads in FASTQ format, (<20% error)
    inputBinding:
      prefix: --pacbio-raw
  pacbio_corrected:
    type: File?
    label: PacBio reads corrected
    doc: PacBio  reads in FASTQ format, that were corrected with other methods (<3% error)
    inputBinding:
      prefix: --pacbio-corr
  pacbio_hifi:
    type: File?
    label: PacBio HiFi reads
    doc: PacBio HiFi  reads in FASTQ format, (<1% error)
    inputBinding:
      prefix: --pacbio-hifi

  threads:
    type: int
    label: Threads
    doc: Maximum threads to use. Default 1
    inputBinding:
      prefix: --threads
  polishing_iterations:
    label: Flye will carry out polishing multiple times as determined here. Default 1
    type: int
    inputBinding:
      prefix: --iterations
  metagenome:
    type: boolean
    label: Metagenome
    doc: Set to true if assembling a metagenome. Default false
    inputBinding:
      prefix: --meta
  debug_mode:
    type: boolean
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
  deterministic:
    type: boolean
    label: deterministic
    doc: Perform disjointig assembly single-threaded. Default false
    inputBinding:
      prefix: --deterministic
  keep_haplotypes:
    type: boolean
    label: Keep haplotypes
    doc: do not collapse alternative haplotypes. Default false
    inputBinding:
      prefix: --keep-haplotypes
  no_alt_contigs:
    type: boolean
    label: No alternative contigs
    doc: Do not output contigs representing alternative haplotypes. Default false
    inputBinding:
      prefix: --no-alt-contigs

outputs:
  00_assembly:
    type: Directory
    outputBinding:
      glob: flye_output/00-assembly
  10_consensus:
    type: Directory
    outputBinding:
      glob: flye_output/10-consensus
  20_repeat:
    type: Directory
    outputBinding:
      glob: flye_output/20-repeat
  30_contigger:
    type: Directory
    outputBinding:
      glob: flye_output/30-contigger
  40_polishing:
    type: Directory
    outputBinding:
      glob: flye_output/40-polishing
  assembly:
    label: Polished assembly created by flye, main output for after polishing with next tool
    type: File
    outputBinding:
      glob: flye_output/assembly.fasta
      outputEval: |
        ${
           // rename default output name and add prefix if given
           if (inputs.output_filename_prefix) {
            self[0].basename=inputs.output_filename_prefix+"_flye_assembly.fasta"; return self; 
           } else {
            self[0].basename="flye_assembly.fasta"; return self;
           }
        }
  assembly_info:
    type: File
    outputBinding:
      glob: flye_output/assembly_info.txt
      outputEval: |
        ${
           // rename default output name and add prefix if given
           if (inputs.output_filename_prefix) {
            self[0].basename=inputs.output_filename_prefix+"_flye_assembly_info.txt"; return self; 
           } else {
            self[0].basename="flye_assembly_info.txt"; return self;
           }
        }
  flye_log:
    type: File
    outputBinding:
      glob: flye_output/flye.log
      outputEval: |
        ${
           // rename default output name and add prefix if given
           if (inputs.output_filename_prefix) {
            self[0].basename=inputs.output_filename_prefix+"_flye.log"; return self; 
           } else { return self;}
        }
  params:
    type: File
    outputBinding:
      glob: flye_output/params.json
      outputEval: |
        ${
           // rename default output name and add prefix if given
           if (inputs.output_filename_prefix) {
            self[0].basename=inputs.output_filename_prefix+"_flye_params.json"; return self; 
           } else {
            self[0].basename="flye_params.json"; return self;
           }
        }
  assembly_graph:
    type: File
    outputBinding:
      glob: flye_output/assembly_graph.gfa
      outputEval: |
        ${
           // rename default output name and add prefix if given
           if (inputs.output_filename_prefix) {
            self[0].basename=inputs.output_filename_prefix+"_flye_assembly_graph.gfa"; return self; 
           } else {
            self[0].basename="flye_assembly_graph.gfa"; return self;
           }
        }

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
    s:identifier: https://orcid.org/0000-0002-5516-8391
    s:email: mailto:german.royvalgarcia@wur.nl
    s:name: Germán Royval
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-8172-8981
    s:email: mailto:jasper.koehorst@wur.nl
    s:name: Jasper Koehorst

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateCreated: "2021-11-29"
s:dateModified: "2025-05-22"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
