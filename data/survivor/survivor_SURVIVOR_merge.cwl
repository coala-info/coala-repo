cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - SURVIVOR
  - merge
label: survivor_merge
doc: "Compare or merge VCF files to generate a consensus or multi sample VCF files\n\nTool homepage: https://github.com/fritzsedlazeck/SURVIVOR"
inputs:
  - id: sample_files
    type: File
    doc: "File with VCF names and paths (one VCF per line; the names must resolve in the working directory)."
    inputBinding:
      position: 1
  - id: max_distance
    type: int
    doc: "Max distance between breakpoints (0-1 percent of length, 1- number of bp)."
    inputBinding:
      position: 2
  - id: min_support
    type: int
    doc: "Minimum number of supporting callers."
    inputBinding:
      position: 3
  - id: same_type
    type: int
    doc: "Take the type into account (1==yes, else no)."
    inputBinding:
      position: 4
  - id: same_strand
    type: int
    doc: "Take the strands of SVs into account (1==yes, else no)."
    inputBinding:
      position: 5
  - id: estimate_distance
    type: int
    doc: "Estimate distance based on the size of SV (1==yes, else no)."
    inputBinding:
      position: 6
  - id: min_size
    type: int
    doc: "Minimum size of SVs to be taken into account."
    inputBinding:
      position: 7
  - id: output
    type: string
    doc: "Output VCF filename."
    inputBinding:
      position: 8
  - id: vcf_files
    type:
      type: array
      items: File
    doc: The VCF files named in the sample_files list; they are staged in the working directory so the names resolve.
outputs:
  - id: merged_vcf
    type: File
    doc: "Merged VCF with SUPP and SUPP_VEC tags."
    outputBinding:
      glob: '$(inputs.output)'
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.vcf_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/survivor:1.0.7--h077b44d_7
stdout: survivor_merge.out
