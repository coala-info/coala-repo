# repic CWL Generation Report

## repic_get_cliques

### Tool Description
Finds cliques of particles based on proximity in 3D space.

### Metadata
- **Docker Image**: quay.io/biocontainers/repic:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/ccameron/REPIC
- **Package**: https://anaconda.org/channels/bioconda/packages/repic/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/repic/overview
- **Total Downloads**: 6.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ccameron/REPIC
- **Stars**: N/A
### Original Help Text
```text
usage: repic get_cliques [-h] [--multi_out] [--get_cc] in_dir out_dir box_size

positional arguments:
  in_dir       path to input directory containing subdirectories of particle
               bounding box coordinate files
  out_dir      path to output directory (WARNING - script will delete
               directory if it exists)
  box_size     particle bounding box size (in int[pixels])

options:
  -h, --help   show this help message and exit
  --multi_out  set output of cliques to be members sorted by picker name
  --get_cc     filters cliques for those in the largest Connected Component
               (CC)
```


## repic_run_ilp

### Tool Description
Run the ILP solver to find the optimal particle configuration.

### Metadata
- **Docker Image**: quay.io/biocontainers/repic:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/ccameron/REPIC
- **Package**: https://anaconda.org/channels/bioconda/packages/repic/overview
- **Validation**: PASS

### Original Help Text
```text
usage: repic run_ilp [-h] [--num_particles NUM_PARTICLES] in_dir box_size

positional arguments:
  in_dir                path to input directory containing get_cliques.py
                        output
  box_size              particle bounding box size (in int[pixels])

options:
  -h, --help            show this help message and exit
  --num_particles NUM_PARTICLES
                        filter for the number of expected particles (int)
```


## repic_iter_config

### Tool Description
Generates configuration files for iterative particle picking.

### Metadata
- **Docker Image**: quay.io/biocontainers/repic:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/ccameron/REPIC
- **Package**: https://anaconda.org/channels/bioconda/packages/repic/overview
- **Validation**: PASS

### Original Help Text
```text
usage: repic iter_config [-h] [--cryolo_env CRYOLO_ENV] [--deep_env DEEP_ENV]
                         [--deep_model DEEP_MODEL] [--topaz_env TOPAZ_ENV]
                         [--topaz_model TOPAZ_MODEL]
                         [--out_file_path OUT_FILE_PATH]
                         data_dir box_size exp_particles cryolo_model deep_dir
                         topaz_scale topaz_rad

positional arguments:
  data_dir              path to directory containing training data
  box_size              particle bounding box size (in int[pixels])
  exp_particles         number of expected particles (int)
  cryolo_model          path to LOWPASS SPHIRE-crYOLO model
  deep_dir              path to DeepPicker scripts
  topaz_scale           Topaz scale value (int)
  topaz_rad             Topaz particle radius size (in int[pixels])

options:
  -h, --help            show this help message and exit
  --cryolo_env CRYOLO_ENV
                        Conda environment name or prefix for SPHIRE-crYOLO
                        installation (default:cryolo)
  --deep_env DEEP_ENV   Conda environment name or prefix for DeepPicker
                        installation (default:deep)
  --deep_model DEEP_MODEL
                        path to pre-trained DeepPicker model (default:out-of-
                        the-box model)
  --topaz_env TOPAZ_ENV
                        Conda environment name or prefix for Topaz
                        installation (default:topaz)
  --topaz_model TOPAZ_MODEL
                        path to pre-trained Topaz model (default:out-of-the-
                        box model)
  --out_file_path OUT_FILE_PATH
                        path for created config file
                        (default:./iter_config.json)
```


## repic_iter_pick

### Tool Description
Iteratively pick particles based on a configuration file.

### Metadata
- **Docker Image**: quay.io/biocontainers/repic:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/ccameron/REPIC
- **Package**: https://anaconda.org/channels/bioconda/packages/repic/overview
- **Validation**: PASS

### Original Help Text
```text
usage: repic iter_pick [-h] [--semi_auto] [--sample_prob SAMPLE_PROB]
                       [--score] [--out_file_path OUT_FILE_PATH]
                       config_file num_iter train_size

positional arguments:
  config_file           path to REPIC config file
  num_iter              number of iterations (int)
  train_size            training subset percentage (int)

options:
  -h, --help            show this help message and exit
  --semi_auto           initialize training labels with known particles (semi-
                        automatic)
  --sample_prob SAMPLE_PROB
                        sampling probability of initial training labels for
                        'semi_auto' (default:1.)
  --score               evaluate picked particle sets
  --out_file_path OUT_FILE_PATH
                        path for picking log file
                        (default:<data_dir>/iter_pick.log)
```


## Metadata
- **Skill**: generated
