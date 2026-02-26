cwlVersion: v1.2
class: CommandLineTool
baseCommand: gothresher.py
label: gothresher
doc: "Gothresher is a tool for filtering and processing GO annotations.\n\nTool homepage:
  https://github.com/FriedbergLab/GOThresher"
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: The input file path. Please remember the name of the file must start 
      with goa in front of it, with the name of the species following separated 
      by an underscore
    inputBinding:
      position: 1
  - id: aspect
    type:
      - 'null'
      - type: array
        items: string
    doc: Enter P, C or F for Biological Process, Cellular Component or Molecular
      Function respectively
    inputBinding:
      position: 102
      prefix: --aspect
  - id: assigned_by
    type:
      - 'null'
      - type: array
        items: string
    doc: Choose only those annotations which have been annotated by the provided
      list of databases. Cannot be provided if -assgninv is provided
    inputBinding:
      position: 102
      prefix: --assigned_by
  - id: assigned_by_inverse
    type:
      - 'null'
      - type: array
        items: string
    doc: Choose only those annotations which have NOT been annotated by the 
      provided list of databases. Cannot be provided if -assgn is provided
    inputBinding:
      position: 102
      prefix: --assigned_by_inverse
  - id: cutoff_attn
    type:
      - 'null'
      - string
    doc: The threshold level for deciding to eliminate annotations which come 
      from references that annotate more than the given 'threshold' number of 
      ANNOTATIONS
    inputBinding:
      position: 102
      prefix: --cutoff_attn
  - id: cutoff_prot
    type:
      - 'null'
      - string
    doc: The threshold level for deciding to eliminate annotations which come 
      from references that annotate more than the given 'threshold' number of 
      PROTEINS
    inputBinding:
      position: 102
      prefix: --cutoff_prot
  - id: date_after
    type:
      - 'null'
      - string
    doc: The date entered here will be parsed by the parser from dateutil 
      package. For more information on acceptable date formats please visit 
      https://github.com/dateutil/dateutil/. All annotations made after this 
      date will be picked up
    inputBinding:
      position: 102
      prefix: --date_after
  - id: date_before
    type:
      - 'null'
      - string
    doc: The date entered here will be parsed by the parser from dateutil 
      package. For more information on acceptable date formats please visit 
      https://github.com/dateutil/dateutil/. All annotations made prior to this 
      date will be picked up
    inputBinding:
      position: 102
      prefix: --date_before
  - id: evidence
    type:
      - 'null'
      - type: array
        items: string
    doc: Accepts Standard Evidence Codes outlined in 
      http://geneontology.org/page/guide-go-evidence-codes. All 3 letter code 
      for each standard evidence is acceptable. In addition to that EXPEC is 
      accepted which will pull out all annotations which are made 
      experimentally. COMPEC will extract all annotations which have been done 
      computationally. Similarly, AUTHEC and CUREC are also accepted. Cannot be 
      provided if -einv is provided
    inputBinding:
      position: 102
      prefix: --evidence
  - id: evidence_inverse
    type:
      - 'null'
      - type: array
        items: string
    doc: Leaves out the provided Evidence Codes. Cannot be provided if -e is 
      provided
    inputBinding:
      position: 102
      prefix: --evidence_inverse
  - id: info_threshold_phillip_lord
    type:
      - 'null'
      - float
    doc: Provide a threshold value t. All annotations having information content
      below t will be discarded
    inputBinding:
      position: 102
      prefix: --info_threshold_Phillip_Lord
  - id: info_threshold_phillip_lord_percentile
    type:
      - 'null'
      - float
    doc: Provide the percentile p. All annotations having information content 
      below p will be discarded
    inputBinding:
      position: 102
      prefix: --info_threshold_Phillip_Lord_percentile
  - id: info_threshold_wyatt_clark
    type:
      - 'null'
      - float
    doc: Provide a threshold value t. All annotations having information content
      below t will be discarded
    inputBinding:
      position: 102
      prefix: --info_threshold_Wyatt_Clark
  - id: info_threshold_wyatt_clark_percentile
    type:
      - 'null'
      - float
    doc: Provide the percentile p. All annotations having information content 
      below p will be discarded
    inputBinding:
      position: 102
      prefix: --info_threshold_Wyatt_Clark_percentile
  - id: prefix
    type:
      - 'null'
      - string
    doc: Add a prefix to the name of your output files.
    inputBinding:
      position: 102
      prefix: --prefix
  - id: recalculate
    type:
      - 'null'
      - int
    doc: Set this to 1 if you wish to enforce the recalculation of the 
      Information Accretion for every GO term. Calculation of the information 
      accretion is time consuming. Therefore keep it to zero if you are 
      performing rerun on old data. The program will then read the information 
      accretion values from a file which it wrote to in the previous run of the 
      program
    inputBinding:
      position: 102
      prefix: --recalculate
  - id: select_references
    type:
      - 'null'
      - type: array
        items: string
    doc: Provide the paths to files which contain references you wish to select.
      It is possible to include references in case you wish to select 
      annotations made by a few references. This will prompt the program to 
      interpret string which have the keywords 'GO_REF','PMID' and 'Reactome' as
      a GO reference. Strings which do not contain that keyword will be 
      interpreted as a file path which the program will except to contain a list
      of GO references. The program will accept a mixture of GO_REF and file 
      names. It is also possible to choose all references of a particular 
      category and a handful of references from another. For example if you wish
      to choose all PMID references, just put PMID. The program will then select
      all PMID references. Currently the program can accept PMID, GO_REF and 
      Reactome
    inputBinding:
      position: 102
      prefix: --select_references
  - id: select_references_inverse
    type:
      - 'null'
      - type: array
        items: string
    doc: Works like -selref but does not select the references which have been 
      provided as input
    inputBinding:
      position: 102
      prefix: --select_references_inverse
  - id: single_file
    type:
      - 'null'
      - int
    doc: Set to 1 in order to output the results of each individual species in a
      single file.
    inputBinding:
      position: 102
      prefix: --single_file
  - id: verbose
    type:
      - 'null'
      - int
    doc: Set this argument to 1 if you wish to view the outcome of each 
      operation on console
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Writes the final outputs to the directory in this path.
    outputBinding:
      glob: $(inputs.output_dir)
  - id: report
    type:
      - 'null'
      - File
    doc: Provide the path where the report file will be stored. If you are 
      providing a path please make sure your path ends with a '/'. Otherwise the
      program will assume the last string after the final '/' as the name of the
      report file. A single report file will be generated. Information for each 
      species will be put into individual worksheets.
    outputBinding:
      glob: $(inputs.report)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gothresher:1.0.29--pyh7cba7a3_0
