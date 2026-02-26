# nglview CWL Generation Report

## nglview

### Tool Description
NGLView: An IPython/Jupyter widget to interactively view molecular structures and trajectories.

### Metadata
- **Docker Image**: quay.io/biocontainers/nglview:1.1.7--py_0
- **Homepage**: https://github.com/arose/nglview
- **Package**: https://anaconda.org/channels/bioconda/packages/nglview/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nglview/overview
- **Total Downloads**: 119.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/arose/nglview
- **Stars**: N/A
### Original Help Text
```text
usage: nglview [-h] [-c CRD] [--browser BROWSER] [-j JEXE]
               [--notebook-name NOTEBOOK_NAME] [--port PORT] [--remote]
               [--clean] [--auto] [--symlink]
               [command] [traj]

NGLView: An IPython/Jupyter widget to interactively view molecular structures and trajectories.

positional arguments:
  command               command could be a topology filename (.pdb, .mol2,
                        .parm7, ...) or could be a python script (.py), a
                        notebook (.ipynb). If not given, a notebook will be
                        created with only nglview imported
  traj                  coordinate filename, optional

optional arguments:
  -h, --help            show this help message and exit
  -c CRD, --crd CRD     coordinate filename
  --browser BROWSER     web browser
  -j JEXE, --jexe JEXE  jupyter path
  --notebook-name NOTEBOOK_NAME
                        notebook name
  --port PORT           port number
  --remote              create remote notebook
  --clean               delete temp file after closing notebook
  --auto                Run 1st cell right after openning notebook
  --symlink             Create symlink for nglview-js-widgets (developer mode)

Example

    # open notebook and display pdb file
    nglview 1tsu.pdb
    
    # open notebook and display trajectory
    nglview 1tsu.parm7 -c traj.nc

    # open notebook and display trajectory by reading all files ending with .nc
    # make sure to use quote " "
    nglview 1tsu.parm7 -c "*.nc"
    
    # open notebook and copy myscript.py content to 1st cell
    nglview myscript.py
    
    # open my_notebook.ipynb notebook and run 1st cell
    nglview my_notebook.ipynb
    
    # running Jupyter notebook remotely
    nglview 1tsu.parm7 -c traj.nc --remote
```

