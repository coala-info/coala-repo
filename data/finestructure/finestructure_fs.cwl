cwlVersion: v1.2
class: CommandLineTool
baseCommand: fs
label: finestructure_fs
doc: "running the whole chromopainter/finestructure inference pipeline in 'automatic'
  mode\n\nTool homepage: https://people.maths.bris.ac.uk/~madjl/finestructure/finestructure.html"
inputs:
  - id: projectname
    type: string
    doc: Project name for the inference pipeline
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: General options for the 'project' tool
    inputBinding:
      position: 2
  - id: actions
    type:
      - 'null'
      - type: array
        items: string
    doc: Actions to perform in the pipeline
    inputBinding:
      position: 3
  - id: create_id
    type:
      - 'null'
      - File
    doc: Create an ID file from a PROVIDED phase file. Individuals are labelled 
      IND1-IND<N>.
    inputBinding:
      position: 104
  - id: go
    type:
      - 'null'
      - boolean
    doc: Do the next things that are necessary to get a complete set of 
      finestructure runs.
    inputBinding:
      position: 104
  - id: idfile
    type: File
    doc: IDfile location, containing the labels of each individual. REQUIRED, no
      default (unless -createids is used).
    inputBinding:
      position: 104
  - id: import
    type:
      - 'null'
      - File
    doc: Import some settings from an external file. If you need to set any 
      non-trivial settings, this is the way to do it. See "fs -hh" for more 
      details.
    inputBinding:
      position: 104
  - id: new_settings
    type:
      - 'null'
      - boolean
    doc: New settings file, overwriting any previous file
    inputBinding:
      position: 104
      prefix: -n
  - id: parameter
    type:
      - 'null'
      - type: array
        items: string
    doc: Sets an internal parameter. The colon is optional, unless <value> 
      starts with a '-' symbol. Escape spaces and don't use quotes; e.g. 
      '-s1args:-in\ -iM'.
    inputBinding:
      position: 104
  - id: phasefiles
    type:
      type: array
      items: File
    doc: Comma or space separated list of all 'phase' files containing the 
      (phased) SNP details for each haplotype. Required. Must be sorted 
      alphanumerically to ensure chromosomes are correctly ordered. So don't use
      *.phase, use file{1..22}.phase. Override this with upper case -PHASEFILES.
    inputBinding:
      position: 104
  - id: recombfiles
    type:
      - 'null'
      - type: array
        items: File
    doc: Comma or space separated list of all recombination map files containing
      the recombination distance between SNPs. If provided, a linked analysis is
      performed. Otherwise an 'unlinked' analysis is performed. Note that 
      linkage is very important for dense markers!
    inputBinding:
      position: 104
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode
    inputBinding:
      position: 104
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/finestructure:4.1.1--pl5321hdfd78af_0
stdout: finestructure_fs.out
