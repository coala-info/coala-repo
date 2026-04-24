#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool
label: HUMAnN3 humann_regroup_table

doc: |
  Runs the HUMAnN 3 humann_regroup_table function.
  HUMAnN utility for regrouping table features
  =============================================
  Given a table of feature values and a mapping of groups to component features, produce a 
  new table with group values in place of feature values.

  This tool makes use of the docker image wherein the utility mapping databases are included.
  It includes a script by which you can create all possible mappings at once or separately.

  Docker build:
  https://gitlab.com/m-unlock/docker/-/tree/main/tools/humann3?ref_type=heads

hints:
  SoftwareRequirement:
    packages:
      humann:
        version: ["3.8"]
        specs: ["https://anaconda.org/bioconda/humann", "doi.org/10.7554/eLife.65088"]      
  DockerRequirement:
    dockerPull: docker-registry.wur.nl/m-unlock/docker/humann:3.9

requirements:
  InlineJavascriptRequirement: {}

baseCommand: [humann_regroup_table.sh]

inputs:
  threads:
    type: int?
    doc: Maximum threads to use
    label: Threads
    inputBinding:
      position: 0

  output_filename_prefix:
    type: string
    doc: Optional output filename. Default is based on the input table; inputtablename_uniref-type_group.tsv
    label: Threads
    inputBinding:
      position: 2

  add_unireftype:
    type:
      - type: enum
        symbols:
          - Y
          - N
    doc: Add uniref_type to output file name.  Default Y. (Ignored when output_filename_prefix is used)
    label: Add uniref type
    inputBinding:
      position: 3

  uniref_type:
    type:
      - type: enum
        symbols:
          - uniref90
          - uniref50
    doc: UniRef50 or UniRef90. Match this with the database you used. Only has effect when selected "all" as the group input.
    label: UniRef database type
    inputBinding:
      position: 2

  input_table:
    type: File
    doc: Input table
    label: Input table
    inputBinding:
      prefix: --input
      position: 13

  group:
    type:
      - type: enum
        symbols:
          - all
          - uniref90_rxn
          - uniref90_go
          - uniref90_ko
          - uniref90_level4ec
          - uniref90_pfam
          - uniref90_eggnog
          - uniref50_rxn
          - uniref50_go
          - uniref50_ko
          - uniref50_level4ec
          - uniref50_pfam
          - uniref50_eggnog
    doc: Built in grouping options. Choose all to generate all possible tables based on your uniref_type input.
    label: Group
    inputBinding:
      prefix: --group
      position: 99

  precision:
    type: int?
    doc: Decimal places to round to after applying function; default=Don't round
    label: Precision
    inputBinding:
      prefix: --precision
      position: 14

  function:
    type:
      - type: enum
        symbols:
          - sum
          - mean
    doc: How to combine grouped features; default=sum
    label: Function
    inputBinding:
      prefix: --function
      position: 15

  ungrouped:
    type:
      - type: enum
        symbols:
          - Y
          - N
    doc: Include an 'UNGROUPED' group to capture features that did not belong to other groups? default=Y
    label: Ungrouped
    inputBinding:
      prefix: --ungrouped
      position: 16

  protected:
    type:
      - type: enum
        symbols:
          - Y
          - N
    doc: Carry through protected features, such as 'UNMAPPED'? default=Y
    label: Protected
    inputBinding:
      prefix: --protected
      position: 17


outputs:
  regrouped_table:
    type: File[]?
    outputBinding:
      glob: "*.tsv"

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateModified: "2025-02-21"
s:dateCreated: "2025-02-11"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
