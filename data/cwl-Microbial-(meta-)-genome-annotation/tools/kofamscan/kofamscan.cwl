#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

label: "KofamScan"

doc: |
   KofamScan / KofamKOALA assigns K numbers to the user's sequence data by HMMER/HMMSEARCH against KOfam, a customized HMM database of KEGG Orthologs (KOs). 
   K number assignments with scores above the predefined thresholds for individual KOs are more reliable than other proposed assignments. 
   Such high score assignments are highlighted with asterisks '*' in the output. 
   The K number assignments facilitate the interpretation of the annotation results by linking the user's sequence data to the KEGG pathways and EC numbers..

hints:
  SoftwareRequirement:
    packages:
      hmmer:
        version: ["3.2.1"]
        specs: ["https://anaconda.org/bioconda/hmmer","doi.org/10.1093/nar/gkr367"]
      kofamscan:
        version: ["1.3.0"]
        specs: ["https://anaconda.org/bioconda/kofamscan","doi.org/10.1093/bioinformatics/btu031"]

  DockerRequirement:
    dockerPull: docker-registry.wur.nl/m-unlock/docker/kofamscan:1.3.0-db.2024-01-01

requirements:
  InlineJavascriptRequirement: {}

baseCommand: ["exec_annotation"]

inputs:
  input_fasta:
    type: File
    doc: Protein sequences in fasta file format
    label: Protein fasta file
    inputBinding:
      position: 100
  threads:
    type: int?
    default: 3
    inputBinding:
      prefix: --cpu
  ko_list:
    type: File?

  profile_organism:
    label: Profile organism
    type: string?
    doc: Specify organism profile; 'eukaryote' and 'prokaryote' are valid choices for the build-in database. Takes the ".hal" file in the profile directory with given name.

  profile_directory:
    type: Directory?
    label: Profile directory
    doc: "Use a custom profile directory instead of the build-in version."

  format:
    type:
      - "null"
      - type: enum
        symbols:
          - detail
          - detail-tsv
          - mapper
          - mapper-one-line
        inputBinding:
          prefix: --format
    default: detail-tsv
    doc: |
          Format of the output. (default detail-tsv)
          detail:          Detail for each hits (including hits below threshold)
          detail-tsv:      Tab separeted values for detail format
          mapper:          KEGG Mapper compatible format
          mapper-one-line: Similar to mapper, but all hit KOs are listed in one line

arguments:
  - prefix: "-f"
    valueFrom: "detail-tsv"
  - prefix: "-o"
    valueFrom: $(inputs.input_fasta.nameroot).KofamKOALA.txt
  - prefix: "--profile"
    valueFrom: |
      ${
        // set profile organism subset (.hal) file
        var po = "";
        if (inputs.profile_organism){
          po = "/"+inputs.profile_organism+".hal" ;
        }
        // check if custom profile directory is used
        if (inputs.profile_directory){
          return inputs.profile_directory.path+po
        }
        // else use default built-in kofam database
        else { 
          return "/profiles"+po;
        }
      }
  - prefix: "--ko-list"
    valueFrom: |
      ${
        if (inputs.ko_list){
          return inputs.ko_list;
        } else {
          return '/ko_list';
        }
      }

outputs:
  output: 
    type: File
    outputBinding:
      glob: $(inputs.input_fasta.nameroot).KofamKOALA.txt

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

s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateCreated: "2022-00-00"
s:dateModified: "2024-03-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/