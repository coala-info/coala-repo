cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxpasta merge
label: taxpasta_merge
doc: "Standardise and merge two or more taxonomic profiles.\n\nTool homepage: https://github.com/taxprofiler/taxpasta"
inputs:
  - id: profiles
    type:
      - 'null'
      - type: array
        items: File
    doc: Two or more files containing taxonomic profiles. Required unless there 
      is a sample sheet. Filenames will be parsed as sample names.
    inputBinding:
      position: 1
  - id: add_id_lineage
    type:
      - 'null'
      - boolean
    doc: Add the taxon's entire lineage to the output. These are taxon 
      identifiers separated by semi-colons.
    inputBinding:
      position: 102
  - id: add_lineage
    type:
      - 'null'
      - boolean
    doc: Add the taxon's entire lineage to the output. These are taxon names 
      separated by semi-colons.
    inputBinding:
      position: 102
  - id: add_name
    type:
      - 'null'
      - boolean
    doc: Add the taxon name to the output.
    inputBinding:
      position: 102
  - id: add_rank
    type:
      - 'null'
      - boolean
    doc: Add the taxon rank to the output.
    inputBinding:
      position: 102
  - id: add_rank_lineage
    type:
      - 'null'
      - boolean
    doc: Add the taxon's entire rank lineage to the output. These are taxon 
      ranks separated by semi-colons.
    inputBinding:
      position: 102
  - id: ignore_errors
    type:
      - 'null'
      - boolean
    doc: Ignore any metagenomic profiles with errors. Please note that there 
      must be at least two profiles without errors to merge.
    inputBinding:
      position: 102
  - id: output_format
    type:
      - 'null'
      - string
    doc: The desired output format. Depending on the choice, additional package 
      dependencies may apply. By default it will be parsed from the output file 
      name but it can be set explicitly and will then disable the automatic 
      detection.
    inputBinding:
      position: 102
  - id: output_mode
    type:
      - 'null'
      - boolean
    doc: Output merged abundance data in either wide or (tidy) long format. 
      Ignored when the desired output format is BIOM.
    inputBinding:
      position: 102
      prefix: --wide
  - id: profiler
    type: string
    doc: The taxonomic profiler used. All provided profiles must come from the 
      same tool!
    inputBinding:
      position: 102
      prefix: -p
  - id: samplesheet
    type:
      - 'null'
      - File
    doc: "A table with a header and two columns: the first column named 'sample' which
      can be any string and the second column named 'profile' which must be a file
      path to an actual taxonomic abundance profile. If this option is provided, any
      arguments are ignored."
    inputBinding:
      position: 102
      prefix: -s
  - id: samplesheet_format
    type:
      - 'null'
      - string
    doc: The file format of the sample sheet. Depending on the choice, 
      additional package dependencies may apply. Will be parsed from the sample 
      sheet file name but can be set explicitly.
    inputBinding:
      position: 102
  - id: summarise_at
    type:
      - 'null'
      - string
    doc: Summarise abundance profiles at higher taxonomic rank. The provided 
      option must match a rank in the taxonomy exactly. This is akin to the 
      clade assigned reads provided by, for example, kraken2, where the 
      abundances of a whole taxonomic branch are assigned to a taxon at the 
      desired rank. Please note that abundances above the selected rank are 
      simply ignored. No attempt is made to redistribute those down to the 
      desired rank. Some tools, like Bracken, were designed for this purpose but
      it doesn't seem like a problem we can generally solve here.
    inputBinding:
      position: 102
  - id: taxonomy
    type:
      - 'null'
      - Directory
    doc: The path to a directory containing taxdump files. At least nodes.dmp 
      and names.dmp are required. A merged.dmp file is optional.
    inputBinding:
      position: 102
outputs:
  - id: output
    type: File
    doc: The desired output file. By default, the file extension will be used to
      determine the output format, but when setting the format explicitly using 
      the --output-format option, automatic detection is disabled.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxpasta:0.7.0--pyhdfd78af_1
