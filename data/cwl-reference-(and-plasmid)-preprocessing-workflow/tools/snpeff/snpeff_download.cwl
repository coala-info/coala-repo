#!/usr/bin/env cwltool

cwlVersion: v1.2
class: CommandLineTool

label: SNPeff database downloading

doc: |
  This tool downloads a SNPeff database for a specified genome.
  It is intended to be run once to prepare a database that can be reused in subsequent workflow runs.
  
  The command executed is:
  
      java -jar /usr/local/share/snpeff-5.2-1/snpEff.jar download <genome> [extra_options]
  
  The output is a directory containing the SNPeff database.

requirements:
  InlineJavascriptRequirement: {}
  ShellCommandRequirement: {}
  NetworkAccess:
     networkAccess: true
  DockerRequirement:
    dockerPull: quay.io/biocontainers/snpeff:5.2--hdfd78af_1
  InitialWorkDirRequirement:
    listing:
      - entryname: snpeff_database
        writable: true
        entry: $(null)

hints:
  SoftwareRequirement:
    packages:
      snpeff:
        version: ["5.2.1"]
        specs: ["identifiers.org/RRID:SCR_005191"]
  
baseCommand: [ "java", "-jar", "/usr/local/share/snpeff-5.2-1/snpEff.jar" ]

arguments:
  - valueFrom: "snpeff_database"  # hardcoded to create database folder - can also add as input
    prefix: -dataDir $PWD/
    separate: false
    position: 2
    shellQuote: false

inputs:
  genome:
    type: string
    label: genome/database identifier
    doc: Identifier for the SNPeff database to download (e.g. 'GRCh37.75' for human, or a custom name for microbial strains).
    inputBinding:
      position: 1
      prefix: download
  extra_options:
    type: string?
    label: extra options
    doc: Additional command-line options for SNPeff.
    inputBinding:
      position: 3

outputs:
  database_dir:
    type: Directory
    label: "SNPeff Database Directory"
    doc: "The directory containing the downloaded SNPeff database."
    outputBinding:
      glob: "snpeff_database"

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
s:dateCreated: "2025-02-21"
s:dateModified: "2025-02-24"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"