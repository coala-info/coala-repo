cwlVersion: v1.2
class: CommandLineTool
baseCommand: genewalk
label: genewalk
doc: "Run GeneWalk on a list of genes provided in a text file.\n\nTool homepage: https://github.com/churchmanlab/genewalk"
inputs:
  - id: alpha_fdr
    type:
      - 'null'
      - float
    doc: 'The false discovery rate to use when outputting the final statistics table.
      If 1 (default), all similarities are output, otherwise only the ones whose false
      discovery rate are below this parameter are included. For visualization a default
      value of 0.1 for both global and gene-specific plots is used. Lower this value
      to increase the stringency of the regulator gene selection procedure. Default:
      1'
    inputBinding:
      position: 101
      prefix: --alpha_fdr
  - id: base_folder
    type:
      - 'null'
      - Directory
    doc: 'The base folder used to store GeneWalk temporary and result files for a
      given project. Default: /root/genewalk'
    inputBinding:
      position: 101
      prefix: --base_folder
  - id: dim_rep
    type:
      - 'null'
      - int
    doc: 'Dimension of vector representations (embeddings). This value should only
      be increased if genewalk with the default value generates no statistically significant
      results, for instance with very large (>2500) input gene lists. Alternatively,
      it can be decreased in case (nearly) all GO annotations are significant, for
      instance with very short gene lists. Default: 8'
    inputBinding:
      position: 101
      prefix: --dim_rep
  - id: genes
    type: File
    doc: Path to a text file with a list of genes of interest, for 
      exampledifferentially expressed genes. The type of gene identifiers used 
      in the text file are provided in the id_type argument.
    inputBinding:
      position: 101
      prefix: --genes
  - id: id_type
    type: string
    doc: 'The type of gene IDs provided in the text file in the genes argument. Possible
      values are: hgnc_symbol, hgnc_id, ensembl_id, mgi_id,rgd_id, entrez_human, entrez_mouse,
      and custom. If custom, a network_source of sif_annot or sif_full must be used.'
    inputBinding:
      position: 101
      prefix: --id_type
  - id: network_file
    type:
      - 'null'
      - File
    doc: If network_source is indra, this argument points to a Python pickle 
      file in which a list of INDRA Statements constituting the network is 
      contained. In case network_source is edge_list, sif, sif_annot or 
      sif_full, the network_file argument points to a text file representing the
      network. See README section Custom input networks for full description of 
      file format requirements.
    inputBinding:
      position: 101
      prefix: --network_file
  - id: network_source
    type:
      - 'null'
      - string
    doc: 'The source of the network to be used. Possible values are: pc, indra, edge_list,
      sif, sif_annot, and sif_full. In case of indra, edge_list, sif, sif_annot, and
      sif_full, the network_file argument must be specified. Default: pc'
    inputBinding:
      position: 101
      prefix: --network_source
  - id: nproc
    type:
      - 'null'
      - int
    doc: 'The number of processors to use in a multiprocessing environment. Default:
      1'
    inputBinding:
      position: 101
      prefix: --nproc
  - id: nreps_graph
    type:
      - 'null'
      - int
    doc: 'The number of repeats to run when calculating node vectors on the GeneWalk
      graph. Default: 3'
    inputBinding:
      position: 101
      prefix: --nreps_graph
  - id: nreps_null
    type:
      - 'null'
      - int
    doc: 'The number of repeats to run when calculating node vectors on the random
      network graphs for constructing the null distribution. Default: 3'
    inputBinding:
      position: 101
      prefix: --nreps_null
  - id: project
    type: string
    doc: A name for the project which determines the folder within the base 
      folder in which the intermediate and final results are written. Must 
      contain only characters that are valid in folder names.
    inputBinding:
      position: 101
      prefix: --project
  - id: random_seed
    type:
      - 'null'
      - int
    doc: If provided, the random number generator is seeded with the given 
      value. This should only be used if the goal is to deterministically 
      reproduce a prior result obtained with the same random seed.
    inputBinding:
      position: 101
      prefix: --random_seed
  - id: save_dw
    type:
      - 'null'
      - boolean
    doc: 'If True, the full DeepWalk object for each repeat is saved in the project
      folder. This can be useful for debugging but the files are typically very large.
      Default: False'
    inputBinding:
      position: 101
      prefix: --save_dw
  - id: stage
    type:
      - 'null'
      - string
    doc: 'The stage of processing to run. Default: all'
    inputBinding:
      position: 101
      prefix: --stage
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genewalk:1.6.3--pyh7e72e81_0
stdout: genewalk.out
