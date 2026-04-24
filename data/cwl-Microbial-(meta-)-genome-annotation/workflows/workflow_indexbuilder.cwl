#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow
requirements:
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}
  MultipleInputFeatureRequirement: {}
  ScatterFeatureRequirement: {}

label: Indices builder from GBOL RDF (TTL)
doc: |
    Workflow to build different indices for different tools from a genome and transcriptome. 

    This workflow expects an (annotated) genome in GBOL ttl format.

    Steps:
      - SAPP: rdf2gtf (genome fasta)
      - SAPP: rdf2fasta (transcripts fasta)
      - STAR index (Optional for Eukaryotic origin)
      - bowtie2 index
      - kallisto index

outputs:
  STAR:
    type: Directory
    label: STAR
    doc: STAR index folder
    outputSource: STAR/STAR
  bowtie2:
    type: Directory
    label: bowtie2
    doc: bowtie2 index folder
    outputSource: bowtie2/bowtie2_index_dir
  kallisto:
    label: kallisto
    doc: kallisto index folder
    type: Directory
    outputSource: kallisto/kallisto_indexFolder
  genomefasta:
    label: Genome fasta
    doc: Genome fasta file
    type: [File]
    outputSource: [rdf2gtf/genomefasta]
  gtf:
    label: GTF
    doc: Genes in GTF format
    type: [File]
    outputSource: [rdf2gtf/gtf]
  transcripts:
    label: Transcripts
    doc: Transcripts fasta file
    type: [File]
    outputSource: [rdf2fasta/transcripts]
  proteins:
    label: Proteins
    doc: Proteins fasta file
    type: [File]
    outputSource: [rdf2fasta/proteins]

inputs:
  threads:
    type: int?
    doc: number of threads to use for computational processes
    label: number of threads
  memory:
    type: int?
    doc: maximum memory usage in megabytes
    label: maximum memory usage in megabytes
  inputFile:
    label: Input File
    doc: Annotated genome in GBOL turtle file (.ttl) format
    type: File
  run_star:
    label: Run STAR
    doc: create STAR index for genome if true. (For genomes with exons)
    type: boolean

  genomeSAindexNbases:
  # TODO calculate genomeSAindexNbases automatically per genome
    type: int?
    doc: For small genomes, the parameter --genomeSAindexNbases must be scaled down.
    label: STAR parameter

  destination:
    type: string?
    label: Output Destination
    doc: Optional Output destination used for cwl-prov reporting.

steps:
  #########################################
  # Workflow for SAPP rdf2gtf
  rdf2gtf:
    label: RDF to GTF
    doc: Convert input RDF (turtle) file to GTF file
    run: ../tools/sapp/conversion_rdf2gtf.cwl
    in:
      inputFile: inputFile
    out: [genomefasta,gtf]
  #########################################
  # Workflow for SAPP rdf2fasta
  rdf2fasta:
    label: RDF to Fasta
    doc: Convert input RDF (turtle) file to Genome fasta file. 
    run: ../tools/sapp/conversion_rdf2fasta.cwl
    in:
      inputFile: inputFile
    out: [transcripts,proteins]
  #########################################
  # Workflow for STAR
  STAR:
    label: STAR index
    doc: Creates STAR index with genome fasta and GTF file 
    when: $(inputs.run_star)
    run: ../tools/RNAseq/star/star_index.cwl
    in:
      run_star: run_star
      inputFile: rdf2gtf/genomefasta
      sjdbGTFfile: rdf2gtf/gtf
      genomeSAindexNbases: genomeSAindexNbases
      # TODO calculate genomeSAindexNbases automatically per genome
    out: [STAR]
  #########################################
  # Workflow for bowtie2
  bowtie2:
   label: bowtie2 index
   doc: Creates bowtie2 index with genome fasta
   run: ../tools/bowtie2/bowtie2_index.cwl
   in:
    reference: rdf2gtf/genomefasta
   out: [bowtie2_index_dir]

  #########################################
  # Workflow for kallisto
  kallisto:
   label: kallisto index
   doc: Creates kallisto index with transcripts fasta file
   run: ../tools/RNAseq/kallisto/kallisto_index.cwl
   in:
    inputFile: rdf2fasta/transcripts
   out: [kallisto_indexFolder]
#############################################

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
s:dateModified: "2022-05-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"


$namespaces:
  s: https://schema.org/
