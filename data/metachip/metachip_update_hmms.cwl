cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - MetaCHIP
  - update_hmms
label: metachip_update_hmms
doc: "Update the hmm profiles (MetaCHIP_phylo.hmm) used for inferring the SCG tree from
  the Pfam and TIGRFAMs databases.\n\nTool homepage: https://github.com/songweizhi/MetaCHIP"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.hmm)
        writable: true
inputs:
  - id: hmm
    type: File
    doc: MetaCHIP_phylo.hmm file
    inputBinding:
      prefix: -hmm
  - id: pfam_db
    type: File
    doc: Pfam db file, e.g. Pfam-A.hmm
    inputBinding:
      prefix: -p_db
  - id: tigrfam_db
    type: Directory
    doc: TIGRFAMs db folder, e.g. TIGRFAMs_14.0_HMM
    inputBinding:
      prefix: -t_db
outputs:
  - id: updated_hmm
    type: File
    doc: updated hmm profile file
    outputBinding:
      glob: "$(inputs.hmm.basename)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metachip:1.10.13--pyh7cba7a3_0
