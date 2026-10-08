cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - graphtyper
  - vcf_merge
label: graphtyper_vcf_merge
doc: "Merge VCF files.\n\nTool homepage: https://github.com/DecodeGenetics/graphtyper"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.listed_vcfs)
inputs:
  - id: vcfs
    type:
      - 'null'
      - type: array
        items: File
    doc: "VCFs to merge"
    inputBinding:
      position: 1
  - id: log
    type:
      - 'null'
      - string
    doc: "Set path to log file."
    inputBinding:
      position: 10
      prefix: "--log="
      separate: false
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Set to output verbose logging."
    inputBinding:
      position: 10
      prefix: "--verbose"
  - id: vverbose
    type:
      - 'null'
      - boolean
    doc: "Set to output very verbose logging."
    inputBinding:
      position: 10
      prefix: "--vverbose"
  - id: output
    type: string
    default: merged.vcf.gz
    doc: "Output VCF file name (a name ending in .vcf.gz writes a bgzipped file)."
    inputBinding:
      position: 10
      prefix: "--output="
      separate: false
  - id: file_list
    type:
      - 'null'
      - File
    doc: "File containing VCFs to merge; list the files in listed_vcfs as well so that the paths resolve."
    inputBinding:
      position: 10
      prefix: "--file_list="
      separate: false
  - id: listed_vcfs
    type:
      - 'null'
      - type: array
        items: File
    doc: "VCF files named in file_list, staged in the working directory."
  - id: sv
    type:
      - 'null'
      - boolean
    doc: "Set if the input VCFs were generated from genotype_sv."
    inputBinding:
      position: 10
      prefix: "--sv"
  - id: encoding
    type:
      - 'null'
      - string
    doc: "Select output encoding. Available are: vcf, popvcf (default vcf)."
    inputBinding:
      position: 10
      prefix: "--encoding="
      separate: false
outputs:
  - id: merged_vcf
    type: File
    doc: Merged VCF
    secondaryFiles:
      - pattern: .tbi
        required: false
    outputBinding:
      glob: $(inputs.output)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphtyper:2.7.7--h7594796_1
stdout: graphtyper_vcf_merge.out
