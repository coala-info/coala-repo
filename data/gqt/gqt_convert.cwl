cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gqt
  - convert
label: gqt_convert
doc: "Convert a VCF/VCF.GZ/BCF file to a GQT genotype index (type bcf) or to a sample
  phenotype database (type ped). The input file must be indexed (for example with
  bcftools index). Output files are written next to the input file unless the output
  names are given.\n\nTool homepage: https://github.com/ryanlayer/gqt"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_file)
        writable: true
      - entry: $(inputs.ped_file)
        writable: true
inputs:
  - id: type
    type: string
    doc: 'Type of conversion: bcf (create a GQT index) or ped (create a sample
      phenotype database)'
    inputBinding:
      position: 1
  - id: input_file
    type: File
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .tbi
        required: false
    doc: Input VCF/VCF.GZ/BCF file
    inputBinding:
      position: 102
      prefix: -i
      valueFrom: $(self.basename)
  - id: ped_file
    type:
      - 'null'
      - File
    doc: PED file name (opt.)
    inputBinding:
      position: 102
      prefix: -p
      valueFrom: $(self.basename)
  - id: ped_sample_name_column
    type:
      - 'null'
      - int
    doc: Sample name column in PED (Default 2)
    inputBinding:
      position: 102
      prefix: -c
  - id: gqt_output_file_path
    type:
      - 'null'
      - string
    doc: GQT output file name (opt.)
    inputBinding:
      position: 104
      prefix: -G
  - id: vid_output_file_path
    type:
      - 'null'
      - string
    doc: VID output file name (opt.)
    inputBinding:
      position: 107
      prefix: -V
  - id: off_output_file_path
    type:
      - 'null'
      - string
    doc: OFF output file name (opt.)
    inputBinding:
      position: 105
      prefix: -O
  - id: bim_output_file_path
    type:
      - 'null'
      - string
    doc: BIM output file name (opt.)
    inputBinding:
      position: 103
      prefix: -B
  - id: ped_db_output_file_path
    type:
      - 'null'
      - string
    doc: PED DB output file name (opt.)
    inputBinding:
      position: 106
      prefix: -D
  - id: num_variants
    type:
      - 'null'
      - int
    doc: Number of variants (opt. with index)
    inputBinding:
      position: 102
      prefix: -r
  - id: num_samples
    type:
      - 'null'
      - int
    doc: Number of samples (opt. with index)
    inputBinding:
      position: 102
      prefix: -f
  - id: tmp_working_directory
    type:
      - 'null'
      - string
    doc: Tmp working directory (./ by default)
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: gqt_output_file
    type:
      - 'null'
      - File
    doc: GQT genotype index (type bcf)
    outputBinding:
      glob: $(inputs.gqt_output_file_path || inputs.input_file.basename + ".gqt")
  - id: vid_output_file
    type:
      - 'null'
      - File
    doc: VID file (type bcf)
    outputBinding:
      glob: $(inputs.vid_output_file_path || inputs.input_file.basename + ".vid")
  - id: off_output_file
    type:
      - 'null'
      - File
    doc: OFF file (type bcf)
    outputBinding:
      glob: $(inputs.off_output_file_path || inputs.input_file.basename + ".off")
  - id: bim_output_file
    type:
      - 'null'
      - File
    doc: BIM file (type bcf)
    outputBinding:
      glob: $(inputs.bim_output_file_path || inputs.input_file.basename + ".bim")
  - id: ped_db_output_file
    type:
      - 'null'
      - File
    doc: PED database (type ped)
    outputBinding:
      glob: '$(inputs.ped_db_output_file_path || (inputs.ped_file ? inputs.ped_file.basename : inputs.input_file.basename) + ".db")'
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gqt:1.1.3--h0263287_3
stdout: gqt_convert.out
