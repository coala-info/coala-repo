#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

label: sylph-tax
doc: |
    Sylph is an efficient and accurate metagenome profiler. 
    However, its output does not have taxonomic information. 
    sylph-tax can turn sylph's TSV output into a taxonomic profile like Kraken or MetaPhlAn. 
    sylph-tax does this by using custom taxonomy files to annotate sylph's output.

    Currently only works with a single sylph input tsv and 1 taxonomy metadata file.

hints:
  SoftwareRequirement:
    packages:
      sylph-tax:
        version: ["1.5.1"]
        specs: ["identifiers.org/RRID:SCR_026478","https://anaconda.org/bioconda/sylph-tax","https://doi.org/10.1038/s41587-024-02412-y"]
  DockerRequirement:
    dockerPull: docker-registry.wur.nl/m-unlock/docker/sylph_sylph-tax:0.8.1_1.5.1

requirements:
  InlineJavascriptRequirement: {}

baseCommand: [sylph-tax, taxprof]

arguments:
  - prefix: "--taxonomy-metadata"
    position: 99
    shellQuote: false
    valueFrom: |
      ${
        if (inputs.taxonomy_metadata.taxonomy_metadata_file){
          return inputs.taxonomy_metadata.taxonomy_metadata_file.path
        } else {
          return inputs.taxonomy_metadata.builtin_taxonomy_metadata
        }
      }

inputs:
  output_filename_prefix:
    type: string
    doc: Name of the output file. If present builtin_taxonomy will appended i.e. GTDB_R220.sylphmpa Otherwise only .sylphmpa
    label: Output filename (base)

  sylph_profile:
    type: File
    doc: "Sylph profile coming from the 'sylph profile' tool function"
    label: Sylph profile
    inputBinding:
      position: 0

  taxonomy_metadata:
    type:
      - type: record
        name: builtin_taxonomy_metadata
        fields:
          builtin_taxonomy_metadata:
            type:
              - type: enum
                symbols:
                  - GTDB_r214
                  - GTDB_r220
                  - GTDB_r226
                  - IMGVR_4.1
                  - SoilSMAG
                  - OceanDNA
                  - TaraEukaryoticSMAG
                  - FungiRefSeq-2024-07-25
            doc: Provided taxonomy metadata from default sylph databases. (only available when running with the container image)
            label: Taxonomy metadata
      - type: record
        name: taxonomy_metadata_file
        fields:
          taxonomy_metadata_file:
            type: File
            doc: Taxonomy metadata file(s) that are not incorporated in the docker image.
            label: Taxonomy metadata file

  annotate_virus_hosts:
    type: boolean
    doc: Add additional column(s) by integrating viral-host information available (currently available for IMGVR4.1). Default false
    label: Annotate virus hosts
    default: false
    inputBinding:
      prefix: --annotate-virus-hosts
      position: 99
  
  pavian_format:
    type: boolean
    doc: Output in Pavian compatible format. Default false
    label: Pavian format
    default: false
    inputBinding:
      prefix: --pavian
      position: 99

outputs:
  sylph_tax:
    type: File
    outputBinding:
      glob: $('*.sylphmpa')
      outputEval: |
        ${ 
           // rename default output name and include builtin taxonomy name when used to the outputname
           if (inputs.taxonomy_metadata.builtin_taxonomy_metadata){
            self[0].basename=inputs.output_filename_prefix+"."+(inputs.taxonomy_metadata.builtin_taxonomy_metadata+".sylphmpa").toLowerCase(); return self; 
           } else {
            self[0].basename=inputs.output_filename_prefix+".sylphmpa"; return self;
           }           
          }

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateCreated: "2025-02-21"
s:dateModified: "2025-08-06"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
