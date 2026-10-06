# biobb_gromacs CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| biobb_gromacs_append_ligand | PASS |  |
| biobb_gromacs_editconf | PASS |  |
| biobb_gromacs_genion | PASS |  |
| biobb_gromacs_genrestr | PASS |  |
| biobb_gromacs_gmxselect | PASS |  |
| biobb_gromacs_grompp | PASS |  |
| biobb_gromacs_grompp_mdrun | PASS |  |
| biobb_gromacs_make_ndx | PASS |  |
| biobb_gromacs_mdrun | PASS |  |
| biobb_gromacs_ndx2resttop | PASS |  |
| biobb_gromacs_pdb2gmx | PASS |  |
| biobb_gromacs_solvate | PASS |  |
| biobb_gromacs_trjcat | PASS |  |

## biobb_gromacs_append_ligand

### Tool Description
This command takes a ligand ITP file and inserts it in a topology

### Metadata
- **Docker Image**: quay.io/biocontainers/biobb_gromacs:5.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/bioexcel/biobb_gromacs
- **Package**: https://anaconda.org/channels/bioconda/packages/biobb_gromacs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biobb_gromacs/overview
- **Total Downloads**: 14.5K
- **Last updated**: 2025-12-22
- **GitHub**: https://github.com/bioexcel/biobb_gromacs
- **Stars**: N/A
### Original Help Text
```text
usage: append_ligand [-h] [-c CONFIG] --input_top_zip_path INPUT_TOP_ZIP_PATH --input_itp_path INPUT_ITP_PATH -o OUTPUT_TOP_ZIP_PATH [--input_posres_itp_path INPUT_POSRES_ITP_PATH]

This command takes a ligand ITP file and inserts it in a topology

options:
  -h, --help            show this help message and exit
  -c, --config CONFIG   This file can be a YAML file, JSON file or JSON string

required arguments:
  --input_top_zip_path INPUT_TOP_ZIP_PATH
                        Path the input topology TOP and ITP files zipball. Accepted formats: zip.
  --input_itp_path INPUT_ITP_PATH
                        Path to the ligand ITP file to be inserted in the topology. Accepted formats: itp.
  -o, --output_top_zip_path OUTPUT_TOP_ZIP_PATH
                        Path/Name the output topology TOP and ITP files zipball. Accepted formats: zip.

optional arguments:
  --input_posres_itp_path INPUT_POSRES_ITP_PATH
                        Path to the position restriction ITP file. Accepted formats: itp.
```

## biobb_gromacs_editconf

### Tool Description
Wrapper of the GROMACS gmx editconf module.

### Metadata
- **Docker Image**: quay.io/biocontainers/biobb_gromacs:5.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/bioexcel/biobb_gromacs
- **Package**: https://anaconda.org/channels/bioconda/packages/biobb_gromacs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biobb_gromacs/overview
- **Total Downloads**: 14.5K
- **Last updated**: 2025-12-22
- **GitHub**: https://github.com/bioexcel/biobb_gromacs
- **Stars**: N/A
### Original Help Text
```text
usage: editconf [-h] [-c CONFIG] -i INPUT_GRO_PATH -o OUTPUT_GRO_PATH

Wrapper of the GROMACS gmx editconf module.

options:
  -h, --help            show this help message and exit
  -c, --config CONFIG   This file can be a YAML file, JSON file or JSON string

required arguments:
  -i, --input_gro_path INPUT_GRO_PATH
                        Path to the input GRO file. Accepted formats: gro, pdb.
  -o, --output_gro_path OUTPUT_GRO_PATH
                        Path to the output GRO file. Accepted formats: pdb, gro.
```

## biobb_gromacs_genion

### Tool Description
Wrapper for the GROMACS genion module.

### Metadata
- **Docker Image**: quay.io/biocontainers/biobb_gromacs:5.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/bioexcel/biobb_gromacs
- **Package**: https://anaconda.org/channels/bioconda/packages/biobb_gromacs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biobb_gromacs/overview
- **Total Downloads**: 14.5K
- **Last updated**: 2025-12-22
- **GitHub**: https://github.com/bioexcel/biobb_gromacs
- **Stars**: N/A
### Original Help Text
```text
usage: genion [-h] [-c CONFIG] --input_tpr_path INPUT_TPR_PATH --output_gro_path OUTPUT_GRO_PATH --input_top_zip_path INPUT_TOP_ZIP_PATH --output_top_zip_path OUTPUT_TOP_ZIP_PATH [--input_ndx_path INPUT_NDX_PATH]

Wrapper for the GROMACS genion module.

options:
  -h, --help            show this help message and exit
  -c, --config CONFIG   This file can be a YAML file, JSON file or JSON string

required arguments:
  --input_tpr_path INPUT_TPR_PATH
                        Path to the input portable run input TPR file. Accepted formats: tpr.
  --output_gro_path OUTPUT_GRO_PATH
                        Path to the input structure GRO file. Accepted formats: gro.
  --input_top_zip_path INPUT_TOP_ZIP_PATH
                        Path the input TOP topology in zip format. Accepted formats: zip.
  --output_top_zip_path OUTPUT_TOP_ZIP_PATH
                        Path the output topology TOP and ITP files zipball. Accepted formats: zip.

optional arguments:
  --input_ndx_path INPUT_NDX_PATH
                        Path to the input index NDX file. Accepted formats: ndx.
```

## biobb_gromacs_genrestr

### Tool Description
Wrapper for the GROMACS genrestr module.

### Metadata
- **Docker Image**: quay.io/biocontainers/biobb_gromacs:5.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/bioexcel/biobb_gromacs
- **Package**: https://anaconda.org/channels/bioconda/packages/biobb_gromacs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biobb_gromacs/overview
- **Total Downloads**: 14.5K
- **Last updated**: 2025-12-22
- **GitHub**: https://github.com/bioexcel/biobb_gromacs
- **Stars**: N/A
### Original Help Text
```text
usage: genrestr [-h] [-c CONFIG] --input_structure_path INPUT_STRUCTURE_PATH -o OUTPUT_ITP_PATH [--input_ndx_path INPUT_NDX_PATH]

Wrapper for the GROMACS genrestr module.

options:
  -h, --help            show this help message and exit
  -c, --config CONFIG   This file can be a YAML file, JSON file or JSON string

required arguments:
  --input_structure_path INPUT_STRUCTURE_PATH
                        Path to the input structure PDB, GRO or TPR format. Accepted formats: pdb, gro, tpr.
  -o, --output_itp_path OUTPUT_ITP_PATH
                        Path the output ITP topology file with restrains. Accepted formats: itp.

optional arguments:
  --input_ndx_path INPUT_NDX_PATH
                        Path to the input GROMACS index file, NDX format. Accepted formats: ndx.
```

## biobb_gromacs_gmxselect

### Tool Description
Wrapper for the GROMACS select module.

### Metadata
- **Docker Image**: quay.io/biocontainers/biobb_gromacs:5.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/bioexcel/biobb_gromacs
- **Package**: https://anaconda.org/channels/bioconda/packages/biobb_gromacs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biobb_gromacs/overview
- **Total Downloads**: 14.5K
- **Last updated**: 2025-12-22
- **GitHub**: https://github.com/bioexcel/biobb_gromacs
- **Stars**: N/A
### Original Help Text
```text
usage: gmxselect [-h] [-c CONFIG] --input_structure_path INPUT_STRUCTURE_PATH -o OUTPUT_NDX_PATH [--input_ndx_path INPUT_NDX_PATH]

Wrapper for the GROMACS select module.

options:
  -h, --help            show this help message and exit
  -c, --config CONFIG   This file can be a YAML file, JSON file or JSON string

required arguments:
  --input_structure_path INPUT_STRUCTURE_PATH
                        Path to the input GRO/PDB/TPR file. Accepted formats: pdb, gro, tpr.
  -o, --output_ndx_path OUTPUT_NDX_PATH
                        Path to the output index NDX file. Accepted formats: ndx.

optional arguments:
  --input_ndx_path INPUT_NDX_PATH
                        Path to the input index NDX file. Accepted formats: ndx.
```

## biobb_gromacs_grompp

### Tool Description
Wrapper for the GROMACS grompp module.

### Metadata
- **Docker Image**: quay.io/biocontainers/biobb_gromacs:5.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/bioexcel/biobb_gromacs
- **Package**: https://anaconda.org/channels/bioconda/packages/biobb_gromacs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biobb_gromacs/overview
- **Total Downloads**: 14.5K
- **Last updated**: 2025-12-22
- **GitHub**: https://github.com/bioexcel/biobb_gromacs
- **Stars**: N/A
### Original Help Text
```text
usage: grompp [-h] [-c CONFIG] --input_gro_path INPUT_GRO_PATH --input_top_zip_path INPUT_TOP_ZIP_PATH -o OUTPUT_TPR_PATH [--input_cpt_path INPUT_CPT_PATH] [--input_ndx_path INPUT_NDX_PATH] [--input_mdp_path INPUT_MDP_PATH]

Wrapper for the GROMACS grompp module.

options:
  -h, --help            show this help message and exit
  -c, --config CONFIG   This file can be a YAML file, JSON file or JSON string

required arguments:
  --input_gro_path INPUT_GRO_PATH
                        Path to the input GROMACS structure GRO file. Accepted formats: gro.
  --input_top_zip_path INPUT_TOP_ZIP_PATH
                        Path to the input GROMACS topology TOP and ITP files in zip format. Accepted formats: zip.
  -o, --output_tpr_path OUTPUT_TPR_PATH
                        Path to the output portable binary run file TPR. Accepted formats: tpr.

optional arguments:
  --input_cpt_path INPUT_CPT_PATH
                        Path to the input GROMACS checkpoint file CPT. Accepted formats: cpt.
  --input_ndx_path INPUT_NDX_PATH
                        Path to the input GROMACS index files NDX. Accepted formats: ndx.
  --input_mdp_path INPUT_MDP_PATH
                        Path to the input GROMACS `MDP file <http://manual.gromacs.org/current/user-guide/mdp-options.html>`_. Accepted formats: mdp.
```

## biobb_gromacs_grompp_mdrun

### Tool Description
Wrapper for the GROMACS grompp_mdrun module.

### Metadata
- **Docker Image**: quay.io/biocontainers/biobb_gromacs:5.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/bioexcel/biobb_gromacs
- **Package**: https://anaconda.org/channels/bioconda/packages/biobb_gromacs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biobb_gromacs/overview
- **Total Downloads**: 14.5K
- **Last updated**: 2025-12-22
- **GitHub**: https://github.com/bioexcel/biobb_gromacs
- **Stars**: N/A
### Original Help Text
```text
usage: grompp_mdrun [-h] [-c CONFIG] --input_gro_path INPUT_GRO_PATH --input_top_zip_path INPUT_TOP_ZIP_PATH --output_trr_path OUTPUT_TRR_PATH --output_gro_path OUTPUT_GRO_PATH --output_edr_path OUTPUT_EDR_PATH --output_log_path OUTPUT_LOG_PATH [--input_cpt_path INPUT_CPT_PATH] [--input_ndx_path INPUT_NDX_PATH] [--input_mdp_path INPUT_MDP_PATH] [--output_xtc_path OUTPUT_XTC_PATH] [--output_cpt_path OUTPUT_CPT_PATH] [--output_dhdl_path OUTPUT_DHDL_PATH]

Wrapper for the GROMACS grompp_mdrun module.

options:
  -h, --help            show this help message and exit
  -c, --config CONFIG   This file can be a YAML file, JSON file or JSON string

required arguments:
  --input_gro_path INPUT_GRO_PATH
                        Path to the input GROMACS structure GRO file. Accepted formats: gro.
  --input_top_zip_path INPUT_TOP_ZIP_PATH
                        Path to the input GROMACS topology TOP and ITP files in zip format. Accepted formats: zip.
  --output_trr_path OUTPUT_TRR_PATH
                        Path to the GROMACS uncompressed raw trajectory file TRR. Accepted formats: trr.
  --output_gro_path OUTPUT_GRO_PATH
                        Path to the output GROMACS structure GRO file. Accepted formats: gro.
  --output_edr_path OUTPUT_EDR_PATH
                        Path to the output GROMACS portable energy file EDR. Accepted formats: edr.
  --output_log_path OUTPUT_LOG_PATH
                        Path to the output GROMACS trajectory log file LOG. Accepted formats: log.

optional arguments:
  --input_cpt_path INPUT_CPT_PATH
                        Path to the input GROMACS checkpoint file CPT. Accepted formats: cpt.
  --input_ndx_path INPUT_NDX_PATH
                        Path to the input GROMACS index files NDX. Accepted formats: ndx.
  --input_mdp_path INPUT_MDP_PATH
                        Path to the input GROMACS `MDP file <http://manual.gromacs.org/current/user-guide/mdp-options.html>`_. Accepted formats: mdp.
  --output_xtc_path OUTPUT_XTC_PATH
                        Path to the GROMACS compressed trajectory file XTC. Accepted formats: xtc.
  --output_cpt_path OUTPUT_CPT_PATH
                        Path to the output GROMACS checkpoint file CPT. Accepted formats: cpt.
  --output_dhdl_path OUTPUT_DHDL_PATH
                        Path to the output dhdl.xvg file only used when free energy calculation is turned on. Accepted formats: xvg.
```

## biobb_gromacs_make_ndx

### Tool Description
Wrapper for the GROMACS make_ndx module.

### Metadata
- **Docker Image**: quay.io/biocontainers/biobb_gromacs:5.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/bioexcel/biobb_gromacs
- **Package**: https://anaconda.org/channels/bioconda/packages/biobb_gromacs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biobb_gromacs/overview
- **Total Downloads**: 14.5K
- **Last updated**: 2025-12-22
- **GitHub**: https://github.com/bioexcel/biobb_gromacs
- **Stars**: N/A
### Original Help Text
```text
usage: make_ndx [-h] [-c CONFIG] --input_structure_path INPUT_STRUCTURE_PATH -o OUTPUT_NDX_PATH [--input_ndx_path INPUT_NDX_PATH]

Wrapper for the GROMACS make_ndx module.

options:
  -h, --help            show this help message and exit
  -c, --config CONFIG   This file can be a YAML file, JSON file or JSON string

required arguments:
  --input_structure_path INPUT_STRUCTURE_PATH
                        Path to the input GRO/PDB/TPR file. Accepted formats: gro, pdb, tpr.
  -o, --output_ndx_path OUTPUT_NDX_PATH
                        Path to the output index NDX file. Accepted formats: ndx.

optional arguments:
  --input_ndx_path INPUT_NDX_PATH
                        Path to the input index NDX file. Accepted formats: ndx.
```

## biobb_gromacs_mdrun

### Tool Description
Wrapper for the GROMACS mdrun module.

### Metadata
- **Docker Image**: quay.io/biocontainers/biobb_gromacs:5.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/bioexcel/biobb_gromacs
- **Package**: https://anaconda.org/channels/bioconda/packages/biobb_gromacs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biobb_gromacs/overview
- **Total Downloads**: 14.5K
- **Last updated**: 2025-12-22
- **GitHub**: https://github.com/bioexcel/biobb_gromacs
- **Stars**: N/A
### Original Help Text
```text
usage: mdrun [-h] [-c CONFIG] --input_tpr_path INPUT_TPR_PATH --output_gro_path OUTPUT_GRO_PATH --output_edr_path OUTPUT_EDR_PATH --output_log_path OUTPUT_LOG_PATH [--output_trr_path OUTPUT_TRR_PATH] [--input_cpt_path INPUT_CPT_PATH] [--output_xtc_path OUTPUT_XTC_PATH] [--output_cpt_path OUTPUT_CPT_PATH] [--output_dhdl_path OUTPUT_DHDL_PATH]

Wrapper for the GROMACS mdrun module.

options:
  -h, --help            show this help message and exit
  -c, --config CONFIG   This file can be a YAML file, JSON file or JSON string

required arguments:
  --input_tpr_path INPUT_TPR_PATH
                        Path to the portable binary run input file TPR. Accepted formats: tpr.
  --output_gro_path OUTPUT_GRO_PATH
                        Path to the output GROMACS structure GRO file. Accepted formats: gro.
  --output_edr_path OUTPUT_EDR_PATH
                        Path to the output GROMACS portable energy file EDR. Accepted formats: edr.
  --output_log_path OUTPUT_LOG_PATH
                        Path to the output GROMACS trajectory log file LOG. Accepted formats: log.

optional arguments:
  --output_trr_path OUTPUT_TRR_PATH
                        Path to the GROMACS uncompressed raw trajectory file TRR. Accepted formats: trr.
  --input_cpt_path INPUT_CPT_PATH
                        Path to the input GROMACS checkpoint file CPT. Accepted formats: cpt.
  --output_xtc_path OUTPUT_XTC_PATH
                        Path to the GROMACS compressed trajectory file XTC. Accepted formats: xtc.
  --output_cpt_path OUTPUT_CPT_PATH
                        Path to the output GROMACS checkpoint file CPT. Accepted formats: cpt.
  --output_dhdl_path OUTPUT_DHDL_PATH
                        Path to the output dhdl.xvg file only used when free energy calculation is turned on. Accepted formats: xvg.
```

## biobb_gromacs_ndx2resttop

### Tool Description
Generate a restrained topology from an index NDX file.

### Metadata
- **Docker Image**: quay.io/biocontainers/biobb_gromacs:5.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/bioexcel/biobb_gromacs
- **Package**: https://anaconda.org/channels/bioconda/packages/biobb_gromacs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biobb_gromacs/overview
- **Total Downloads**: 14.5K
- **Last updated**: 2025-12-22
- **GitHub**: https://github.com/bioexcel/biobb_gromacs
- **Stars**: N/A
### Original Help Text
```text
usage: ndx2resttop [-h] [-c CONFIG] --input_ndx_path INPUT_NDX_PATH --input_top_zip_path INPUT_TOP_ZIP_PATH -o OUTPUT_TOP_ZIP_PATH

Generate a restrained topology from an index NDX file.

options:
  -h, --help            show this help message and exit
  -c, --config CONFIG   This file can be a YAML file, JSON file or JSON string

required arguments:
  --input_ndx_path INPUT_NDX_PATH
                        Path to the input NDX index file. Accepted formats: ndx.
  --input_top_zip_path INPUT_TOP_ZIP_PATH
                        Path the input TOP topology in zip format. Accepted formats: zip.
  -o, --output_top_zip_path OUTPUT_TOP_ZIP_PATH
                        Path the output TOP topology in zip format. Accepted formats: zip.
```

## biobb_gromacs_pdb2gmx

### Tool Description
Wrapper for the GROMACS pdb2gmx module.

### Metadata
- **Docker Image**: quay.io/biocontainers/biobb_gromacs:5.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/bioexcel/biobb_gromacs
- **Package**: https://anaconda.org/channels/bioconda/packages/biobb_gromacs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biobb_gromacs/overview
- **Total Downloads**: 14.5K
- **Last updated**: 2025-12-22
- **GitHub**: https://github.com/bioexcel/biobb_gromacs
- **Stars**: N/A
### Original Help Text
```text
usage: pdb2gmx [-h] [-c CONFIG] -i INPUT_PDB_PATH --output_gro_path OUTPUT_GRO_PATH --output_top_zip_path OUTPUT_TOP_ZIP_PATH

Wrapper for the GROMACS pdb2gmx module.

options:
  -h, --help            show this help message and exit
  -c, --config CONFIG   This file can be a YAML file, JSON file or JSON string

required arguments:
  -i, --input_pdb_path INPUT_PDB_PATH
                        Path to the input PDB file. Accepted formats: pdb.
  --output_gro_path OUTPUT_GRO_PATH
                        Path to the output GRO file. Accepted formats: gro.
  --output_top_zip_path OUTPUT_TOP_ZIP_PATH
                        Path the output TOP topology in zip format. Accepted formats: zip.
```

## biobb_gromacs_solvate

### Tool Description
Wrapper for the GROMACS solvate module.

### Metadata
- **Docker Image**: quay.io/biocontainers/biobb_gromacs:5.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/bioexcel/biobb_gromacs
- **Package**: https://anaconda.org/channels/bioconda/packages/biobb_gromacs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biobb_gromacs/overview
- **Total Downloads**: 14.5K
- **Last updated**: 2025-12-22
- **GitHub**: https://github.com/bioexcel/biobb_gromacs
- **Stars**: N/A
### Original Help Text
```text
usage: solvate [-h] [-c CONFIG] --input_solute_gro_path INPUT_SOLUTE_GRO_PATH --output_gro_path OUTPUT_GRO_PATH --input_top_zip_path INPUT_TOP_ZIP_PATH --output_top_zip_path OUTPUT_TOP_ZIP_PATH [--input_solvent_gro_path INPUT_SOLVENT_GRO_PATH]

Wrapper for the GROMACS solvate module.

options:
  -h, --help            show this help message and exit
  -c, --config CONFIG   This file can be a YAML file, JSON file or JSON string

required arguments:
  --input_solute_gro_path INPUT_SOLUTE_GRO_PATH
                        Path to the input GRO file. Accepted formats: gro, pdb.
  --output_gro_path OUTPUT_GRO_PATH
                        Path to the output GRO file. Accepted formats: gro, pdb.
  --input_top_zip_path INPUT_TOP_ZIP_PATH
                        Path the input TOP topology in zip format. Accepted formats: zip.
  --output_top_zip_path OUTPUT_TOP_ZIP_PATH
                        Path the output topology in zip format. Accepted formats: zip.

optional arguments:
  --input_solvent_gro_path INPUT_SOLVENT_GRO_PATH
                        (spc216.gro) Path to the GRO file containing the structure of the solvent. Accepted formats: gro.
```

## biobb_gromacs_trjcat

### Tool Description
Wrapper for the GROMACS trjcat module.

### Metadata
- **Docker Image**: quay.io/biocontainers/biobb_gromacs:5.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/bioexcel/biobb_gromacs
- **Package**: https://anaconda.org/channels/bioconda/packages/biobb_gromacs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biobb_gromacs/overview
- **Total Downloads**: 14.5K
- **Last updated**: 2025-12-22
- **GitHub**: https://github.com/bioexcel/biobb_gromacs
- **Stars**: N/A
### Original Help Text
```text
usage: trjcat [-h] [-c CONFIG] -i INPUT_TRJ_ZIP_PATH -o OUTPUT_TRJ_PATH

Wrapper for the GROMACS trjcat module.

options:
  -h, --help            show this help message and exit
  -c, --config CONFIG   This file can be a YAML file, JSON file or JSON string

required arguments:
  -i, --input_trj_zip_path INPUT_TRJ_ZIP_PATH
                        Path the input GROMACS trajectories (xtc, trr, cpt, gro, pdb, tng) to concatenate in zip format. Accepted formats: zip.
  -o, --output_trj_path OUTPUT_TRJ_PATH
                        Path to the output trajectory file. Accepted formats: pdb, gro, xtc, trr, tng.
```

## Metadata
- **Skill**: generated

