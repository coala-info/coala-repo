#!/usr/bin/env cwltool

cwlVersion: v1.2
class: CommandLineTool

label: "Medaka consensus"
doc: |
    Medaka is a tool to create consensus sequences and variant calls from nanopore sequencing data. 
    This task is performed using neural networks applied a pileup of individual sequencing reads against a draft assembly.
    This commandLineTool runs cmd medaka consensus directly.

hints:
  SoftwareRequirement:
    packages:
      medaka:
        version: ["1.11.3"]
        specs: ["https://anaconda.org/bioconda/medaka"]

  DockerRequirement:
    dockerPull: docker-registry.wur.nl/m-unlock/docker/medaka:1.11.3

baseCommand: ["medaka", "consensus"]

requirements:
  InlineJavascriptRequirement: {}
          
# Are the positions needed?
arguments:
  - valueFrom: "medaka_output" #medaka output directory
    prefix: -o

inputs:
  threads:
    label: Number of CPU threads used by tool.
    type: int?
    inputBinding:
      prefix: -t # number of threads with which to create features (default: 1)
  bam_workers:
    label: number of workers for bam
    type: int
    inputBinding:
      prefix: --bam_workers # number of workers used to prepare data from bam
  reads:
    label: Basecalled ONT nanopore reads in fastq format.
    type: File
    inputBinding:
      prefix: -i # fastq input basecalls
  draft_assembly:
    label: Assembly that medaka will try to polish.
    type: File
    inputBinding:
      prefix: -d # fasta input assembly
  basecall_model:
    label: Basecalling model that was used by guppy.
    doc: |
      Please consult https://github.com/nanoporetech/medaka for detailed information.
      Choice of medaka model depends on how basecalling was performed. Run "medaka tools list\_models".
      {pore}_{device}_{caller variant}_{caller version}
      Available models: r941_trans, r941_flip213, r941_flip235, r941_min_fast, r941_min_high, r941_prom_fast, r941_prom_high
      For basecalling with guppy version >= v3.0.3, select model based on pore name and whether high or fast basecalling was used.
      For flip flop basecalling with v3.03 > guppy version => v2.3.5 select r941_flip235.
      For flip flop basecalling with v2.3.5 > guppy version >= 2.1.3 select r941_flip213.
      For transducer basecaling using Albacore or non-flip-flop guppy basecalling, select r941_trans.

      For test set (https://denbi-nanopore-training-course.readthedocs.io/en/latest/basecalling/basecalling.html?highlight=flowcell),
      use "r941_min_hac_g507" according to the list of available models.
    type: string
    inputBinding:
      prefix: -m # medaka model, (test dataset: r941_min_hac_g507)

outputs:
  medaka_outdir:
    label: directory with polished assembly
    type: Directory
    outputBinding:
      glob: medaka_output
  polished_assembly:
    label: draft assembly polished by medaka.
    type: File
    outputBinding:
      glob: medaka_output/consensus.fasta
  calls_to_draft:
    type: File[]
    outputBinding:
      glob: medaka_output/calls_to_draft.*
  gaps_in_draft_coords:
    type: File
    outputBinding:
      glob: medaka_output/consensus.fasta.gaps_in_draft_coords.bed
  probs:
    type: File
    outputBinding:
      glob: medaka_output/consensus_probs.hdf

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0002-5516-8391
    s:email: mailto:german.royvalgarcia@wur.nl
    s:name: Germán Royval
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-8172-8981
    s:email: mailto:jasper.koehorst@wur.nl
    s:name: Jasper Koehorst
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse
  - class: s:Person
    s:identifier: https://orcid.org/0009-0001-1350-5644
    s:email: mailto:changlin.ke@wur.nl
    s:name: Changlin Ke

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateModified: 2024-10-07
s:dateCreated: "2021-11-29"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
