# jupyter CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| jupyter_console | Not completed | interactive console, needs a terminal and a kernel session |
| jupyter_kernelspec_install | PASS |  |
| jupyter_kernelspec_list | PASS |  |
| jupyter_migrate | PASS | synthetic data: a small planted ~/.ipython folder with a kernel and a notebook config; both were migrated |
| jupyter_nbconvert | PASS |  |
| jupyter_notebook | Not completed | long-running notebook server, skipped |
| jupyter_trust | PASS |  |

## jupyter_console

### Tool Description
The Jupyter terminal-based Console.

This launches a Console application inside a terminal.

The Console supports various extra features beyond the traditional single-
process Terminal IPython shell, such as connecting to an existing ipython
session, via:

    jupyter console --existing

where the previous session could have been created by another ipython console,
an ipython qtconsole, or by opening an ipython notebook.

### Metadata
- **Docker Image**: biocontainers/jupyter:phenomenal-v387f29b6ca83_cv0.4.12
- **Homepage**: https://github.com/jakevdp/PythonDataScienceHandbook
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/main/packages/jupyter/overview
- **Total Downloads**: 27.2K
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/jakevdp/PythonDataScienceHandbook
- **Stars**: N/A
### Original Help Text
```text
The Jupyter terminal-based Console.

This launches a Console application inside a terminal.

The Console supports various extra features beyond the traditional single-
process Terminal IPython shell, such as connecting to an existing ipython
session, via:

    jupyter console --existing

where the previous session could have been created by another ipython console,
an ipython qtconsole, or by opening an ipython notebook.

Options
-------

Arguments that take values are actually convenience aliases to full
Configurables, whose aliases are listed on the help line. For more information
on full configurables, see '--help-all'.

--confirm-exit
    Set to display confirmation dialog on exit. You can always use 'exit' or
    'quit', to force a direct exit without any confirmation. This can also
    be set in the config file by setting
    `c.JupyterConsoleApp.confirm_exit`.
--existing
    Connect to an existing kernel. If no argument specified, guess most recent
--debug
    set log level to logging.DEBUG (maximize logging output)
--no-simple-prompt
    Use a rich interactive prompt with prompt_toolkit
--simple-prompt
    Force simple minimal prompt using `raw_input`
--generate-config
    generate default config file
-y
    Answer yes to any questions instead of prompting.
--no-confirm-exit
    Don't prompt the user when exiting. This will terminate the kernel
    if it is owned by the frontend, and leave it alive if it is external.
    This can also be set in the config file by setting
    `c.JupyterConsoleApp.confirm_exit`.
--ssh=<Unicode> (JupyterConsoleApp.sshserver)
    Default: ''
    The SSH server to use to connect to the kernel.
--stdin=<Int> (JupyterConsoleApp.stdin_port)
    Default: 0
    set the stdin (ROUTER) port [default: random]
-f <Unicode> (JupyterConsoleApp.connection_file)
    Default: ''
    JSON file in which to store connection info [default: kernel-<pid>.json]
    This file will contain the IP, ports, and authentication key needed to
    connect clients to this kernel. By default, this file will be created in the
    security dir of the current profile, but can be specified by absolute path.
--existing=<CUnicode> (JupyterConsoleApp.existing)
    Default: ''
    Connect to an already running kernel
--transport=<CaselessStrEnum> (JupyterConsoleApp.transport)
    Default: 'tcp'
    Choices: ['tcp', 'ipc']
--config=<Unicode> (JupyterApp.config_file)
    Default: ''
    Full path of a config file.
--shell=<Int> (JupyterConsoleApp.shell_port)
    Default: 0
    set the shell (ROUTER) port [default: random]
--log-level=<Enum> (Application.log_level)
    Default: 30
    Choices: (0, 10, 20, 30, 40, 50, 'DEBUG', 'INFO', 'WARN', 'ERROR', 'CRITICAL')
    Set the log level by value or name.
--hb=<Int> (JupyterConsoleApp.hb_port)
    Default: 0
    set the heartbeat port [default: random]
--kernel=<Unicode> (JupyterConsoleApp.kernel_name)
    Default: 'python'
    The name of the default kernel to start.
--ip=<Unicode> (JupyterConsoleApp.ip)
    Default: ''
    Set the kernel's IP address [default localhost]. If the IP address is
    something other than localhost, then Consoles on other machines will be able
    to connect to the Kernel, so be careful!
--iopub=<Int> (JupyterConsoleApp.iopub_port)
    Default: 0
    set the iopub (PUB) port [default: random]

To see all available configurables, use `--help-all`

Examples
--------

    jupyter console # start the ZMQ-based console
    jupyter console --existing # connect to an existing ipython session
```

## jupyter_nbconvert

### Tool Description
This application is used to convert notebook files (*.ipynb) to various other
formats.

### Metadata
- **Docker Image**: biocontainers/jupyter:phenomenal-v387f29b6ca83_cv0.4.12
- **Homepage**: https://github.com/jakevdp/PythonDataScienceHandbook
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
This application is used to convert notebook files (*.ipynb) to various other
formats.

WARNING: THE COMMANDLINE INTERFACE MAY CHANGE IN FUTURE RELEASES.

Options
-------

Arguments that take values are actually convenience aliases to full
Configurables, whose aliases are listed on the help line. For more information
on full configurables, see '--help-all'.

--generate-config
    generate default config file
--inplace
    Run nbconvert in place, overwriting the existing notebook (only 
    relevant when converting to notebook format)
-y
    Answer yes to any questions instead of prompting.
--execute
    Execute the notebook prior to export.
--allow-errors
    Continue notebook execution even if one of the cells throws an error and include the error message in the cell output (the default behaviour is to abort conversion). This flag is only relevant if '--execute' was specified, too.
--debug
    set log level to logging.DEBUG (maximize logging output)
--stdout
    Write notebook output to stdout instead of files.
--stdin
    read a single notebook file from stdin. Write the resulting notebook with default basename 'notebook.*'
--post=<DottedOrNone> (NbConvertApp.postprocessor_class)
    Default: ''
    PostProcessor class used to write the results of the conversion
--nbformat=<Enum> (NotebookExporter.nbformat_version)
    Default: 4
    Choices: [1, 2, 3, 4]
    The nbformat version to write. Use this to downgrade notebooks.
--output=<Unicode> (NbConvertApp.output_base)
    Default: ''
    overwrite base name use for output files. can only be used when converting
    one notebook at a time.
--config=<Unicode> (JupyterApp.config_file)
    Default: ''
    Full path of a config file.
--output-dir=<Unicode> (FilesWriter.build_directory)
    Default: ''
    Directory to write output to.  Leave blank to output to the current
    directory
--log-level=<Enum> (Application.log_level)
    Default: 30
    Choices: (0, 10, 20, 30, 40, 50, 'DEBUG', 'INFO', 'WARN', 'ERROR', 'CRITICAL')
    Set the log level by value or name.
--template=<Unicode> (TemplateExporter.template_file)
    Default: ''
    Name of the template file to use
--reveal-prefix=<Unicode> (SlidesExporter.reveal_url_prefix)
    Default: ''
    The URL prefix for reveal.js. This can be a a relative URL for a local copy
    of reveal.js, or point to a CDN.
    For speaker notes to work, a local reveal.js prefix must be used.
--to=<Unicode> (NbConvertApp.export_format)
    Default: 'html'
    The export format to be used, either one of the built-in formats, or a
    dotted object name that represents the import path for an `Exporter` class
--writer=<DottedObjectName> (NbConvertApp.writer_class)
    Default: 'FilesWriter'
    Writer class used to write the  results of the conversion

To see all available configurables, use `--help-all`

Examples
--------

    The simplest way to use nbconvert is
    
    > jupyter nbconvert mynotebook.ipynb
    
    which will convert mynotebook.ipynb to the default format (probably HTML).
    
    You can specify the export format with `--to`.
    Options include ['custom', 'html', 'latex', 'markdown', 'notebook', 'pdf', 'python', 'rst', 'script', 'slides']
    
    > jupyter nbconvert --to latex mynotebook.ipynb
    
    Both HTML and LaTeX support multiple output templates. LaTeX includes
    'base', 'article' and 'report'.  HTML includes 'basic' and 'full'. You
    can specify the flavor of the format used.
    
    > jupyter nbconvert --to html --template basic mynotebook.ipynb
    
    You can also pipe the output to stdout, rather than a file
    
    > jupyter nbconvert mynotebook.ipynb --stdout
    
    PDF is generated via latex
    
    > jupyter nbconvert mynotebook.ipynb --to pdf
    
    You can get (and serve) a Reveal.js-powered slideshow
    
    > jupyter nbconvert myslides.ipynb --to slides --post serve
    
    Multiple notebooks can be given at the command line in a couple of 
    different ways:
    
    > jupyter nbconvert notebook*.ipynb
    > jupyter nbconvert notebook1.ipynb notebook2.ipynb
    
    or you can specify the notebooks list in a config file, containing::
    
        c.NbConvertApp.notebooks = ["my_notebook.ipynb"]
    
    > jupyter nbconvert --config mycfg.py
```

## jupyter_notebook

### Tool Description
The Jupyter HTML Notebook.

This launches a Tornado based HTML Notebook Server that serves up an
HTML5/Javascript Notebook client.

### Metadata
- **Docker Image**: biocontainers/jupyter:phenomenal-v387f29b6ca83_cv0.4.12
- **Homepage**: https://github.com/jakevdp/PythonDataScienceHandbook
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
The Jupyter HTML Notebook.

This launches a Tornado based HTML Notebook Server that serves up an
HTML5/Javascript Notebook client.

Subcommands
-----------

Subcommands are launched as `jupyter-notebook cmd [args]`. For information on
using subcommand 'cmd', do: `jupyter-notebook cmd -h`.

list
    List currently running notebook servers.

Options
-------

Arguments that take values are actually convenience aliases to full
Configurables, whose aliases are listed on the help line. For more information
on full configurables, see '--help-all'.

--no-mathjax
    Disable MathJax
    
    MathJax is the javascript library Jupyter uses to render math/LaTeX. It is
    very large, so you may want to disable it if you have a slow internet
    connection, or for offline use of the notebook.
    
    When disabled, equations etc. will appear as their untransformed TeX source.
--no-script
    DEPRECATED, IGNORED
--generate-config
    generate default config file
--debug
    set log level to logging.DEBUG (maximize logging output)
--pylab
    DISABLED: use %pylab or %matplotlib in the notebook to enable matplotlib.
-y
    Answer yes to any questions instead of prompting.
--no-browser
    Don't open the notebook in a browser after startup.
--script
    DEPRECATED, IGNORED
--browser=<Unicode> (NotebookApp.browser)
    Default: ''
    Specify what command to use to invoke a web browser when opening the
    notebook. If not specified, the default browser will be determined by the
    `webbrowser` standard library module, which allows setting of the BROWSER
    environment variable to override it.
--config=<Unicode> (JupyterApp.config_file)
    Default: ''
    Full path of a config file.
--transport=<CaselessStrEnum> (KernelManager.transport)
    Default: 'tcp'
    Choices: ['tcp', 'ipc']
--keyfile=<Unicode> (NotebookApp.keyfile)
    Default: ''
    The full path to a private key file for usage with SSL/TLS.
--port=<Int> (NotebookApp.port)
    Default: 8888
    The port the notebook server will listen on.
--log-level=<Enum> (Application.log_level)
    Default: 30
    Choices: (0, 10, 20, 30, 40, 50, 'DEBUG', 'INFO', 'WARN', 'ERROR', 'CRITICAL')
    Set the log level by value or name.
--notebook-dir=<Unicode> (NotebookApp.notebook_dir)
    Default: ''
    The directory to use for notebooks and kernels.
--pylab=<Unicode> (NotebookApp.pylab)
    Default: 'disabled'
    DISABLED: use %pylab or %matplotlib in the notebook to enable matplotlib.
--client-ca=<Unicode> (NotebookApp.client_ca)
    Default: ''
    The full path to a certificate authority certificate for SSL/TLS client
    authentication.
--ip=<Unicode> (NotebookApp.ip)
    Default: 'localhost'
    The IP address the notebook server will listen on.
--certfile=<Unicode> (NotebookApp.certfile)
    Default: ''
    The full path to an SSL/TLS certificate file.
--port-retries=<Int> (NotebookApp.port_retries)
    Default: 50
    The number of additional ports to try if the specified port is not
    available.

To see all available configurables, use `--help-all`

Examples
--------

    jupyter notebook                       # start the notebook
    jupyter notebook --certfile=mycert.pem # use SSL/TLS certificate
```

## jupyter_kernelspec_list

### Tool Description
List installed kernel specifications.

### Metadata
- **Docker Image**: biocontainers/jupyter:phenomenal-v387f29b6ca83_cv0.4.12
- **Homepage**: https://github.com/jupyter/jupyter_client
- **Package**: https://anaconda.org/channels/bioconda/packages/jupyter/overview
- **Validation**: PASS

### Original Help Text
```text
List installed kernel specifications.

Options
-------

Arguments that take values are actually convenience aliases to full
Configurables, whose aliases are listed on the help line. For more information
on full configurables, see '--help-all'.

--json
    output spec name and location as machine-readable json.
--debug
    set log level to logging.DEBUG (maximize logging output)
--log-level=<Enum> (Application.log_level)
    Default: 30
    Choices: (0, 10, 20, 30, 40, 50, 'DEBUG', 'INFO', 'WARN', 'ERROR', 'CRITICAL')
    Set the log level by value or name.
--config=<Unicode> (JupyterApp.config_file)
    Default: ''
    Full path of a config file.

To see all available configurables, use `--help-all`
```

## jupyter_kernelspec_install

### Tool Description
Install a kernel specification directory.

### Metadata
- **Docker Image**: biocontainers/jupyter:phenomenal-v387f29b6ca83_cv0.4.12
- **Homepage**: https://github.com/jupyter/jupyter_client
- **Package**: https://anaconda.org/channels/bioconda/packages/jupyter/overview
- **Validation**: PASS

### Original Help Text
```text
Install a kernel specification directory.

Given a SOURCE DIRECTORY containing a kernel spec, jupyter will copy that
directory into one of the Jupyter kernel directories. The default is to install
kernelspecs for all users. `--user` can be specified to install a kernel only
for the current user.

Options
-------

Arguments that take values are actually convenience aliases to full
Configurables, whose aliases are listed on the help line. For more information
on full configurables, see '--help-all'.

--replace
    Replace any existing kernel spec with this name.
--sys-prefix
    Install to Python's sys.prefix. Useful in conda/virtual environments.
--debug
    set log level to logging.DEBUG (maximize logging output)
--user
    Install to the per-user kernel registry
--config=<Unicode> (JupyterApp.config_file)
    Default: ''
    Full path of a config file.
--log-level=<Enum> (Application.log_level)
    Default: 30
    Choices: (0, 10, 20, 30, 40, 50, 'DEBUG', 'INFO', 'WARN', 'ERROR', 'CRITICAL')
    Set the log level by value or name.
--prefix=<Unicode> (InstallKernelSpec.prefix)
    Default: ''
    Specify a prefix to install to, e.g. an env. The kernelspec will be
    installed in PREFIX/share/jupyter/kernels/
--name=<Unicode> (InstallKernelSpec.kernel_name)
    Default: ''
    Install the kernel spec with this name

To see all available configurables, use `--help-all`

Examples
--------

    jupyter kernelspec install /path/to/my_kernel --user
```

## jupyter_trust

### Tool Description
Sign one or more Jupyter notebooks with your key, to trust their dynamic (HTML,

### Metadata
- **Docker Image**: biocontainers/jupyter:phenomenal-v387f29b6ca83_cv0.4.12
- **Homepage**: https://github.com/jupyter/jupyter_core
- **Package**: https://anaconda.org/channels/bioconda/packages/jupyter/overview
- **Validation**: PASS

### Original Help Text
```text
Sign one or more Jupyter notebooks with your key, to trust their dynamic (HTML,
Javascript) output.

Otherwise, you will have to re-execute the notebook to see output.

Options
-------

Arguments that take values are actually convenience aliases to full
Configurables, whose aliases are listed on the help line. For more information
on full configurables, see '--help-all'.

-y
    Answer yes to any questions instead of prompting.
--debug
    set log level to logging.DEBUG (maximize logging output)
--generate-config
    generate default config file
--reset
    Delete the trusted notebook cache.
    All previously signed notebooks will become untrusted.
--config=<Unicode> (JupyterApp.config_file)
    Default: ''
    Full path of a config file.
--log-level=<Enum> (Application.log_level)
    Default: 30
    Choices: (0, 10, 20, 30, 40, 50, 'DEBUG', 'INFO', 'WARN', 'ERROR', 'CRITICAL')
    Set the log level by value or name.

To see all available configurables, use `--help-all`

Examples
--------

    jupyter trust mynotebook.ipynb and_this_one.ipynb
```

## jupyter_migrate

### Tool Description
Migrate configuration and data from .ipython prior to 4.0 to Jupyter locations.

### Metadata
- **Docker Image**: biocontainers/jupyter:phenomenal-v387f29b6ca83_cv0.4.12
- **Homepage**: https://github.com/jupyter/jupyter_core
- **Package**: https://anaconda.org/channels/bioconda/packages/jupyter/overview
- **Validation**: PASS

### Original Help Text
```text
Migrate configuration and data from .ipython prior to 4.0 to Jupyter locations.

This migrates:

- config files in the default profile - kernels in ~/.ipython/kernels - notebook
javascript extensions in ~/.ipython/extensions - custom.js/css to
.jupyter/custom

to their new Jupyter locations.

All files are copied, not moved. If the destinations already exist, nothing will
be done.

Options
-------

Arguments that take values are actually convenience aliases to full
Configurables, whose aliases are listed on the help line. For more information
on full configurables, see '--help-all'.

--debug
    set log level to logging.DEBUG (maximize logging output)
--generate-config
    generate default config file
-y
    Answer yes to any questions instead of prompting.
--config=<Unicode> (JupyterApp.config_file)
    Default: ''
    Full path of a config file.
--log-level=<Enum> (Application.log_level)
    Default: 30
    Choices: (0, 10, 20, 30, 40, 50, 'DEBUG', 'INFO', 'WARN', 'ERROR', 'CRITICAL')
    Set the log level by value or name.

To see all available configurables, use `--help-all`
```

## Metadata
- **Skill**: generated
