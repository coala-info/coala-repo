#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow
requirements:
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}
  MultipleInputFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}
  ScatterFeatureRequirement: {}

label: Metagenomics workflow
doc: |
    Workflow for Metagenomics from raw reads to annotated bins.
    Steps:
      - workflow_illumina_quality.cwl:
        - FastQC (control)
        - fastp (trimming)
      - Diamond read blastx
        - Refseq
        - SEED
      - SAMSA2 processing
      - HUMAnN read annotation

# cwltool --no-container --cachedir CACHEDIR /unlock/infrastructure/cwl/workflows/workflow_metagenomics_read_annotation.cwl --forward_reads /unlock/projects/P_UNLOCK/I_INVESTIGATION_TEST/S_TEST_STUDY/O_ObservationUnit_TEST/dna/unprocessed/Unlock_DNA-test_1.fq.gz --reverse_reads /unlock/projects/P_UNLOCK/I_INVESTIGATION_TEST/S_TEST_STUDY/O_ObservationUnit_TEST/dna/unprocessed/Unlock_DNA-test_2.fq.gz --identifier BLA --threads 35 --memory 30000

inputs:
  forward_reads:
    type: File[]
    doc: forward sequence file locally
    label: forward reads
  reverse_reads:
    type: File[]
    doc: reverse sequence file locally
    label: reverse reads
  identifier:
    type: string
    doc: Identifier for this dataset used in this workflow
    label: identifier used
  filter_rrna:
    type: boolean
    doc: rRNA read filtering using ...
    label: rRNA filtering
    default: false
  threads:
    type: int?
    doc: number of threads to use for computational processes
    label: number of threads
    default: 2
  memory:
    type: int?
    doc: maximum memory usage in megabytes
    label: memory usage (mb)
    default: 4000
  kraken_database:
    type: string
    doc: database location of kraken2
    label: Kraken2 database

  bbmap_reference:
    type: string?
    doc: bbmap reference fasta file for contamination filtering
    label: contamination reference file
    default: "/unlock/references/databases/bbduk/GCA_000001405.28_GRCh38.p13_genomic.fna.gz"

  run_samsa2:
    type: boolean
    label: Run SAMSA2
    doc: Run SAMSA2 functional read classification
    default: false

  step:
    type: int?
    label: CWL base step number
    doc: Step number for order of steps
    default: 1

  destination:
    type: string?
    label: Output Destination
    doc: Optional Output destination used for cwl-prov reporting.    

outputs:
  filtered_stats:
    label: Filtered statistics
    doc: Statistics on quality and preprocessing of the reads
    type: Directory
    outputSource: workflow_quality/reports_to_folder
  kraken2_output:
    label: Kraken2
    doc: Classification output folder by kraken2
    type: Directory
    outputSource: kraken_files_to_folder/results
  humann_output:
    label: HUMAnN
    doc: HUMAnN output
    type: Directory
    outputSource: humann_files_to_folder/results    
  samsa2_output:
    label: samsa2
    doc: samsa2 output
    type: Directory?
    outputSource: workflow_samsa2/samsa2_output

steps:
#############################################
#### Workflow for quality and filtering using fastqc, fastp and optionally bbduk
  workflow_quality:
    label: Quality and filtering workflow
    doc: Quality assessment of illumina reads with rRNA filtering option
    run: workflow_illumina_quality.cwl
    in:
      filter_rrna: filter_rrna
      forward_reads: forward_reads
      reverse_reads: reverse_reads
      bbmap_reference: bbmap_reference
      memory: memory
      threads: threads
      identifier: identifier
      step: step
    out: [QC_reverse_reads, QC_forward_reads, reports_to_folder]
#############################################
#### Workflow for the kraken run
  workflow_kraken2:
    label: Kraken2 workflow
    doc: Read classification using the kraken2 database
    run: ../kraken2/kraken2.cwl
    in:
      identifier: identifier
      threads: threads
      database: kraken_database
      forward_reads: workflow_quality/QC_forward_reads
      reverse_reads: workflow_quality/QC_reverse_reads
    out: [kraken, report]
#############################################
#### Compress kraken2
  compress_kraken2:
    label: Compress large kraken2 output file
    doc: Converts the diamond binary output file into a tabular output file
    run: ../bash/pigz.cwl
    in:
      threads: threads
      inputfile: workflow_kraken2/kraken
    out: [outfile]

#############################################
#### FASTQ files to single FASTA file
  fastq_to_fasta:
    label: Compress large kraken2 output file
    doc: Converts the diamond binary output file into a tabular output file
    run: ../fastq/fastq_to_fasta.cwl
    in:
      identifier: identifier
      fastq_files: [workflow_quality/QC_forward_reads, workflow_quality/QC_reverse_reads]
    out: [fasta_out]
#############################################
#### humann taxonomic and functional classification
  workflow_humann:
    label: HUMAnN
    doc: Taxonomic and functional classification using HUMAnN
    run: ../humann/humann.cwl
    in:
      identifier: identifier
      threads: threads
      fasta: fastq_to_fasta/fasta_out
    out: [genefamilies_out, pathabundance_out, pathcoverage_out, log_out, stdout_out]
#############################################

#############################################
#### humann taxonomic and functional classification
  workflow_samsa2:
    label: SAMSA2
    doc: functional read classification using SAMSA2
    when: $(inputs.run_samsa2)
    run: workflow_samsa2.cwl
    in:
      run_samsa2: run_samsa2
      identifier: identifier
      threads: threads
      step:
        valueFrom: |
          ${
            var step = inputs.step;
            return step + 1;
          }
      forward_reads: workflow_quality/QC_forward_reads
      reverse_reads: workflow_quality/QC_reverse_reads
    out: [samsa2_output]
#############################################


#############################################
#### Move to folder if not part of a workflow
  kraken_files_to_folder:
    doc: Preparation of kraken output files to a specific output folder
    label: Kraken2 output folder
    run: ../expressions/files_to_folder.cwl
    in:
      step: step
      files:
        source: [compress_kraken2/outfile, workflow_kraken2/report]
        linkMerge: merge_flattened
        pickValue: all_non_null
      destination: 
        valueFrom: |
          ${
            var step = inputs.step;
            step = step + 1;
            return step+"_Kraken2";
          }
    out:
      [results]

#### Move to folder if not part of a workflow
  humann_files_to_folder:
    doc: Preparation of HUMAnN output files to a specific output folder
    label: HUMAnN output folder
    run: ../expressions/files_to_folder.cwl
    in:
      step: step
      files:
        source: [workflow_humann/genefamilies_out, workflow_humann/pathabundance_out, workflow_humann/pathcoverage_out, workflow_humann/log_out, workflow_humann/stdout_out]
        linkMerge: merge_flattened
        pickValue: all_non_null
      destination: 
        valueFrom: |
          ${
            var step = inputs.step;
            step = step + 1;
            return step+"_HUMAnN";
          }
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
s:dateCreated: "2020-00-00"
s:dateModified: "2022-05-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/