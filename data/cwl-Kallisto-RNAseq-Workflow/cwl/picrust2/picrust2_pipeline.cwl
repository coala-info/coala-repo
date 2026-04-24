#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool
label: PICRUSt2 pipeline

doc: |
  Runs the PICRUSt2 pipeline workflow which is installed according to the following procedure:

  source /root/miniconda/bin/activate && \ 
    cd /unlock/infrastructure/conda/picrust2_v2.4.2 && \ 
    conda env create -f /conda/picrust2_env.yml -p /unlock/infrastructure/conda/picrust2_v2.4.2 && \ 
    conda activate /unlock/infrastructure/conda/picrust2_v2.4.2 && \ 
    pip install --editable . && \ 

  The folder can be obtained from the picrust2 repository.

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - entryname: script.sh
        entry: |-
          #!/bin/bash
          source /root/miniconda/bin/activate
          conda init bash
          conda activate /unlock/infrastructure/conda/picrust2_v2.4.2
          PATH="/unlock/infrastructure/conda/picrust2_v2.4.2/bin/:$PATH"
          export PATH
          picrust2_pipeline.py $@

baseCommand: ["bash", "script.sh"]

inputs:
  fasta:
    type: File
    doc: FASTA of unaligned sequences
    label: Input fasta
    inputBinding:
      prefix: -s
  input_table:
    type: File
    doc: Input table of sequence abundances (BIOM, TSV, or mothur shared file format)
    label: Input table
    inputBinding:
      prefix: -i
  threads:
    type: int?
    doc: number of threads to use for computational processes
    label: number of threads
    inputBinding:
      prefix: -p
  identifier:
    type: string
    doc: Identifier for this dataset used in this workflow
    label: identifier used
  traits:
    type: string?
    doc: "--in_traits IN_TRAITS - Comma-delimited list (with no spaces) of which gene families to predict from this set: COG, EC, KO, PFAM, TIGRFAM. Note that EC numbers will always be predicted unless --no_pathways is set (default: EC,KO)."
    label: "Comma-delimited list of which gene families to predict from"
    inputBinding:
      prefix: "--in_traits"

arguments:
  - prefix: "-o"
    valueFrom: $(inputs.identifier)_PICRUSt2
  - prefix: "--in_traits"
    valueFrom: $(inputs.traits)

stdout: $(inputs.identifier)_picrust2.stdout.log
stderr: $(inputs.identifier)_picrust2.stderr.log

outputs:
  EC_metagenome_out:
    type: Directory
    outputBinding:
      glob: $(inputs.identifier)_PICRUSt2/EC_metagenome_out
  PFAM_metagenome_out:
    type: Directory
    outputBinding:
      glob: $(inputs.identifier)_PICRUSt2/PFAM_metagenome_out
  TIGRFAM_metagenome_out:
    type: Directory
    outputBinding:
      glob: $(inputs.identifier)_PICRUSt2/TIGRFAM_metagenome_out
  COG_metagenome_out:
    type: Directory
    outputBinding:
      glob: $(inputs.identifier)_PICRUSt2/COG_metagenome_out
  KO_metagenome_out:
    type: Directory
    outputBinding:
      glob: $(inputs.identifier)_PICRUSt2/KO_metagenome_out
  intermediate:
    type: Directory
    outputBinding:
      glob: $(inputs.identifier)_PICRUSt2/intermediate
  pathways_out:
    type: Directory
    outputBinding:
      glob: $(inputs.identifier)_PICRUSt2/pathways_out
  EC_predicted.tsv.gz:
    type: File
    outputBinding:
      glob: $(inputs.identifier)_PICRUSt2/EC_predicted.tsv.gz
  PFAM_predicted.tsv.gz:
    type: File
    outputBinding:
      glob: $(inputs.identifier)_PICRUSt2/PFAM_predicted.tsv.gz
  TIGRFAM_predicted.tsv.gz:
    type: File
    outputBinding:
      glob: $(inputs.identifier)_PICRUSt2/TIGRFAM_predicted.tsv.gz
  KO_predicted.tsv.gz:
    type: File
    outputBinding:
      glob: $(inputs.identifier)_PICRUSt2/KO_predicted.tsv.gz
  marker_predicted_and_nsti.tsv.gz:
    type: File
    outputBinding:
      glob: $(inputs.identifier)_PICRUSt2/marker_predicted_and_nsti.tsv.gz
  out.tre:
    type: File
    outputBinding:
      glob: $(inputs.identifier)_PICRUSt2/out.tre
  stdout_out:
    type: File
    outputBinding:
      glob: $(inputs.identifier)_picrust2.stdout.log
  stderr_out:
    type: File
    outputBinding:
      glob: $(inputs.identifier)_picrust2.stderr.log
 
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
s:dateCreated: "2021-00-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/