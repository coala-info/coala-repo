cwlVersion: v1.2
class: CommandLineTool
baseCommand: NOVOPlasty4.3.5.pl
label: novoplasty_NOVOPlasty4.3.5.pl
doc: "NOVOPlasty is a de novo assembler for organelle genomes (mitochondria and chloroplasts).
  It reads a configuration file to perform the assembly.\n\nTool homepage: https://github.com/ndierckx/NOVOPlasty"
inputs:
  - id: config_file
    type: File
    doc: Path to the configuration file containing all assembly parameters.
    inputBinding:
      position: 101
      prefix: -c
  - id: supporting_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named in the configuration file (reads, seed, reference,
      chloroplast sequence), staged in the working directory so that relative
      names in the config resolve.
outputs:
  - id: assemblies
    type: File[]
    doc: Assembled contigs, circularized and uncircularized assemblies and
      logs written to the working directory.
    outputBinding:
      glob:
        - Circularized_assembly_*
        - Uncircularized_assemblies_*
        - Contigs_*
        - Merged_contigs_*
        - log_*.txt
        - contigs_tmp_*.txt
        - Option_*
        - Variants_*
        - Heteroplasmy_*
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.supporting_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/novoplasty:4.3.5--pl5321hdfd78af_0
stdout: novoplasty_NOVOPlasty4.3.5.pl.out
