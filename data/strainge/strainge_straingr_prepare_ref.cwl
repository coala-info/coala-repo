cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- straingr
- prepare-ref
label: strainge_straingr_prepare_ref
doc: 'Prepare a concatenated reference for StrainGR variant calling.


  Tool homepage: https://github.com/broadinstitute/strainge'
inputs:
- id: refs
  type:
  - 'null'
  - type: array
    items: string
  doc: 'Force inclusion of given reference genome in the concatenated reference output (pre-clustering). The given name should match a reference genome in the StrainGST database. To be clear: the given argument should *not* be a filename. See --path-template how this command finds the corresponding FASTA files.'
  inputBinding:
    position: 1
    prefix: --refs
- id: straingst_files
  type:
  - 'null'
  - type: array
    items: File
  doc: Read the list of StrainGST result files and collect all reported strains to include in the concatenated output. Use together with --path-template to specify how to determine the correct filename.
  inputBinding:
    position: 1
    prefix: --straingst-files
- id: path_template
  type:
  - 'null'
  - string
  doc: 'Specify how to determine the path to the FASTA file of a reference strain as reported by StrainGST. This command will replace "{ref}" with the strain name. Example: "refs/{ref}.fa". Warning: in many shells { and } are special characters. Make sure to use quotes. Default: {ref}.fa.'
  inputBinding:
    position: 1
    prefix: --path-template
- id: output
  type: string
  doc: Output FASTA filename.
  inputBinding:
    position: 1
    prefix: --output
- id: similarities
  type:
  - 'null'
  - File
  doc: Enable clustering of closely related reference genomes by specifying the path to the k-mer similarity scores as created at the StrainGST database construction step.
  inputBinding:
    position: 1
    prefix: --similarities
- id: threshold
  type:
  - 'null'
  - float
  doc: K-mer clustering threshold, the default (0.7) is a bit more lenient than the clustering step for database construction, because for a concatenated reference you'll want the included references not too closely related, due to increased shared content.
  inputBinding:
    position: 1
    prefix: --threshold
- id: minmatch
  type:
  - 'null'
  - int
  doc: 'Mininum exact match size. Default: 250. For best estimation that resembles StrainGR''s ''lowmq'' field, set this to your library''s average insert size.'
  inputBinding:
    position: 1
    prefix: --minmatch
- id: reference_fastas
  type:
  - 'null'
  - type: array
    items: File
  doc: FASTA files of the reference strains; staged in the working directory so that the --path-template (default {ref}.fa) resolves.
outputs:
- id: output_result
  type: File
  doc: Output FASTA filename.
  outputBinding:
    glob: $(inputs.output)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
requirements:
- class: InitialWorkDirRequirement
  listing:
  - $(inputs.reference_fastas)
