cwlVersion: v1.2
class: CommandLineTool
baseCommand: Compiler_Module.py
label: virema_Compiler_Module.py
doc: "Viral Recombination Mapper - Compilation Module\n\nTool homepage: https://sourceforge.net/projects/virema/"
inputs:
  - id: input_data
    type: File
    doc: UnCompiled Results file from ViReMa run
    inputBinding:
      position: 1
  - id: bed_output
    type:
      - 'null'
      - boolean
    doc: Output recombination data into BED files.
    inputBinding:
      position: 102
      prefix: -BED
  - id: compound_handling
    type:
      - 'null'
      - string
    doc: Select this option for compound recombination event mapping (see manual
      for details). Enter number of nucleotides to map (must be less than Seed, 
      and greater than number of nts in MicroInDel). Default is off.
    default: off
    inputBinding:
      position: 102
      prefix: --Compound_Handling
  - id: dedup
    type:
      - 'null'
      - boolean
    doc: Remove potential PCR duplicates. Default is off.
    default: false
    inputBinding:
      position: 102
      prefix: -DeDup
  - id: defuzz
    type:
      - 'null'
      - string
    doc: "Choose how to defuzz data: '5' to report at 5' end of fuzzy region, '3'
      to report at 3' end, or '0' to report in centre of fuzzy region. Default is
      no fuzz handling (similar to choosing Right - see Routh et al)."
    default: no fuzz handling
    inputBinding:
      position: 102
      prefix: --Defuzz
  - id: max_fuzz
    type:
      - 'null'
      - string
    doc: Select maximum allowed length of fuzzy region. Recombination events 
      with longer fuzzy regions will not be reported. Default is Seed Length.
    inputBinding:
      position: 102
      prefix: --MaxFuzz
  - id: micro_indel_length
    type:
      - 'null'
      - int
    doc: Size of MicroInDels - these are common artifacts of cDNA preparation. 
      See Routh et al JMB 2012. Default size is 0)
    default: 0
    inputBinding:
      position: 102
      prefix: --MicroInDel_Length
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Enter a directory name that all compiled output files will be saved in.
    inputBinding:
      position: 102
      prefix: --Output_Dir
  - id: output_tag
    type:
      - 'null'
      - string
    doc: Enter a tag name that will be appended to end of each output file.
    inputBinding:
      position: 102
      prefix: --Output_Tag
  - id: read_names_entry
    type:
      - 'null'
      - boolean
    doc: Append Read Names contributing to each compiled result. Default is off.
    default: false
    inputBinding:
      position: 102
      prefix: -ReadNamesEntry
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virema:0.6--py27_0
stdout: virema_Compiler_Module.py.out
