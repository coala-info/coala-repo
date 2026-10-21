cwlVersion: v1.2
class: CommandLineTool
baseCommand: [rsem-gen-transcript-plots]
label: rsem_rsem-gen-transcript-plots
doc: "Generate read depth plots (PDF) for a list of transcripts, alleles or genes from RSEM read depth files.\n\nTool homepage: https://deweylab.github.io/RSEM/"
inputs:
  - id: sample_name
    type: string
    doc: The sample name; the tool reads sample_name.transcript.readdepth and sample_name.isoforms.results (or .alleles.results).
    inputBinding:
      position: 1
  - id: sample_files
    type:
      type: array
      items: File
    doc: Files of the sample staged in the working directory - sample_name.transcript.readdepth, sample_name.isoforms.results (or .alleles.results) and, with show_uniq, sample_name.uniq.transcript.readdepth.
  - id: input_list
    type: File
    doc: Text file with one transcript, allele or gene ID per line.
    inputBinding:
      position: 2
  - id: is_allele_specific
    type: int
    doc: 1 if the reference is allele-specific, 0 otherwise.
    inputBinding:
      position: 3
  - id: id_type
    type: int
    doc: Type of the IDs in input_list - 0 allele, 1 isoform, 2 gene.
    inputBinding:
      position: 4
  - id: show_uniq
    type: int
    doc: 1 to also show unique-read coverage (needs sample_name.uniq.transcript.readdepth), 0 otherwise.
    inputBinding:
      position: 5
  - id: output_plot_file
    type: string
    doc: Name of the output PDF plot file.
    inputBinding:
      position: 6
outputs:
  - id: plot
    type: File
    doc: PDF file with the read depth plots.
    outputBinding:
      glob: $(inputs.output_plot_file)
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.sample_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
