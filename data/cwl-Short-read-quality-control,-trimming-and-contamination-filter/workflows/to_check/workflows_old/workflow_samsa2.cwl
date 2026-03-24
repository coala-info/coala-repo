#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow
requirements:
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}
  MultipleInputFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}
  ScatterFeatureRequirement: {}

label: SAMSA2 pipeline
doc: |
    SAMSA2 complete workflow for meta-omics read annotation
    Steps:
      - Diamond read blastx
        - Refseq
        - SEED
      - SAMSA2 processing

# cwltool --no-container --cachedir CACHEDIR /unlock/infrastructure/cwl/workflows/workflow_metagenomics_read_annotation.cwl --forward_reads /unlock/projects/P_UNLOCK/I_INVESTIGATION_TEST/S_TEST_STUDY/O_ObservationUnit_TEST/dna/unprocessed/Unlock_DNA-test_1.fq.gz --reverse_reads /unlock/projects/P_UNLOCK/I_INVESTIGATION_TEST/S_TEST_STUDY/O_ObservationUnit_TEST/dna/unprocessed/Unlock_DNA-test_2.fq.gz --identifier BLA --threads 35 --memory 30000

inputs:
  forward_reads:
    type: File
    doc: forward sequence file locally
    label: forward reads
  reverse_reads:
    type: File
    doc: reverse sequence file locally
    label: reverse reads
  identifier:
    type: string
    doc: Identifier for this dataset used in this workflow
    label: identifier used
  threads:
    type: int?
    doc: number of threads to use for computational processes
    label: number of threads
    default: 2

  step:
    type: int?
    label: CWL base step number
    doc: Step number for order of steps
    default: 3

  destination:
    type: string?
    label: Output Destination
    doc: Optional Output destination used for cwl-prov reporting.

outputs:
  samsa2_output:
    label: SAMSA2
    doc: functional and classification output folder by samsa2
    type: Directory
    outputSource: samsa2_files_to_folder/results

steps:
#########################################
#### Workflow for the refseq run
  workflow_diamond_refseq:
    label: Diamond refseq workflow
    doc: Read mapping using the refseq database
    run: ../diamond/diamond.cwl
    in:
      output:
        valueFrom: $(inputs.identifier)_refseq
      identifier: identifier
      threads: threads
      database:
        default: "/unlock/references/databases/ncbi/Refseq_Bacterial/diamond/ncbi-bact-refseq_28-01-2020_proteins.dmnd"
      maxtargetseq:
        default: 1
      forward_reads: forward_reads
      reverse_reads: reverse_reads
    out: [output_diamond]
#########################################
#### Workflow for the SEED run
  workflow_diamond_seed:
    label: Diamond seed workflow
    doc: Read mapping using the seed database
    run: ../diamond/diamond.cwl
    in:
      identifier: identifier
      threads: threads
      output:
        valueFrom: $(inputs.identifier)_seed
      database:
        default: "/unlock/references/databases/SEED/diamond/seed_subsystems_db.dmnd"
      maxtargetseq:
        default: 1
      forward_reads: forward_reads
      reverse_reads: reverse_reads
    out: [output_diamond]
#############################################
#### Transform diamond results into a tabular view
  workflow_diamond_view:
    label: Change view of diamond binary to tabular
    doc: Converts the diamond binary output file into a tabular output file
    run: ../diamond/view.cwl
    scatter: [inputfile]
    scatterMethod: dotproduct
    in:
      inputfile:
        source: [workflow_diamond_refseq/output_diamond, workflow_diamond_seed/output_diamond]
        linkMerge: merge_flattened
        pickValue: all_non_null
    out: [output_diamond_tabular]
#############################################
#### Run SAMSA2 post scripts
  samsa2_postscripts:
    label: Run SAMSA2 post scripts
    doc: Converts the diamond output file to samsa2 tables
    run: ../samsa2/convert.cwl
    scatter: [inputfile]
    scatterMethod: dotproduct
    in:
      identifier: identifier
      inputfile:
        source: [workflow_diamond_view/output_diamond_tabular]
        linkMerge: merge_flattened
        pickValue: all_non_null
    out: [output_refseq_function, output_refseq_organism, output_seed, output_seed_reduced]
#############################################
#### Compress large diamond .daa files
  compress_diamond:
    label: Compress large output files
    doc: Converts the diamond binary output file into a tabular output file
    run: ../bash/pigz.cwl
    scatter: [inputfile]
    scatterMethod: dotproduct
    in:
      threads: threads
      inputfile:
        source: [workflow_diamond_refseq/output_diamond, workflow_diamond_seed/output_diamond]
        linkMerge: merge_flattened
        pickValue: all_non_null
    out: [outfile]

#############################################
#### Move to folder if not part of a workflow
  samsa2_files_to_folder:
    doc: Preparation of samsa2 output files to a specific output folder
    label: SAMSA2 output files
    run: ../expressions/files_to_folder.cwl
    in:
      step: step
      files:
        source: [compress_diamond/outfile, samsa2_postscripts/output_refseq_function, samsa2_postscripts/output_refseq_organism, samsa2_postscripts/output_seed, samsa2_postscripts/output_seed_reduced]
        linkMerge: merge_flattened
        pickValue: all_non_null
      destination: 
        valueFrom: ${inputs.step+"_SAMSA2"}
    out:
      [results]
#############################################

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-8172-8981
    s:email: mailto:jasper.koehorst@wur.nl
    s:name: Jasper Koehorst
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateCreated: "2021-09-00"
s:dateModified: "2022-05-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
