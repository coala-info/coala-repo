#!/usr/bin/env cwltool

cwlVersion: v1.2
class: CommandLineTool

label: SNPeff database building

doc: |
  This tool builds a SNPeff database for a specified genome with either a GenBank file or a NCBI entry.
  NCBI GenBank is assumed to contain both sequence and protein (CDS) data.
  
  The command executed is:
      java -jar /usr/local/share/snpeff-5.2-1/snpEff.jar build -v <genome> [extra_options]
  
  The output is a directory containing the SNPeff database as well as an edited config file to be used in the annotation step.

requirements:
  InlineJavascriptRequirement: {}
  ShellCommandRequirement: {}
  NetworkAccess:
    networkAccess: true
  DockerRequirement:
    dockerPull: quay.io/biocontainers/snpeff:5.2--hdfd78af_1
  InitialWorkDirRequirement:
    listing:
      - entryname: staging_folder
        writable: true
        entry: $(null)
      - entryname: build_db.sh
        entry: |-
          #!/bin/bash
          ID=$1 # NCBI identifier
          GENBANK_IN=$2 # Genbank File
          DIR="data/$ID" # SNPeff wants its databases to be in ./data
          GENE_FILE="$DIR/genes.gbk" # SNPeff expects its genbank file to be in this format and location
          
          # Check if either input is provided
          if [ "$ID" = "custom_db" ] && [ -z "$GENBANK_IN" ]; then
            echo "Error: A GenBank file must be provided when using the default database name." >&2
            exit 1
          fi
          # Create database directory
          mkdir -p "$DIR" >/dev/null 2>&1 || true

          if [ -n "$GENBANK_IN" ]; then
            echo "Using provided GenBank file: $GENBANK_IN"
            cp "$GENBANK_IN" "$GENE_FILE"
          else
            echo "Downloading genome $ID from NCBI"
            wget "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nucleotide&id=$ID&rettype=gbwithparts&retmode=text" -O $GENE_FILE
          fi
          # Copy config file from inside the container to the working directory
          cp /usr/local/share/snpeff-5.2-1/snpEff.config ./snpEff_edit.config

          # Add entry to config file
          echo "$ID.genome : $ID" >> snpEff_edit.config

          # Build the SNPeff database
          java -jar /usr/local/share/snpeff-5.2-1/snpEff.jar build -config snpEff_edit.config -genbank -v $ID

hints:
  SoftwareRequirement:
    packages:
      snpeff:
        version: ["5.2.1"]
        specs: ["identifiers.org/RRID:SCR_005191"]
  
baseCommand: [ "bash", "build_db.sh" ]

inputs:
  NCBI_identifier:
    type: string
    label: NCBI genome identifier
    doc: | 
      Required. NCBI Identifier of a genome for SNPeff to extract a GenBank file and build a custom database out of.
      If a GenBank file is provided, this input only serves as the entry made in the config file, and as the folder name of the database.
    inputBinding: 
      position: 1
  genbank_file:
    type: File?
    label: genbank input file
    doc: The GenBank input file to build a custom database out of.
    inputBinding: 
      position: 2
#  extra_options: # could implement this into the bash script as well as third pos arguments - one flag might work much more easily than adding every single database option flag and implement them into the shell script - downside is having to specify the flags yourself in the input
#    type: string?
#    label: extra options
#    doc: Additional command-line options for SNPeff.
#    inputBinding:
#      position: 2

outputs:
  database_dir:
    type: Directory
    label: "SNPeff Database Directory"
    doc: "The directory containing the built SNPeff database. (including genes.gbk, snpEffectPredictor.bin, and ($inputs.genome).bin)"
    outputBinding:
      glob: data
  config_file:
    type: File
    label: SNPeff Config File
    doc: |
      Path to the external SNPeff configuration file. A new entry must be made in this config file in the format of "($inputs.genome).genome:($inputs.genome)".
      An alternative codon table should be added if relevant.
    outputBinding:
      glob: snpEff_edit.config

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
s:dateModified: "2025-03-12"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"