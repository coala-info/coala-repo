#!/usr/bin/env cwltool

cwlVersion: v1.2
class: CommandLineTool

label: "Minimap2 to (un)mapped long reads"
doc: |
  Get unmapped or mapped long reads reads in fastq.gz format using minimap2 and samtools. Mainly used for contamination removal.
   - requires pigz!
  minimap2 | samtools | pigz

requirements:
  InlineJavascriptRequirement: {}
  ShellCommandRequirement: {}

arguments:
    - shellQuote: false
      valueFrom: >
        ${
          var minimap2_path = "/unlock/infrastructure/binaries/minimap2/minimap2-v2.24/minimap2"
          var samtools_path = "/unlock/infrastructure/binaries/samtools/samtools-v1.15/bin/samtools"
          if (inputs.output_mapped){
            var mapping_type = "-F 4"
          } else {
            var mapping_type = "-f 4"
          }
          // minimap | samtools fastq | pigz
          var cmd = minimap2_path +" --split-prefix temp -a -t "+ inputs.threads +" -x "+ inputs.preset +" "+ inputs.reference.path +" "+ inputs.reads.path +"\
              | "+ samtools_path +" fastq -@ "+ inputs.threads +" -n "+ mapping_type +"\
              | pigz -p "+ inputs.threads + " > " +inputs.identifier + "_filtered.fastq.gz";
          return cmd;
        }
inputs:
  threads:
    type: int?
    doc: Number of CPU-threads used by minimap2.
    label: Threads
  identifier:
    type: string
    doc: Identifier for this dataset used in this workflow
    label: identifier
  reference:
    type: File
    doc: Target sequence in FASTQ/FASTA format (can be gzipped).
    label: Reference
  reads:
    type: File
    doc: Query sequence in FASTQ/FASTA format (can be gzipped).
    label: Reads    
  output_mapped:
    type: boolean?
    doc: Keep reads mapped to the reference (default = output unmapped)
    label: Keep mapped

  preset:
    type: string
    doc: |
      - map-pb/map-ont - PacBio CLR/Nanopore vs reference mapping
      - map-hifi - PacBio HiFi reads vs reference mapping
      - ava-pb/ava-ont - PacBio/Nanopore read overlap
      - asm5/asm10/asm20 - asm-to-ref mapping, for ~0.1/1/5% sequence divergence
      - splice/splice:hq - long-read/Pacbio-CCS spliced alignment
      - sr - genomic short-read mapping
    label: Read type
  
stderr: $(inputs.identifier)_minimap2.log

outputs:
  fastq: 
    type: File
    outputBinding:
      glob: $(inputs.identifier)_filtered.fastq.gz
  log: 
    type: stderr

s:author:
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

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateCreated: "2022-03-00"
s:dateModified: "2022-04-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
