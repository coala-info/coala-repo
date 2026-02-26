cwlVersion: v1.2
class: CommandLineTool
baseCommand: mqc_mQC.pl
label: mqc_mQC.pl
doc: "MappingQC is a tool to easily generate some figures which give a nice overview
  of the quality of the mapping of ribosome profiling data. More specific, it gives
  an overview of the P site offset calculation, the gene distribution and the metagenic
  classification. Furthermore, MappingQC does a thorough analysis of the triplet periodicity
  and the linked triplet phase (typical for ribosome profiling) in the canonical transcript
  of your data. Especially, the link between the phase distribution and the RPF length,
  the relative sequence position and the triplet identity are taken into account.\n\
  \nTool homepage: https://github.com/Biobix/mQC"
inputs:
  - id: cores
    type:
      - 'null'
      - int
    doc: 'the amount of cores to run the script on (integer, default: 5)'
    default: 5
    inputBinding:
      position: 101
      prefix: --cores
  - id: ens_db
    type: File
    doc: path to the Ensembl SQLite database with annotation info. If you want 
      mappingQC to download the right Ensembl database automatically for you, 
      put in 'get' for this parameter (mandatory)
    inputBinding:
      position: 101
      prefix: --ens_db
  - id: ens_v
    type:
      - 'null'
      - string
    doc: the version of the Ensembl database you want to use
    inputBinding:
      position: 101
      prefix: --ens_v
  - id: experiment_name
    type: string
    doc: customly chosen experiment name for the mappingQC run (mandatory)
    inputBinding:
      position: 101
      prefix: --experiment_name
  - id: mapper
    type:
      - 'null'
      - string
    doc: 'the mapper you used to generate the SAM file (STAR, TopHat2, HiSat2) (default:
      STAR)'
    default: STAR
    inputBinding:
      position: 101
      prefix: --mapper
  - id: max_length_gd
    type:
      - 'null'
      - int
    doc: 'maximum RPF length used for gene distributions and metagenic classification
      (default: 34).'
    default: 34
    inputBinding:
      position: 101
      prefix: --max_length_gd
  - id: max_length_plastid
    type:
      - 'null'
      - int
    doc: the maximum RPF length for Plastid offset generation (default 34)
    default: 34
    inputBinding:
      position: 101
      prefix: --max_length_plastid
  - id: maxmultimap
    type:
      - 'null'
      - int
    doc: 'the maximum amount of multimapped positions used for filtering the reads
      (default: 16)'
    default: 16
    inputBinding:
      position: 101
      prefix: --maxmultimap
  - id: min_length_gd
    type:
      - 'null'
      - int
    doc: 'minimum RPF length used for gene distributions and metagenic classification
      (default: 26).'
    default: 26
    inputBinding:
      position: 101
      prefix: --min_length_gd
  - id: min_length_plastid
    type:
      - 'null'
      - int
    doc: the minimum RPF length for Plastid offset generation (default 22)
    default: 22
    inputBinding:
      position: 101
      prefix: --min_length_plastid
  - id: offset
    type:
      - 'null'
      - string
    doc: 'the offset determination method. Possible options: - plastid: calculate
      the offsets with Plastid (Dunn et al. 2016) - standard: use the standard offsets
      from the paper of Ingolia et al. (2012) (default option) - from_file: use offsets
      from an input file'
    default: standard
    inputBinding:
      position: 101
      prefix: --offset
  - id: offset_file
    type:
      - 'null'
      - File
    doc: the offsets input file
    inputBinding:
      position: 101
      prefix: --offset_file
  - id: outfolder
    type:
      - 'null'
      - Directory
    doc: 'the folder to store the output files (default: work_dir/mQC_output)'
    default: work_dir/mQC_output
    inputBinding:
      position: 101
      prefix: --outfolder
  - id: outhtml
    type:
      - 'null'
      - string
    doc: 'custom name for the output HTML file (default: work_dir/mQC_experiment_name.html)'
    default: work_dir/mQC_experiment_name.html
    inputBinding:
      position: 101
      prefix: --outhtml
  - id: outzip
    type:
      - 'null'
      - string
    doc: 'custom name for output ZIP file (default: work_dir/mQC_experiment_name.zip)'
    default: work_dir/mQC_experiment_name.zip
    inputBinding:
      position: 101
      prefix: --outzip
  - id: plastid_bam
    type:
      - 'null'
      - File
    doc: 'the mapping bam file for Plastid offset generation (default: convert)'
    default: convert
    inputBinding:
      position: 101
      prefix: --plastid_bam
  - id: plotrpftool
    type:
      - 'null'
      - string
    doc: 'the module that will be used for plotting the RPF-phase figure Possible
      options: - grouped2D: use Seaborn to plot a grouped 2D bar chart (default) -
      pyplot3D: use mplot3d to plot a 3D bar chart. This tool can suffer sometimes
      from Escher effects, as it tries to plot a 3D plot with the 2D software of pyplot
      and matplotlib. - mayavi: use the mayavi package to plot a 3D bar chart. This
      tool only works on local systems with graphical cards.'
    default: grouped2D
    inputBinding:
      position: 101
      prefix: --plotrpftool
  - id: samfile
    type: File
    doc: path to the SAM/BAM file that comes out of the mapping script of 
      PROTEOFORMER (mandatory)
    inputBinding:
      position: 101
      prefix: --samfile
  - id: species
    type: string
    doc: the studied species (mandatory)
    inputBinding:
      position: 101
      prefix: --species
  - id: tmp
    type:
      - 'null'
      - Directory
    doc: 'temporary folder for storing temporary files of mappingQC (default: work_dir/tmp)'
    default: work_dir/tmp
    inputBinding:
      position: 101
      prefix: --tmp
  - id: tool_dir
    type:
      - 'null'
      - Directory
    doc: 'folder with necessary additional mappingQC tools. More information below
      in the dependencies section. (default: search for the default tool directory
      location in the active conda environment)'
    inputBinding:
      position: 101
      prefix: --tool_dir
  - id: unique
    type:
      - 'null'
      - string
    doc: 'whether to use only the unique alignments. Possible options: Y, N (default
      Y)'
    default: Y
    inputBinding:
      position: 101
      prefix: --unique
  - id: work_dir
    type:
      - 'null'
      - Directory
    doc: 'working directory to run the scripts in (default: current working directory)'
    inputBinding:
      position: 101
      prefix: --work_dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mqc:1.10--py27pl5.22.0r3.4.1_0
stdout: mqc_mQC.pl.out
