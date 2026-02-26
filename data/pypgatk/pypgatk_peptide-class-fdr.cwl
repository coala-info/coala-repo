cwlVersion: v1.2
class: CommandLineTool
baseCommand: pypgatk peptide-class-fdr
label: pypgatk_peptide-class-fdr
doc: "The peptide_class_fdr allows to filter the peptide psm files (IdXML files) using
  two different FDR threshold types: - Global FDR - Global FDR + Peptide Class FDR
  The peptide classes can be defined in two ways as simple class: - \"altorf,pseudo,ncRNA,COSMIC,cbiomut,var_mut,var_rs\"\
  \ where each class represent only one kind of peptide source pseudo gene, ncRNA,
  etc. The second for of representing peptide classes is using groups of classes:
  - \"{ non_canonical:[altorf,pseudo,ncRNA];mutations:[COSMIC,cbiomut];variants:[var
  _mut,var_rs]}\" in this case a class is a group of peptide sources for example:
  mutations with two difference sources as COSMIC and cbiomut (CBioportal mutation)
  .\n\nTool homepage: http://github.com/bigbio/py-pgatk"
inputs:
  - id: config_file
    type:
      - 'null'
      - string
    doc: Configuration to perform Peptide Class FDR
    inputBinding:
      position: 101
      prefix: --config_file
  - id: disable_class_fdr
    type:
      - 'null'
      - boolean
    doc: Disable Class-FDR, only compute Global FDR
    inputBinding:
      position: 101
      prefix: --disable-class-fdr
  - id: file_type
    type:
      - 'null'
      - string
    doc: File types supported by the tool (TSV (.tsv), IDXML (.idxml), MZTAB 
      (.mztab))
    inputBinding:
      position: 101
      prefix: --file-type
  - id: input_file
    type:
      - 'null'
      - string
    doc: input file with the peptides and proteins
    inputBinding:
      position: 101
      prefix: --input-file
  - id: min_peptide_length
    type:
      - 'null'
      - string
    doc: minimum peptide length
    inputBinding:
      position: 101
      prefix: --min-peptide-length
  - id: peptide_classes_prefix
    type:
      - 'null'
      - string
    doc: Peptides classes e.g. 
      "altorf,pseudo,ncRNA,COSMIC,cbiomut,var_mut,var_rs"
    inputBinding:
      position: 101
      prefix: --peptide-classes-prefix
  - id: peptide_groups_prefix
    type:
      - 'null'
      - string
    doc: Peptide class groups e.g. 
      "{non_canonical:[altorf,pseudo,ncRNA];mutations:[COSMIC,cbiomut];variants:[var_mut,var_rs]}"
    inputBinding:
      position: 101
      prefix: --peptide-groups-prefix
  - id: psm_pep_class_fdr_cutoff
    type:
      - 'null'
      - string
    doc: PSM class peptide FDR cutoff or threshold
    inputBinding:
      position: 101
      prefix: --psm-pep-class-fdr-cutoff
  - id: psm_pep_fdr_cutoff
    type:
      - 'null'
      - string
    doc: PSM peptide FDR cutoff or threshold
    inputBinding:
      position: 101
      prefix: --psm-pep-fdr-cutoff
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: idxml from openms with filtered peptides and proteins
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgatk:0.0.24--pyhdfd78af_0
