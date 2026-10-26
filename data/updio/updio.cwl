cwlVersion: v1.2
class: CommandLineTool
baseCommand: updio
label: updio
doc: "UPDio is designed to detect uniparental disomy (UPD) events in probands from vcf trio data.\n\nTool homepage: https://github.com/rhpvorderman/UPDio"
inputs:
  - id: multisample_vcf
    type:
      - 'null'
      - File
    doc: a multi-sample vcf file with child, mother, and father genotypes; sample IDs must match the vcf header (use with childID, momID, dadID)
    inputBinding:
      position: 101
      prefix: --multisample_vcf
  - id: child_id
    type:
      - 'null'
      - string
    doc: child sample ID in the multi-sample vcf
    inputBinding:
      position: 101
      prefix: --childID
  - id: mom_id
    type:
      - 'null'
      - string
    doc: mother sample ID in the multi-sample vcf
    inputBinding:
      position: 101
      prefix: --momID
  - id: dad_id
    type:
      - 'null'
      - string
    doc: father sample ID in the multi-sample vcf
    inputBinding:
      position: 101
      prefix: --dadID
  - id: child_vcf
    type:
      - 'null'
      - File
    doc: the child vcf file (or vcf.gz file)
    inputBinding:
      position: 101
      prefix: --child_vcf
  - id: mom_vcf
    type:
      - 'null'
      - File
    doc: the mom vcf file (or vcf.gz file)
    inputBinding:
      position: 101
      prefix: --mom_vcf
  - id: dad_vcf
    type:
      - 'null'
      - File
    doc: the dad vcf file (or vcf.gz file)
    inputBinding:
      position: 101
      prefix: --dad_vcf
  - id: child_cnv_data
    type:
      - 'null'
      - File
    doc: CNV data for the proband; useful to avoid mis-calling CNV events as UPD events
    inputBinding:
      position: 101
      prefix: --child_cnv_data
  - id: output_path
    type:
      - 'null'
      - string
    doc: output directory [output_dir in the working directory]
    inputBinding:
      position: 101
      prefix: --output_path
  - id: include_x
    type:
      - 'null'
      - boolean
    doc: process the X chromosome; only makes sense for female probands
    inputBinding:
      position: 101
      prefix: --include_X
  - id: significance_level
    type:
      - 'null'
      - float
    doc: own significance value, for example 0.0001
    inputBinding:
      position: 101
      prefix: --significance_level
  - id: common_cnv_file
    type:
      - 'null'
      - File
    doc: tab-separated list of cnv (or other) regions to avoid
    inputBinding:
      position: 101
      prefix: --common_cnv_file
  - id: include_mi
    type:
      - 'null'
      - boolean
    doc: search for mendelian inconsistent sites; occasionally useful for finding loss of transmitted allele
    inputBinding:
      position: 101
      prefix: --include_MI
  - id: highqual
    type:
      - 'null'
      - boolean
    doc: use only high quality sites
    inputBinding:
      position: 101
      prefix: --highqual
  - id: no_plot
    type:
      - 'null'
      - boolean
    doc: do not make the plots
    inputBinding:
      position: 101
      prefix: --no_plot
  - id: no_event_list
    type:
      - 'null'
      - boolean
    doc: do not write the event list
    inputBinding:
      position: 101
      prefix: --no_event_list
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir
    type: Directory
    doc: output directory with the log, table, upd call, events list and plots
    outputBinding:
      glob: |
        ${ return inputs.output_path ? inputs.output_path : 'output_dir'; }
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/updio:1.1.0--hdfd78af_0
stdout: updio.out
