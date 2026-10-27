cwlVersion: v1.2
class: CommandLineTool
baseCommand: split_agp
label: vgp-processcuration_split_agp
doc: "Correct AGP for sequence lengths, split the agp per haplotype, assign unlocs
  and remove duplicated haplotigs\n\nTool homepage: https://github.com/vgl-hub/vgl-curation"
inputs:
  - id: agp_file
    type: File
    doc: Path to the curated AGP file
    inputBinding:
      position: 101
      prefix: --agp
  - id: fasta_file
    type: File
    doc: Path to the assembly fasta file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: output_dir
    type:
      - 'null'
      - string
    doc: "Path to the output directory (default: current directory). Give it with a trailing slash, for example results/, because the tool appends file names directly."
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir_dir
    type:
      - 'null'
      - Directory
    doc: Path to the output directory
    outputBinding:
      glob: "${ return (inputs.output_dir ? inputs.output_dir : './').replace(/\\/+$/, ''); }"
  - id: corrected_agp
    type: File
    doc: Curated AGP file corrected for sequence lengths.
    outputBinding:
      glob: "${ return (inputs.output_dir ? inputs.output_dir : './').replace(/\\/+$/, '') + '/corrected.agp'; }"
  - id: hap1_agp
    type: File
    doc: AGP file for Haplotype 1.
    outputBinding:
      glob: "${ return (inputs.output_dir ? inputs.output_dir : './').replace(/\\/+$/, '') + '/Hap_1/hap1.agp'; }"
  - id: hap2_agp
    type: File
    doc: AGP file for Haplotype 2.
    outputBinding:
      glob: "${ return (inputs.output_dir ? inputs.output_dir : './').replace(/\\/+$/, '') + '/Hap_2/hap2.agp'; }"
  - id: hap1_unlocs_no_hapdups_agp
    type: File
    doc: AGP file for Haplotype 1 with assigned unlocs and purged of duplicated haplotigs.
    outputBinding:
      glob: "${ return (inputs.output_dir ? inputs.output_dir : './').replace(/\\/+$/, '') + '/Hap_1/hap.unlocs.no_hapdups.agp'; }"
  - id: hap2_unlocs_no_hapdups_agp
    type: File
    doc: AGP file for Haplotype 2 with assigned unlocs and purged of duplicated haplotigs.
    outputBinding:
      glob: "${ return (inputs.output_dir ? inputs.output_dir : './').replace(/\\/+$/, '') + '/Hap_2/hap.unlocs.no_hapdups.agp'; }"
  - id: hap1_haplotigs_agp
    type:
      - 'null'
      - File
    doc: AGP file containing the haplotig duplications removed from Haplotype 1.
    outputBinding:
      glob: "${ return (inputs.output_dir ? inputs.output_dir : './').replace(/\\/+$/, '') + '/Hap_1/haplotigs.agp'; }"
  - id: hap2_haplotigs_agp
    type:
      - 'null'
      - File
    doc: AGP file containing the haplotig duplications removed from Haplotype 2.
    outputBinding:
      glob: "${ return (inputs.output_dir ? inputs.output_dir : './').replace(/\\/+$/, '') + '/Hap_2/haplotigs.agp'; }"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vgp-processcuration:1.1--pyhdfd78af_0
stdout: vgp-processcuration_split_agp.out
