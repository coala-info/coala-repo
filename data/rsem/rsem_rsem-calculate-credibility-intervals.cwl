cwlVersion: v1.2
class: CommandLineTool
baseCommand: [rsem-calculate-credibility-intervals]
label: rsem_rsem-calculate-credibility-intervals
doc: "Calculate credibility intervals of the expression estimates from Gibbs sampler count vectors (normally run by rsem-calculate-expression --calc-ci).\n\nTool homepage: https://deweylab.github.io/RSEM/"
inputs:
  - id: reference_name
    type: string
    doc: The name of the RSEM reference (made by rsem-prepare-reference).
    inputBinding:
      position: 1
  - id: reference_files
    type:
      type: array
      items: File
    doc: Reference files written by rsem-prepare-reference (all files starting with the reference name). They are staged in the working directory so that reference_name resolves.
  - id: temp_dir
    type: Directory
    doc: The sample_name.temp folder kept by rsem-calculate-expression --keep-intermediate-files --calc-ci. It is staged writable under the name given in imd_dir_name.
  - id: imd_dir_name
    type: string
    doc: Name of the staged intermediate folder (for example sample1.temp).
  - id: stat_dir
    type: Directory
    doc: The sample_name.stat folder written by rsem-calculate-expression. It is staged under the name given in stat_dir_name.
  - id: stat_dir_name
    type: string
    doc: Name of the staged stat folder (for example sample1.stat).
  - id: imd_name
    type: string
    doc: Prefix of the intermediate files, e.g. sample1.temp/sample1 (imdName).
    inputBinding:
      position: 2
  - id: stat_name
    type: string
    doc: Prefix of the model files, e.g. sample1.stat/sample1 (statName).
    inputBinding:
      position: 3
  - id: confidence
    type: float
    doc: Credibility level of the intervals, within (0, 1).
    inputBinding:
      position: 4
  - id: n_cv
    type: int
    doc: Number of count vectors (Gibbs samples) to read (nCV).
    inputBinding:
      position: 5
  - id: n_spc
    type: int
    doc: Number of samples per count vector (nSpC).
    inputBinding:
      position: 6
  - id: n_mb
    type: int
    doc: Memory in MB allocated for the calculation (nMB).
    inputBinding:
      position: 7
  - id: num_threads
    type: ['null', int]
    doc: Number of threads to use.
    inputBinding:
      position: 8
      prefix: -p
  - id: seed
    type: ['null', long]
    doc: Seed for the random number generator (32-bit unsigned integer).
    inputBinding:
      position: 9
      prefix: --seed
  - id: pseudo_count
    type: ['null', float]
    doc: Pseudo count for the prior (single-cell prior uses 0.1).
    inputBinding:
      position: 10
      prefix: --pseudo-count
  - id: quiet
    type: ['null', boolean]
    doc: Stop outputting intermediate information.
    inputBinding:
      position: 11
      prefix: -q
outputs:
  - id: gene_res
    type: File
    doc: Gene-level result file with credibility intervals (imd_name.gene_res).
    outputBinding:
      glob: $(inputs.imd_dir_name)/*.gene_res
  - id: iso_res
    type: File
    doc: Isoform-level result file with credibility intervals (imd_name.iso_res).
    outputBinding:
      glob: $(inputs.imd_dir_name)/*.iso_res
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.reference_files)
      - entryname: $(inputs.imd_dir_name)
        entry: $(inputs.temp_dir)
        writable: true
      - entryname: $(inputs.stat_dir_name)
        entry: $(inputs.stat_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
