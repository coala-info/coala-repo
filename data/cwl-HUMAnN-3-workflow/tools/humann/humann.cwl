#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool
label: HUMAnN Analysis

doc: |
  Runs the HUMAnN 3 meta-omics taxonomic and functional profiling tool.

requirements:
 - class: InlineJavascriptRequirement

hints:
  SoftwareRequirement:
    packages:
      humann:
        version: ["3.8"]
        specs: ["https://anaconda.org/bioconda/humann", "doi.org/10.7554/eLife.65088"]      
  DockerRequirement:
    dockerPull: quay.io/biocontainers/humann:3.9--py312hdfd78af_0

baseCommand: [humann]

stdout: $(inputs.identifier)_HUMAnN.stdout.log

arguments:
  - prefix: "--output"
    valueFrom: $(inputs.identifier)_HUMAnN
  - prefix: "--o-log"
    valueFrom: $(inputs.identifier)_HUMAnN.log

# humann --threads 40 -i input.fq.gz --input-format fastq.gz --search-mode uniref90 --taxonomic-profile profiled_metagenome_metaphlan.txt --protein-database /scratch_nr/databases/humann3/uniref90_201901b_full --o-log humann3.log --output-basename TEST --output-format tsv -o humann3_out --nucleotide-database /scratch_nr/databases/humann3/chocophlan_v201901_v31

inputs:
  identifier:
    type: string
    doc: Identifier for output files.
    label: Identifier

  input_file:
    type: File
    doc: a single file that is one of the following types
      filtered shotgun sequencing metagenome file (fastq, fastq.gz, fasta, or fasta.gz format)
      alignment file (sam, bam or blastm8 format)
      gene table file (tsv or biom format)
    label: Input
    inputBinding:
      prefix: --input

  metaphlan-options:
    type: string?
    doc: location of a indexed metaphlan database
    label: metaphlan database
    inputBinding:
      prefix: --metaphlan-options

  taxonomic_profile:
    type: File?
    doc: A taxonomic profile (the output file created by metaphlan)
    label: Taxonomic Profile
    inputBinding:
      prefix: --taxonomic-profile

  search_mode:
    type: string?
    doc: Search for uniref50 or uniref90 gene families. Default, based on translated database selected.
    label: Search mode
    inputBinding:
      prefix: --search-mode

#--protein-database /scratch_nr/databases/humann3/uniref90_201901b_full
  protein_database:
    type: Directory?
    doc: Directory containing the protein database
    label: Protein database
    inputBinding:
      prefix: --protein-database

  nucleotide_database:
    type: Directory?
    doc: Directory containing the nucleotide database
    label: Nucleotide database
    inputBinding:
      prefix: --nucleotide-database

  threads:
    type: int?
    inputBinding:
      prefix: --threads

outputs:
  genefamilies_out:
    type: File
    outputBinding:
      glob: $(inputs.identifier)_HUMAnN/*_genefamilies.tsv
      outputEval: ${self[0].basename=inputs.identifier+"_HUMAnN_genefamilies.tsv"; return self;}
  pathabundance_out:
    type: File
    outputBinding:
      glob: $(inputs.identifier)_HUMAnN/*_pathabundance.tsv
      outputEval: ${self[0].basename=inputs.identifier+"_HUMAnN_pathabundance.tsv"; return self;}
  pathcoverage_out:
    type: File
    outputBinding:
      glob: $(inputs.identifier)_HUMAnN/*_pathcoverage.tsv
      outputEval: ${self[0].basename=inputs.identifier+"_HUMAnN_pathcoverage.tsv"; return self;}
 
  log_out:
    type: File
    outputBinding:
      glob: $(inputs.identifier)_HUMAnN.log
  
  stdout_out:
    type: File
    outputBinding:
      glob: $(inputs.identifier)_HUMAnN.stdout.log

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-8172-8981
    s:email: mailto:jasper.koehorst@wur.nl
    s:name: Jasper Koehorst
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse
  - class: s:Person
    s:identifier: https://orcid.org/0009-0001-1350-5644
    s:email: mailto:changlin.ke@wur.nl
    s:name: Changlin Ke

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateCreated: "2021-00-00"
s:dateModified: "2024-05-22"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
