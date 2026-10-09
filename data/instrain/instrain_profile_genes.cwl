cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - inStrain
  - profile_genes
label: instrain_profile_genes
doc: "Add gene-level profiling to an existing inStrain profile\n\nTool homepage: https://github.com/MrOlm/inStrain"
inputs:
  - id: IS
    type: Directory
    doc: An inStrain profile object (gene results are written into it)
    inputBinding:
      position: 101
      prefix: --IS
  - id: gene_file
    type:
      - 'null'
      - File
    doc: 'Path to prodigal .fna genes file. If file ends in .gb or .gbk, will treat as a genbank file (EXPERIMENTAL; the name of the gene must be in the gene qualifier)'
    inputBinding:
      position: 101
      prefix: --gene_file
  - id: store_everything
    type:
      - 'null'
      - boolean
    doc: 'Store gene sequences in the IS object (default: False)'
    inputBinding:
      position: 101
      prefix: --store_everything
  - id: processes
    type:
      - 'null'
      - int
    doc: 'Number of processes to use (default: 6)'
    inputBinding:
      position: 101
      prefix: --processes
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'Make extra debugging output (default: False)'
    inputBinding:
      position: 101
      prefix: --debug
outputs:
  - id: profile_dir
    type: Directory
    doc: The inStrain object with the gene profiling results added
    outputBinding:
      glob: $(inputs.IS.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.IS)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/instrain:1.10.0--pyhdfd78af_0
