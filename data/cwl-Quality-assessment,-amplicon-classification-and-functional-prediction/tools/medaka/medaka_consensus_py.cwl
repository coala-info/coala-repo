#!/usr/bin/env cwltool
cwlVersion: v1.2
class: CommandLineTool

label: "Polishing of assembly created from ONT nanopore long reads"
doc: |
    Uses Medaka to polish an assembly constructed from ONT nanopore reads

hints:
  SoftwareRequirement:
    packages:
      medaka:
        version: ["1.11.3"]
        specs: ["https://anaconda.org/bioconda/medaka"]

  DockerRequirement:
    dockerPull: docker-registry.wur.nl/m-unlock/docker/medaka:1.11.3
  NetworkAccess:
    networkAccess: true

# baseCommand: ["bash", "script.sh"]
baseCommand: [medaka.py]
      
requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - $(inputs.draft_assembly)
  # InitialWorkDirRequirement:
  #   listing:
  #     - entry: "$({class: 'Directory', listing: []})"
  #       entryname: "medaka_output"
  #       writable: true
  #     - entryname: script.sh
  #       entry: |-
  #         #!/bin/bash
  #         source /root/miniconda/bin/activate
  #         conda init bash
  #         conda activate /unlock/infrastructure/conda/medaka/medaka_v1.6.1
  #         python3 /unlock/infrastructure/scripts/medaka/medaka.py $@
          
# Are the positions needed?
# arguments:
#   - valueFrom: "medaka_output" #medaka output directory
#     prefix: -o

inputs:
  threads: #### CHECK
    label: Number of CPU threads used by tool.
    type: int?
    inputBinding:
      prefix: -t # number of threads with which to create features (default: 1)
  reads: #### CHECK
    label: Basecalled ONT nanopore reads in fastq format.
    type: File
    inputBinding:
      prefix: -i # fastq input basecalls
  draft_assembly: #### CHECK
    label: Assembly that medaka will try to polish.
    type: File
    inputBinding:
      prefix: -r # fasta input assembly
  basecall_model: #### CHECK
    label: Basecalling model that was used by guppy.
    doc: |
      Please consult https://github.com/nanoporetech/medaka for detailed information.
      Choice of medaka model depends on how basecalling was performed. Run "medaka tools list\_models".
      {pore}_{device}_{caller variant}_{caller version}
      Available models: {r103_fast_g507, r103_fast_snp_g507, r103_fast_variant_g507, r103_hac_g507, r103_hac_snp_g507, r103_hac_variant_g507, r103_min_high_g345, r103_min_high_g360, r103_prom_high_g360, r103_prom_snp_g3210, r103_prom_variant_g3210,
                        r103_sup_g507, r103_sup_snp_g507, r103_sup_variant_g507, r1041_e82_400bps_fast_g615, r1041_e82_400bps_fast_variant_g615, r1041_e82_400bps_hac_g615, r1041_e82_400bps_hac_variant_g615, r1041_e82_400bps_sup_g615, r1041_e82_400bps_sup_variant_g615,
                        r104_e81_fast_g5015, r104_e81_fast_variant_g5015, r104_e81_hac_g5015, r104_e81_hac_variant_g5015, r104_e81_sup_g5015, r104_e81_sup_g610, r104_e81_sup_variant_g610, r10_min_high_g303, r10_min_high_g340, r941_e81_fast_g514, r941_e81_fast_variant_g514,
                        r941_e81_hac_g514, r941_e81_hac_variant_g514, r941_e81_sup_g514, r941_e81_sup_variant_g514, r941_min_fast_g303, r941_min_fast_g507, r941_min_fast_snp_g507, r941_min_fast_variant_g507, r941_min_hac_g507, r941_min_hac_snp_g507,
                        r941_min_hac_variant_g507, r941_min_high_g303, r941_min_high_g330, r941_min_high_g340_rle, r941_min_high_g344, r941_min_high_g351, r941_min_high_g360, r941_min_sup_g507, r941_min_sup_snp_g507, r941_min_sup_variant_g507, r941_prom_fast_g303,
                        r941_prom_fast_g507, r941_prom_fast_snp_g507, r941_prom_fast_variant_g507, r941_prom_hac_g507, r941_prom_hac_snp_g507, r941_prom_hac_variant_g507, r941_prom_high_g303, r941_prom_high_g330, r941_prom_high_g344, r941_prom_high_g360,
                        r941_prom_high_g4011, r941_prom_snp_g303, r941_prom_snp_g322, r941_prom_snp_g360, r941_prom_sup_g507, r941_prom_sup_snp_g507, r941_prom_sup_variant_g507, r941_prom_variant_g303, r941_prom_variant_g322, r941_prom_variant_g360, r941_sup_plant_g610,
                        r941_sup_plant_variant_g610}
      For basecalling with guppy version >= v3.0.3, select model based on pore name and whether high or fast basecalling was used.
      For flip flop basecalling with v3.03 > guppy version => v2.3.5 select r941_flip235.
      For flip flop basecalling with v2.3.5 > guppy version >= 2.1.3 select r941_flip213.
      For transducer basecaling using Albacore or non-flip-flop guppy basecalling, select r941_trans.

      For test set (https://denbi-nanopore-training-course.readthedocs.io/en/latest/basecalling/basecalling.html?highlight=flowcell),
      use "r941_min_hac_g507" according to the list of available models.
    type: string
    # default: r941_min_hac_g507
    inputBinding:
      prefix: --model # medaka model, (test dataset: r941_min_hac_g507)

outputs:
  # medaka_outdir:
  #   label: directory with polished assembly
  #   type: Directory
  #   outputBinding:
  #     glob: medaka_output
  polished_assembly:
    label: draft assembly polished by medaka.
    type: File
    outputBinding:
      glob: polished_*fasta
  # calls_to_draft:
  #   type: File[]
  #   outputBinding:
  #     glob: medaka_output/calls_to_draft.*
  gaps_in_draft_coords:
    type: File
    outputBinding:
      glob: polished_*bed
  # probs:
  #   type: File
  #   outputBinding:
  #     glob: medaka_output/consensus_probs.hdf

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0009-0001-1350-5644
    s:email: mailto:changlin.ke@wur.nl
    s:name: Changlin Ke
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

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateModified: 2024-10-07
s:dateCreated: "2021-11-29"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
