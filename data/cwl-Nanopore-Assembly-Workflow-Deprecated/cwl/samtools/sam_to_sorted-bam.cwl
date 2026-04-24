#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

label: "sam to sorted bam"
doc: |
  samtools view -@ $2 -hu $1 | samtools sort -@ $2 -o $3.bam

requirements:
 - class: ShellCommandRequirement
 - class: InlineJavascriptRequirement

inputs:
  identifier:
    type: string
    doc: Identifier for this dataset used in this workflow
    label: identifier used

  sam:
    type: File
    doc: unsorted sam file
    label: unsorted sam file
  
  threads:
      type: int
      doc: number of cpu threads to use
      label: cpu threads

outputs:
  sortedbam: 
    type: File
    outputBinding:
      glob: $(inputs.identifier).bam

arguments:
    - shellQuote: false
      valueFrom: >
        ${
          var samtools_path = "/unlock/infrastructure/binaries/samtools/samtools-v1.15/bin/samtools"
          var cmd = samtools_path + " view -@ " + inputs.threads + " -hu " + inputs.sam.location + "\
              | " + samtools_path + " sort -@ " + inputs.threads + " -o " + inputs.identifier +".bam";
          return cmd;
        }

s:author:
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
s:dateModified: "2022-02-22"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
