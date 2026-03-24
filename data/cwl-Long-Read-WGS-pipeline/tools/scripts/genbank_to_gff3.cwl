#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

label: GFF3 extraction Perl script

doc: Uses a BioPerl script to extract a GFF3 file from a GenBank file.

requirements:
  InlineJavascriptRequirement: {}

hints:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/perl-bioperl-run:1.007002--pl526_3
  SoftwareRequirement:
    packages:
      bcbio-gff:
        version: ["1.007002"]
        specs: ["identifiers.org/RRID:SCR_002989"]

baseCommand: ["perl"]

inputs:
  script:
    type: File
    label: Perl script
    doc: The Perl script "bp_genbank2gff3_fixed.pl".
    inputBinding:
      position: 1
  genbank_file:
    label: GenBank file
    doc: Input GenBank file.
    type: File
    inputBinding:
      position: 2

outputs:
  gff3:
    type: File?
    label: extracted GFF3 file
    doc: The extracted GFF3 file with proper extension.
    outputBinding:
      glob: "*.gff"
      outputEval: ${self[0].basename = self[0].basename.replace('.gb.gff', '.gff3'); return self}

$namespaces:
  s: https://schema.org/
s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0009-0005-0017-0928
    s:email: mailto:martijn.melissen@wur.nl
    s:name: Martijn Melissen
s:citation: https://m-unlock.nl
s:codeRepository: https://git.wur.nl/ssb/automated-data-analysis
s:dateCreated: "2025-05-06"
s:dateModified: "2025-05-06"
s:license: https://spdx.org/licenses/Apache-2.0
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"