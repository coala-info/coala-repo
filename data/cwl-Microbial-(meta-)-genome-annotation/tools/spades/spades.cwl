#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

label: "SPAdes assembler"

doc: |
    SPAdes is a versatile toolkit designed for assembly and analysis of sequencing data. 
    SPAdes is primarily developed for Illumina sequencing data, but can be used for IonTorrent as well. 
    Most of SPAdes pipelines support hybrid mode, i.e. allow using long reads (PacBio and Oxford Nanopore) as a supplementary data.

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - entryname: input_spades.json
        entry: |-
          [
            {
              orientation: "fr",
              type: "paired-end",
              right reads: $( inputs.forward_reads.map( function(x) {return  x.path} ) ),
              left reads: $( inputs.reverse_reads.map( function(x) {return  x.path} ) )
            }            
            ${
              var pacbio=""
                if (inputs.pacbio_reads != null) {
                 pacbio+=',{ type: "pacbio", single reads: ["' + inputs.pacbio_reads.map( function(x) {return  x.path} ).join('","') + '"] }' 
              }
              return pacbio;
            }
            ${
              var nanopore=""
                if (inputs.nanopore_reads != null) {
                 nanopore+=',{ type: "nanopore", single reads: ["' + inputs.nanopore_reads.map( function(x) {return  x.path} ).join('","') + '"] }'
                //  nanopore+=',{ type: "nanopore", single reads: ["' + inputs.nanopore_reads.join('","') + '"] }'
              }
              return nanopore;
            }
          ]

hints:
  SoftwareRequirement:
    packages:
      spades:
        version: ["3.15.5"]
        specs: ["https://anaconda.org/bioconda/spades", "doi.org/10.1002/cpbi.102"]
  DockerRequirement:
    dockerPull: quay.io/biocontainers/spades:3.15.5--h95f258a_1

baseCommand: [spades.py, --dataset, input_spades.json]

arguments:
  - valueFrom: $(runtime.outdir)/output
    prefix: -o
  - valueFrom: $(inputs.memory / 1000)
    prefix: --memory

inputs:
  output_filename_prefix:
    type: string?
    doc: Prefix for output files. Underscore will be added after. Default none
    label: Output prefix

  isolate:
    type: boolean?
    doc: this flag is highly recommended for high-coverage isolate and multi-cell data
    label: high-coverage mode
    inputBinding:
      prefix: --isolate
  metagenome:
    type: boolean?
    doc: this flag is required for metagenomic sample data
    label: metagenomics sample
    inputBinding:
      prefix: --meta
  biosyntheticSPAdes:
    type: boolean?
    doc: this flag is required for biosyntheticSPAdes mode
    label: biosynthetic spades mode
    inputBinding:
      prefix: --bio
  rna:
    type: boolean?
    doc: this flag is required for RNA-Seq data
    label: rnaseq data
    inputBinding:
      prefix: --rna
  plasmid:
    type: boolean?
    doc: runs plasmidSPAdes pipeline for plasmid detection
    label: plasmid spades run
    inputBinding:
      prefix: --plasmid
  only_assembler:
    type: boolean?
    doc: Runs only assembling (without read error correction)
    label: Only assembler
    inputBinding:
      prefix: --only-assembler
  kmer_sizes:
    type: string?
    doc: List of k-mer sizes (must be odd and less than 128). Separate with comma, no space. Default 'auto'
    label: Kmer sizes
    inputBinding:
      prefix: -k

  IonTorrent:
    type: boolean?
    doc: this flag is required for IonTorrent data
    label: iontorrent data
    inputBinding:
      prefix: --iontorrent
  forward_reads:
    type: File[]
    doc: The file containing the forward reads
    label: Forward reads
  reverse_reads:
    type: File[]
    doc: The file containing the reverse reads
    label: Reverse reads
  pacbio_reads:
    type: File[]?
    doc: Fastq file with PacBio CLR reads
    label: PacBio CLR reads
  nanopore_reads:
    type: File[]?
    doc: Fastq file with Oxford NanoPore reads
    label: NanoPore reads
  threads:
    type: int?
    doc: number of threads to use
    label: threads
    inputBinding:
      prefix: --threads
    default: 10
  memory:
    type: int?
    doc: Memory used in megabytes

outputs:
  # stdout: stdout
  # stderr: stderr
  # json:
  #   type: File
  #   outputBinding:
  #     glob: spades.json
  contigs:
    type: File
    outputBinding:
      glob: output/contigs.fasta
      outputEval: |
        ${ 
           // rename default output name and add prefix if given
           if (inputs.output_filename_prefix) {
            self[0].basename=inputs.output_filename_prefix+"_spades_contigs.fasta"; return self; 
           } else {
            self[0].basename="spades_contigs.fasta"; return self;
           }
        }

  scaffolds:
    type: File
    outputBinding:
      glob: output/scaffolds.fasta
      outputEval: |
        ${ 
           // rename default output name and add prefix if given
           if (inputs.output_filename_prefix) {
            self[0].basename=inputs.output_filename_prefix+"_spades_scaffolds.fasta"; return self; 
           } else {
            self[0].basename="spades_scaffolds.fasta"; return self;
           }
        }

  assembly_graph:
    type: File
    outputBinding:
      glob: output/assembly_graph.fastg
      outputEval: |
        ${ 
           // rename default output name and add prefix if given
           if (inputs.output_filename_prefix) {
            self[0].basename=inputs.output_filename_prefix+"_spades_assembly_graph.fastg"; return self; 
           } else {
            self[0].basename="spades_assembly_graph.fastg"; return self;
           }
        }
  
  assembly_graph_with_scaffolds:
    type: File
    outputBinding:
      glob: output/assembly_graph_with_scaffolds.gfa
      outputEval: |
        ${ 
           // rename default output name and add prefix if given
           if (inputs.output_filename_prefix) {
            self[0].basename=inputs.output_filename_prefix+"_spades_assembly_graph_with_scaffolds.gfa"; return self; 
           } else {
            self[0].basename="spades_assembly_graph_with_scaffolds.gfa"; return self;
           }
        }

  contigs_assembly_paths:
    type: File
    outputBinding:
      glob: output/contigs.paths
      outputEval: |
        ${ 
           // rename default output name and add prefix if given
           if (inputs.output_filename_prefix) {
            self[0].basename=inputs.output_filename_prefix+"_spades_contigs.paths"; return self; 
           } else {
            self[0].basename="spades_contigs.paths"; return self;
           }
        }

  scaffolds_assembly_paths:
    type: File
    outputBinding:
      glob: output/scaffolds.paths
      outputEval: |
        ${ 
           // rename default output name and add prefix if given
           if (inputs.output_filename_prefix) {
            self[0].basename=inputs.output_filename_prefix+"_spades_scaffolds.paths"; return self; 
           } else {
            self[0].basename="spades_scaffolds.paths"; return self;
           }
        }

  contigs_before_rr:
    label: contigs before repeat resolution
    type: File
    outputBinding:
      glob: output/before_rr.fasta
      outputEval: |
        ${ 
           // rename default output name and add prefix if given
           if (inputs.output_filename_prefix) {
            self[0].basename=inputs.output_filename_prefix+"_spades_before_rr.fasta"; return self; 
           } else {
            self[0].basename="spades_before_rr.fasta"; return self;
           }
        }

  params:
    label: information about SPAdes parameters in this run
    type: File
    outputBinding:
      glob: output/params.txt
      outputEval: |
        ${ 
           // rename default output name and add prefix if given
           if (inputs.output_filename_prefix) {
            self[0].basename=inputs.output_filename_prefix+"_spades_params.txt"; return self; 
           } else {
            self[0].basename="spades_params.txt"; return self;
           }
        }
  log:
    label: SPAdes log
    type: File
    outputBinding:
      glob: output/spades.log
      outputEval: |
        ${ 
           // rename default output name and add prefix if given
           if (inputs.output_filename_prefix) {
            self[0].basename = inputs.output_filename_prefix+"_spades.log"; return self; 
           } else { return self; }
        }

  internal_config:
    label: internal configuration file
    type: File
    outputBinding:
      glob: output/dataset.info
      outputEval: |
        ${ 
           // rename default output name and add prefix if given
           if (inputs.output_filename_prefix) {
            self[0].basename=inputs.output_filename_prefix+"_spades_dataset.info"; return self; 
           } else {
            self[0].basename="spades_dataset.info"; return self;
           }
        }

  internal_dataset:
    label: internal YAML data set file
    type: File
    outputBinding:
      glob: output/input_dataset.yaml
      outputEval: |
        ${ 
           // rename default output name and add prefix if given
           if (inputs.output_filename_prefix) {
            self[0].basename=inputs.output_filename_prefix+"_spades_input_dataset.yaml"; return self; 
           } else {
            self[0].basename="spades_input_dataset.yaml"; return self;
           }
        }

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
s:dateCreated: "2020-00-00"
s:dateModified: "2024-05-22"
s:license: https://spdx.org/licenses/CC0-1.0.html 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"


$namespaces:
 s: http://schema.org/
