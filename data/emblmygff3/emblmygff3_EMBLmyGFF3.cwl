cwlVersion: v1.2
class: CommandLineTool
baseCommand: EMBLmyGFF3
label: emblmygff3_EMBLmyGFF3
doc: "Converts GFF3 and FASTA files to EMBL format.\n\nTool homepage: https://github.com/NBISweden/EMBLmyGFF3"
inputs:
  - id: gff_file
    type: File
    doc: Input gff-file.
    inputBinding:
      position: 1
  - id: fasta
    type: File
    doc: Input fasta sequence.
    inputBinding:
      position: 2
  - id: accession
    type:
      - 'null'
      - boolean
    doc: 'Bolean. Accession number(s) for the entry. Default value: XXX. The proper
      value is automatically filled up by ENA during the submission by a unique accession
      number they will assign. The accession number is used to set up the AC line
      and the first token of the ID line as well. Please visit [this page](https://www.ebi.ac.uk/ena/submit/accession-number-formats)
      and [this one](https://www.ebi.ac.uk/ena/submit/sequence-submission) to learn
      more about it. Activating the option will set the Accession number with the
      fasta sequence identifier.'
    inputBinding:
      position: 103
      prefix: --accession
  - id: advanced_help
    type:
      - 'null'
      - string
    doc: Display advanced information of the parameter specified or of all 
      parameters if none specified.
    inputBinding:
      position: 103
      prefix: --ah
  - id: author
    type:
      - 'null'
      - type: array
        items: string
    doc: Author for the reference. No default value.
    inputBinding:
      position: 103
      prefix: --ra
  - id: classification
    type:
      - 'null'
      - string
    doc: Organism classification e.g 'Eukaryota; Opisthokonta; Metazoa'. The 
      default value is the classification found in the NCBI taxonomy DB from the
      species/taxid given as --species parameter. If none is found, 'Life' will 
      be the default value.
    inputBinding:
      position: 103
      prefix: --classification
  - id: created
    type:
      - 'null'
      - string
    doc: Creation time of the original entry. The default value is the date of 
      the day.
    inputBinding:
      position: 103
      prefix: --created
  - id: data_class
    type:
      - 'null'
      - string
    doc: Data class of the sample. Default value 'XXX'. This option is used to 
      set up the 5th token of the ID line.
    inputBinding:
      position: 103
      prefix: --data_class
  - id: de
    type:
      - 'null'
      - string
    doc: Description. Default value 'XXX'.
    inputBinding:
      position: 103
      prefix: --de
  - id: email
    type:
      - 'null'
      - string
    doc: Email used to fetch information from NCBI taxonomy database. Default 
      value 'EMBLmyGFF3@tool.org'.
    inputBinding:
      position: 103
      prefix: --email
  - id: environmental_sample
    type:
      - 'null'
      - boolean
    doc: Bolean. Identifies sequences derived by direct molecular isolation from
      a bulk environmental DNA sample with no reliable identification of the 
      source organism. May be needed when organism belongs to Bacteria.
    inputBinding:
      position: 103
      prefix: --environmental_sample
  - id: expose_translations
    type:
      - 'null'
      - boolean
    doc: Copy feature and attribute mapping files to the working directory. They
      will be used as mapping files instead of the default internal JSON files. 
      You may modify them as it suits you.
    inputBinding:
      position: 103
      prefix: --expose_translations
  - id: force_uncomplete_features
    type:
      - 'null'
      - boolean
    doc: Force to keep features whithout all the mandatory qualifiers. /!\ 
      Option not suitable for submission purpose.
    inputBinding:
      position: 103
      prefix: --force_uncomplete_features
  - id: force_unknown_features
    type:
      - 'null'
      - boolean
    doc: Force to keep feature types not accepted by EMBL. /!\ Option not 
      suitable for submission purpose.
    inputBinding:
      position: 103
      prefix: --force_unknown_features
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: Gzip output file.
    inputBinding:
      position: 103
      prefix: --gzip
  - id: interleave_genes
    type:
      - 'null'
      - boolean
    doc: Print gene features with interleaved mRNA and CDS features.
    inputBinding:
      position: 103
      prefix: --interleave_genes
  - id: isolate
    type:
      - 'null'
      - string
    doc: Individual isolate from which the sequence was obtained. May be needed 
      when organism belongs to Bacteria.
    inputBinding:
      position: 103
      prefix: --isolate
  - id: isolation_source
    type:
      - 'null'
      - string
    doc: Describes the physical, environmental and/or local geographical source 
      of the biological sample from which the sequence was derived. Mandatory 
      when environmental_sample option used.
    inputBinding:
      position: 103
      prefix: --isolation_source
  - id: keep_duplicates
    type:
      - 'null'
      - boolean
    doc: Do not remove duplicate features during the process. /!\ Option not 
      suitable for submission purpose.
    inputBinding:
      position: 103
      prefix: --keep_duplicates
  - id: keep_short_sequences
    type:
      - 'null'
      - boolean
    doc: Do not skip short sequences (<100bp). /!\ Option not suitable for 
      submission purpose.
    inputBinding:
      position: 103
      prefix: --keep_short_sequences
  - id: keywords
    type:
      - 'null'
      - type: array
        items: string
    doc: Keywords for the entry. No default value.
    inputBinding:
      position: 103
      prefix: --keyword
  - id: locus_numbering_start
    type:
      - 'null'
      - int
    doc: Start locus numbering with the provided value.
    inputBinding:
      position: 103
      prefix: --locus_numbering_start
  - id: locus_tag
    type:
      - 'null'
      - string
    doc: Locus tag prefix used to set up the prefix of the locus_tag qualifier. 
      The locus tag has to be registered at ENA prior any submission. More 
      information [here](https://www.ebi.ac.uk/ena/submit/locus-tags).
    inputBinding:
      position: 103
      prefix: --locus_tag
  - id: locus_zero_padding
    type:
      - 'null'
      - boolean
    doc: Pad locus tag number with zero using the total amount of features. i.e 
      0001 instead of 1
    inputBinding:
      position: 103
      prefix: --locus_zero_padding
  - id: molecule_type
    type:
      - 'null'
      - string
    doc: Molecule type of the sample. No default value.
    inputBinding:
      position: 103
      prefix: --molecule_type
  - id: no_progress
    type:
      - 'null'
      - boolean
    doc: Hide conversion progress counter.
    inputBinding:
      position: 103
      prefix: --no_progress
  - id: no_wrap_qualifier
    type:
      - 'null'
      - boolean
    doc: By default there is a line wrapping at 80 characters. The cut is at the
      world level. Activating this option will avoid the line-wrapping for the 
      qualifiers.
    inputBinding:
      position: 103
      prefix: --no_wrap_qualifier
  - id: organelle
    type:
      - 'null'
      - string
    doc: Sample organelle. No default value.
    inputBinding:
      position: 103
      prefix: --organelle
  - id: project_id
    type:
      - 'null'
      - string
    doc: Project ID. Default is 'XXX' (This is used to set up the PR line).
    inputBinding:
      position: 103
      prefix: --project_id
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Decrease verbosity.
    inputBinding:
      position: 103
      prefix: --quiet
  - id: reference_comment
    type:
      - 'null'
      - string
    doc: Reference Comment. No default value.
    inputBinding:
      position: 103
      prefix: --rc
  - id: reference_group
    type:
      - 'null'
      - string
    doc: Reference Group, the working groups/consortia that produced the record.
      Default value 'XXX'.
    inputBinding:
      position: 103
      prefix: --rg
  - id: reference_location
    type:
      - 'null'
      - string
    doc: Reference publishing location. No default value.
    inputBinding:
      position: 103
      prefix: --rl
  - id: reference_title
    type:
      - 'null'
      - string
    doc: Reference Title. No default value.
    inputBinding:
      position: 103
      prefix: --rt
  - id: reference_xref
    type:
      - 'null'
      - string
    doc: Reference cross-reference. No default value
    inputBinding:
      position: 103
      prefix: --rx
  - id: shame
    type:
      - 'null'
      - boolean
    doc: Suppress the shameless plug.
    inputBinding:
      position: 103
      prefix: --shame
  - id: species
    type:
      - 'null'
      - string
    doc: Sample species, formatted as 'Genus species' or taxid. No default. 
      (This is used to set up the OS line.)
    inputBinding:
      position: 103
      prefix: --species
  - id: strain
    type:
      - 'null'
      - string
    doc: Strain from which sequence was obtained. May be needed when organism 
      belongs to Bacteria.
    inputBinding:
      position: 103
      prefix: --strain
  - id: taxonomy
    type:
      - 'null'
      - string
    doc: Source taxonomy. Default value 'XXX'. This option is used to set the 
      taxonomic division within ID line (6th token).
    inputBinding:
      position: 103
      prefix: --taxonomy
  - id: topology
    type:
      - 'null'
      - string
    doc: Sequence topology. No default. (This is used to set up the Topology 
      that is the 3rd token of the ID line.)
    inputBinding:
      position: 103
      prefix: --topology
  - id: transl_table
    type:
      - 'null'
      - int
    doc: Translation table. No default. (This is used to set up the translation 
      table qualifier transl_table of the CDS features.) Please visit [NCBI 
      genetic code](https://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi) 
      for more information.
    inputBinding:
      position: 103
      prefix: --transl_table
  - id: translate
    type:
      - 'null'
      - boolean
    doc: Include translation in CDS features.
    inputBinding:
      position: 103
      prefix: --translate
  - id: uncompressed_log
    type:
      - 'null'
      - boolean
    doc: Some logs can be compressed for better lisibility, they won't.
    inputBinding:
      position: 103
      prefix: --uncompressed_log
  - id: use_attribute_value_as_locus_tag
    type:
      - 'null'
      - string
    doc: Use the value of the defined attribute as locus_tag.
    inputBinding:
      position: 103
      prefix: --use_attribute_value_as_locus_tag
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase verbosity.
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output filename.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emblmygff3:2.4--pyhdfd78af_1
