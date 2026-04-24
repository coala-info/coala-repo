#!/usr/bin/env cwltool

cwlVersion: v1.2
class: CommandLineTool

label: "QUAST: Quality Assessment Tool for Genome Assemblies"

doc: |
  Runs the Quality Assessment Tool for Genome Assemblies application
  Documentation on how to install and run QUAST can be found here:
  https://quast.sourceforge.net/docs/manual.html

requirements:
    InlineJavascriptRequirement: {}
    InitialWorkDirRequirement: 
      listing:
      - entry: "$({class: 'Directory', listing: []})"
        entryname: "QUAST_results" # is this required?
        writable: true

hints:
  SoftwareRequirement:
    packages:
      quast:
        version: ["5.3.0"]
        specs: ["identifiers.org/RRID:SCR_001228 "]
  DockerRequirement:
    dockerPull: quay.io/biocontainers/quast:5.3.0--py311pl5321hc84137b_1

baseCommand: [quast]

arguments:
  - valueFrom: "QUAST_output"
    prefix: --output-dir

inputs:
  assembly:
    type: File
    #format: edam:format_1929
    doc: The input assembly in fasta format
    label: assembly fasta file
    inputBinding:
      position: 1
  reference_genome:
    type: File?
    doc: | 
      Reference genome file. Optional. Many metrics can't be evaluated without a reference.
      If this is omitted, QUAST will only report the metrics that can be evaluated without a reference. 
    inputBinding:
      prefix: -r
  features:
    type: File?
    doc:  File with genomic feature coordinates in the reference (GFF, BED, NCBI or TXT)
  contig_treshold:
    type: int?
    doc:  Lower threshold for contig length, default is 500
    inputBinding:
      prefix: --min-contig
  threads:
    type: int?
    doc: The number of threads used, defaults to 25% of CPU
    inputBinding:
      prefix: --threads
  eukaryotic:
    type: boolean?
    label: Eukaryotic genome
    doc: |
      Genome is eukaryotic. Affects gene finding, conserved orthologs finding and contig alignment
      1. For prokaryotes (which is default), GeneMarkS is used. For eukaryotes, GeneMark-ES is used. 
      2. Barrnap will use eukaryotic database to predict ribosomal RNA genes.
      3. BUSCO will use eukaryotic database to find conserved orthologs. 
      4. By default, QUAST assumes that a genome is circular and correctly processes its linear representation. This options indicates that the genome is not circular. 
    inputBinding:
      prefix: --eukaryote
  fungal:
    type: boolean?
    label: Fungal genome
    doc: |
      Genome is fungal. Affects gene finding, conserved orthologs finding and contig alignment:
      1. For gene finding, GeneMark-ES is used with --fungus option. 
      2. Barrnap will use eukaryotic database to predict ribosomal RNA genes. 
      3. BUSCO will use fungal database to find conserved orthologs. 
      4. By default, QUAST assumes that a genome is circular and correctly processes its linear representation. This options indicates that the genome is not circular.
    inputBinding:
      prefix: --fungus
  large_genome:
    type: boolean?
    label: Large genome
    doc: |
      Genome is large (typically > 100 Mbp). Use optimal parameters for evaluation of large genomes. Affects speed and accuracy.
      In particular, imposes --eukaryote --min-contig 3000 --min-alignment 500 --extensive-mis-size 7000 (can be overridden manually with the corresponding options).
      In addition, this mode tries to identify misassemblies caused by transposable elements and exclude them from the number of misassemblies.
    inputBinding:
      prefix: --large
  gene_finding:
    type: boolean?
    label: Enable gene finding. Affects performance
  

outputs:
  quast_outdir:
    type: Directory
    outputBinding:
      glob: QUAST_output
  basicStats:
    type: Directory
    outputBinding:
      glob: QUAST_output/basic_stats
  icarusDir:
    type: Directory
    outputBinding:
      glob: QUAST_output/icarus_viewers
  icarusHtml:
    type: File
    outputBinding:
      glob: QUAST_output/icarus.html
  quastReport:
    type: File[]
    outputBinding:
      glob: QUAST_output/report.*
  quastLog:
    type: File
    outputBinding:
      glob: QUAST_output/quast.log
  transposedReport:
    type: File[]
    outputBinding:
      glob: QUAST_output/transposed_report.*

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
s:dateModified: "2024-10-07"
s:dateCreated: "2021-11-25"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"