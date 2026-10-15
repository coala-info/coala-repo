cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_probe_remove_overlapping_probes_given_config
label: phyluce_phyluce_probe_remove_overlapping_probes_given_config
doc: "Remove probes of the loci named in the [exclude] section of a config file from\
  \ a probe file\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: probes
    type: File
    doc: The input probe file
    inputBinding:
      prefix: --probes
  - id: config
    type: File
    doc: The input conf file of probes names to remove
    inputBinding:
      prefix: --config
  - id: output_path
    type: string
    doc: The output probe file to write
    inputBinding:
      prefix: --output
outputs:
  - id: output
    type: File
    doc: The probe file without the excluded loci.
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
