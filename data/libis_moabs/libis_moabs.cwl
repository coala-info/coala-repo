cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/moabs
label: libis_moabs
doc: "moabs\n\nTool homepage: https://github.com/Dangertrip/LiBis"
inputs:
  - id: configuration_file
    type:
      - 'null'
      - File
    doc: configuration file. Inputs are FASTQ files. They can be defined in the 
      [INPUT] block in the configuration file by --cf.
    inputBinding:
      position: 101
      prefix: --cf
  - id: input_files
    type:
      - 'null'
      - type: array
        items: string
    doc: input files. Inputs are FASTQ files.
    inputBinding:
      position: 101
      prefix: -i
  - id: overwrite_definitions
    type:
      - 'null'
      - type: array
        items: string
    doc: overwrite definitions in configuration file. --def key=value. --def 
      overwrites parameters defined in the configuration file. Multiple-level 
      parameters are connected by '.'. E.g., "--def TASK.Label=wt,ko --def A=a 
      --def B.C=z". However, --def can not overwrite inputs. Inputs are 
      specified only by --cf or -i.
    inputBinding:
      position: 101
      prefix: --def
  - id: verbose_output
    type:
      - 'null'
      - boolean
    doc: verbose output
    default: 0
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libis:0.1.6--py_0
stdout: libis_moabs.out
