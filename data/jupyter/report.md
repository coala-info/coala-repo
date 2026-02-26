# jupyter CWL Generation Report

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


## jupyter_kernelspec

### Tool Description
Manage Jupyter kernel specifications.

### Metadata
- **Docker Image**: biocontainers/jupyter:phenomenal-v387f29b6ca83_cv0.4.12
- **Homepage**: https://github.com/jakevdp/PythonDataScienceHandbook
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
No subcommand specified. Must specify one of: ['list', 'remove', 'install-self', 'install', 'uninstall']

Manage Jupyter kernel specifications.

Subcommands
-----------

Subcommands are launched as `jupyter kernelspec cmd [args]`. For information on
using subcommand 'cmd', do: `jupyter kernelspec cmd -h`.

list
    List installed kernel specifications.
remove
    Remove one or more Jupyter kernelspecs by name.
install-self
    [DEPRECATED] Install the IPython kernel spec directory for this Python.
install
    Install a kernel specification directory.
uninstall
    Alias for remove
```


## jupyter_migrate

### Tool Description
Migrate configuration and data from .ipython prior to 4.0 to Jupyter locations.

This migrates:

- config files in the default profile - kernels in ~/.ipython/kernels - notebook
javascript extensions in ~/.ipython/extensions - custom.js/css to
.jupyter/custom

to their new Jupyter locations.

All files are copied, not moved. If the destinations already exist, nothing will
be done.

### Metadata
- **Docker Image**: biocontainers/jupyter:phenomenal-v387f29b6ca83_cv0.4.12
- **Homepage**: https://github.com/jakevdp/PythonDataScienceHandbook
- **Package**: Not found
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
-y
    Answer yes to any questions instead of prompting.
--generate-config
    generate default config file
--log-level=<Enum> (Application.log_level)
    Default: 30
    Choices: (0, 10, 20, 30, 40, 50, 'DEBUG', 'INFO', 'WARN', 'ERROR', 'CRITICAL')
    Set the log level by value or name.
--config=<Unicode> (JupyterApp.config_file)
    Default: ''
    Full path of a config file.

To see all available configurables, use `--help-all`
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


## jupyter_nbextension

### Tool Description
Work with Jupyter notebook extensions

### Metadata
- **Docker Image**: biocontainers/jupyter:phenomenal-v387f29b6ca83_cv0.4.12
- **Homepage**: https://github.com/jakevdp/PythonDataScienceHandbook
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Work with Jupyter notebook extensions

Subcommands
-----------

Subcommands are launched as `jupyter nbextension cmd [args]`. For information on
using subcommand 'cmd', do: `jupyter nbextension cmd -h`.

uninstall
    Uninstall an nbextension
disable
    Disable an nbextension
list
    List nbextensions
install
    Install an nbextension
enable
    Enable an nbextension

Options
-------

Arguments that take values are actually convenience aliases to full
Configurables, whose aliases are listed on the help line. For more information
on full configurables, see '--help-all'.

--debug
    set log level to logging.DEBUG (maximize logging output)
--sys-prefix
    Use sys.prefix as the prefix for installing nbextensions (for environments, packaging)
--python
    Install from a Python package
--system
    Apply the operation system-wide
--py
    Install from a Python package
--user
    Apply the operation only for the given user
--log-level=<Enum> (Application.log_level)
    Default: 30
    Choices: (0, 10, 20, 30, 40, 50, 'DEBUG', 'INFO', 'WARN', 'ERROR', 'CRITICAL')
    Set the log level by value or name.
--config=<Unicode> (JupyterApp.config_file)
    Default: ''
    Full path of a config file.

To see all available configurables, use `--help-all`

Examples
--------

    jupyter nbextension list                          # list all configured nbextensions
    jupyter nbextension install --py <packagename>    # install an nbextension from a Python package
    jupyter nbextension enable --py <packagename>     # enable all nbextensions in a Python package
    jupyter nbextension disable --py <packagename>    # disable all nbextensions in a Python package
    jupyter nbextension uninstall --py <packagename>  # uninstall an nbextension in a Python package
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


## jupyter_qtconsole

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: biocontainers/jupyter:phenomenal-v387f29b6ca83_cv0.4.12
- **Homepage**: https://github.com/jakevdp/PythonDataScienceHandbook
- **Package**: Not found
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/opt/conda/bin/jupyter-qtconsole", line 7, in <module>
    from qtconsole.qtconsoleapp import main
  File "/opt/conda/lib/python3.5/site-packages/qtconsole/qtconsoleapp.py", line 60, in <module>
    from qtconsole.qt import QtCore, QtGui
  File "/opt/conda/lib/python3.5/site-packages/qtconsole/qt.py", line 23, in <module>
    QtCore, QtGui, QtSvg, QT_API = load_qt(api_opts)
  File "/opt/conda/lib/python3.5/site-packages/qtconsole/qt_loaders.py", line 386, in load_qt
    api_options))
ImportError: 
    Could not load requested Qt binding. Please ensure that
    PyQt4 >= 4.7, PyQt5, PySide >= 1.0.3 or PySide2 is available,
    and only one is imported per session.

    Currently-imported Qt library:   None
    PyQt4 installed:                 False
    PyQt5 installed:                 False
    PySide >= 1.0.3 installed:       False
    PySide2 installed:               False
    Tried to load:                   ['pyqt5', 'pyside2', 'pyside', 'pyqt']
```


## jupyter_serverextension

### Tool Description
Work with Jupyter server extensions

### Metadata
- **Docker Image**: biocontainers/jupyter:phenomenal-v387f29b6ca83_cv0.4.12
- **Homepage**: https://github.com/jakevdp/PythonDataScienceHandbook
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Work with Jupyter server extensions

Subcommands
-----------

Subcommands are launched as `jupyter serverextension cmd [args]`. For
information on using subcommand 'cmd', do: `jupyter serverextension cmd -h`.

enable
    Enable an server extension
disable
    Disable an server extension
list
    List server extensions

Options
-------

Arguments that take values are actually convenience aliases to full
Configurables, whose aliases are listed on the help line. For more information
on full configurables, see '--help-all'.

--debug
    set log level to logging.DEBUG (maximize logging output)
--sys-prefix
    Use sys.prefix as the prefix for installing nbextensions (for environments, packaging)
--py
    Install from a Python package
--user
    Apply the operation only for the given user
--system
    Apply the operation system-wide
--python
    Install from a Python package
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

    jupyter serverextension list                        # list all configured server extensions
    jupyter serverextension enable --py <packagename>   # enable all server extensions in a Python package
    jupyter serverextension disable --py <packagename>  # disable all server extensions in a Python package
```


## jupyter_troubleshoot

### Tool Description
Troubleshoot Jupyter installation and environment.

### Metadata
- **Docker Image**: biocontainers/jupyter:phenomenal-v387f29b6ca83_cv0.4.12
- **Homepage**: https://github.com/jakevdp/PythonDataScienceHandbook
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
$PATH:
	/opt/conda/bin
	/opt/conda/bin
	/usr/local/sbin
	/usr/local/bin
	/usr/sbin
	/usr/bin
	/sbin
	/bin

sys.path:
	/opt/conda/bin
	/opt/conda/lib/python35.zip
	/opt/conda/lib/python3.5
	/opt/conda/lib/python3.5/plat-linux
	/opt/conda/lib/python3.5/lib-dynload
	/opt/conda/lib/python3.5/site-packages
	/opt/conda/lib/python3.5/site-packages/setuptools-27.2.0-py3.5.egg

sys.executable:
	/opt/conda/bin/python

sys.version:
	3.5.2 |Continuum Analytics, Inc.| (default, Jul  2 2016, 17:53:06) 
	[GCC 4.4.7 20120313 (Red Hat 4.4.7-1)]

platform.platform():
	Linux-6.8.0-100-generic-x86_64-with-debian-8.6

which -a jupyter:
	/opt/conda/bin/jupyter
	/opt/conda/bin/jupyter

conda list:
	# packages in environment at /opt/conda:
	#
	_r-mutex                  1.0.0                     mro_2    r
	backports.shutil_get_terminal_size 1.0.0                    py35_1    conda-forge
	bzip2                     1.0.6                         3  
	cairo                     1.14.8                        0  
	certifi                   2018.4.16                 <pip>
	chardet                   3.0.4                     <pip>
	conda                     4.2.12                   py35_0  
	conda-env                 2.6.0                         0  
	configurable-http-proxy   1.3.1                         0    conda-forge
	curl                      7.54.1                        0  
	decorator                 4.0.10                   py35_0    conda-forge
	docutils                  0.14                      <pip>
	entrypoints               0.2.2                    py35_0    conda-forge
	fontconfig                2.12.1                        3  
	freetype                  2.5.5                         2  
	glib                      2.50.2                        1  
	gsl                       2.2.1                         0  
	harfbuzz                  0.9.39                        2  
	httplib2                  0.11.3                    <pip>
	icu                       58.2                          0    conda-forge
	idna                      2.7                       <pip>
	ipykernel                 4.5.2                    py35_0    conda-forge
	ipython                   5.1.0                    py35_1    conda-forge
	ipython_genutils          0.1.0                    py35_0    conda-forge
	ipywidgets                5.2.2                    py35_1  
	jbig                      2.1                           0  
	jinja2                    2.8                      py35_1    conda-forge
	jpeg                      9b                            0  
	jsonschema                2.5.1                    py35_0    conda-forge
	jupyter                   1.0.0                     <pip>
	jupyter-console           5.2.0                     <pip>
	jupyter_client            4.4.0                    py35_0    conda-forge
	jupyter_core              4.2.1                    py35_0    conda-forge
	jupyterhub                0.7.1                    py35_0    conda-forge
	krb5                      1.13.2                        0  
	libffi                    3.2.1                         1  
	libgcc                    5.2.0                         0  
	libiconv                  1.14                          0  
	libpng                    1.6.30                        1  
	libsodium                 1.0.10                        0    conda-forge
	libssh2                   1.8.0                         0  
	libtiff                   4.0.6                         3  
	libxml2                   2.9.4                         0  
	lockfile                  0.12.2                    <pip>
	luigi                     2.7.6                     <pip>
	markupsafe                0.23                     py35_1    conda-forge
	mistune                   0.7.3                    py35_0    conda-forge
	nbconvert                 4.2.0                    py35_0    conda-forge
	nbformat                  4.2.0                    py35_0    conda-forge
	ncurses                   5.9                          10  
	nodejs                    6.6.0                         0    conda-forge
	notebook                  4.3.1                    py35_0    conda-forge
	oauth2client              4.1.2                     <pip>
	oauthlib                  2.1.0                     <pip>
	openssl                   1.0.2j                        0  
	pamela                    0.3.0                    py35_0    conda-forge
	pango                     1.40.3                        1  
	pcre                      8.39                          1  
	pexpect                   4.2.1                    py35_0    conda-forge
	pickleshare               0.7.3                    py35_0    conda-forge
	pip                       8.1.2                    py35_0  
	pixman                    0.34.0                        0  
	prompt_toolkit            1.0.9                    py35_0    conda-forge
	ptyprocess                0.5.1                    py35_0    conda-forge
	pyasn1                    0.4.3                     <pip>
	pyasn1-modules            0.2.2                     <pip>
	pycosat                   0.6.1                    py35_1  
	pycrypto                  2.6.1                    py35_4  
	pygments                  2.1.3                    py35_1    conda-forge
	pykube                    0.15.0                    <pip>
	python                    3.5.2                         0  
	python-daemon             2.1.2                     <pip>
	pytz                      2018.5                    <pip>
	PyYAML                    3.13                      <pip>
	pyzmq                     16.0.2                   py35_0    conda-forge
	qtconsole                 4.3.1                     <pip>
	r-assertthat              0.1                    r3.3.2_4    r
	r-backports               1.0.4                  r3.3.2_0    r
	r-base                    3.3.2                         5    conda-forge
	r-base64enc               0.1_3                  r3.3.2_0    r
	r-bitops                  1.0_6                  r3.3.2_2    r
	r-cairo                   1.5_9                  r3.3.2_1    r
	r-car                     2.1_4                  r3.3.2_0    r
	r-caret                   6.0_73                 r3.3.2_0    r
	r-catools                 1.17.1                 r3.3.2_2    r
	r-codetools               0.2_15                 r3.3.2_0    r
	r-colorspace              1.3_1                  r3.3.2_0    r
	r-crayon                  1.3.2                  r3.3.2_0    r
	r-data.table              1.10.0                 r3.3.2_0    r
	r-dichromat               2.0_0                  r3.3.2_2    r
	r-digest                  0.6.10                 r3.3.2_0    r
	r-evaluate                0.10                   r3.3.2_0    r
	r-foreach                 1.4.3                  r3.3.2_0    r
	r-ggplot2                 2.2.0                  r3.3.2_0    r
	r-gtable                  0.2.0                  r3.3.2_0    r
	r-highr                   0.6                    r3.3.2_0    r
	r-htmltools               0.3.5                  r3.3.2_0    r
	r-httpuv                  1.3.3                  r3.3.2_0    r
	r-irdisplay               0.4.4                  r3.3.2_0    r
	r-irkernel                0.7.1                  r3.3.2_0    r
	r-iterators               1.0.8                  r3.3.2_0    r
	r-jsonlite                1.1                    r3.3.2_0    r
	r-knitr                   1.15.1                 r3.3.2_0    r
	r-labeling                0.3                    r3.3.2_2    r
	r-lattice                 0.20_34                r3.3.2_0    r
	r-lazyeval                0.2.0                  r3.3.2_0    r
	r-lme4                    1.1_12                 r3.3.2_0    r
	r-magrittr                1.5                    r3.3.2_2    r
	r-markdown                0.7.7                  r3.3.2_2    r
	r-mass                    7.3_45                 r3.3.2_0    r
	r-matrix                  1.2_7.1                r3.3.2_0    r
	r-matrixmodels            0.4_1                  r3.3.2_0    r
	r-mgcv                    1.8_16                 r3.3.2_0    r
	r-mime                    0.5                    r3.3.2_0    r
	r-minqa                   1.2.4                  r3.3.2_2    r
	r-modelmetrics            1.1.0                  r3.3.2_0    r
	r-munsell                 0.4.3                  r3.3.2_0    r
	r-nlme                    3.1_128                r3.3.2_0    r
	r-nloptr                  1.0.4                  r3.3.2_2    r
	r-nnet                    7.3_12                 r3.3.2_0    r
	r-pbdzmq                  0.2_4                  r3.3.2_0    r
	r-pbkrtest                0.4_6                  r3.3.2_0    r
	r-plyr                    1.8.4                  r3.3.2_0    r
	r-quantreg                5.29                   r3.3.2_0    r
	r-r6                      2.2.0                  r3.3.2_0    r
	r-rcolorbrewer            1.1_2                  r3.3.2_3    r
	r-rcpp                    0.12.8                 r3.3.2_0    r
	r-rcppeigen               0.3.2.9.0              r3.3.2_0    r
	r-rcurl                   1.95_4.8               r3.3.2_0    r
	r-repr                    0.10                   r3.3.2_0    r
	r-reshape2                1.4.2                  r3.3.2_0    r
	r-rmarkdown               1.2                    r3.3.2_0    r
	r-rprojroot               1.1                    r3.3.2_0    r
	r-scales                  0.4.1                  r3.3.2_0    r
	r-shiny                   0.14.2                 r3.3.2_0    r
	r-sourcetools             0.1.5                  r3.3.2_0    r
	r-sparsem                 1.74                   r3.3.2_0    r
	r-stringi                 1.1.2                  r3.3.2_0    r
	r-stringr                 1.1.0                  r3.3.2_0    r
	r-tibble                  1.2                    r3.3.2_0    r
	r-uuid                    0.1_2                  r3.3.2_0    r
	r-xtable                  1.8_2                  r3.3.2_0    r
	r-yaml                    2.1.14                 r3.3.2_0    r
	readline                  6.2                           2  
	requests                  2.11.1                   py35_0  
	requests                  2.19.1                    <pip>
	requests-oauthlib         1.0.0                     <pip>
	rsa                       3.4.2                     <pip>
	ruamel_yaml               0.11.14                  py35_0  
	setuptools                27.2.0                   py35_0  
	simplegeneric             0.8.1                    py35_0    conda-forge
	six                       1.10.0                   py35_1    conda-forge
	sqlalchemy                1.1.4                    py35_0    conda-forge
	sqlite                    3.13.0                        0  
	terminado                 0.6                      py35_0    conda-forge
	tk                        8.5.18                        0  
	tornado                   4.4.2                    py35_0    conda-forge
	traitlets                 4.3.0                    py35_0    conda-forge
	tzlocal                   1.5.1                     <pip>
	urllib3                   1.23                      <pip>
	wcwidth                   0.1.7                    py35_0    conda-forge
	wheel                     0.29.0                   py35_0  
	widgetsnbextension        1.2.6                    py35_0  
	xz                        5.2.2                         0  
	yaml                      0.1.6                         0  
	zeromq                    4.1.5                         0    conda-forge
	zlib                      1.2.8                         3
```


## jupyter_trust

### Tool Description
Trust or untrust a notebook.

### Metadata
- **Docker Image**: biocontainers/jupyter:phenomenal-v387f29b6ca83_cv0.4.12
- **Homepage**: https://github.com/jakevdp/PythonDataScienceHandbook
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/opt/conda/lib/python3.5/site-packages/nbformat/reader.py", line 14, in parse_json
    nb_dict = json.loads(s, **kwargs)
  File "/opt/conda/lib/python3.5/json/__init__.py", line 319, in loads
    return _default_decoder.decode(s)
  File "/opt/conda/lib/python3.5/json/decoder.py", line 339, in decode
    obj, end = self.raw_decode(s, idx=_w(s, 0).end())
  File "/opt/conda/lib/python3.5/json/decoder.py", line 357, in raw_decode
    raise JSONDecodeError("Expecting value", s, err.value) from None
json.decoder.JSONDecodeError: Expecting value: line 1 column 1 (char 0)

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/opt/conda/bin/jupyter-trust", line 6, in <module>
    sys.exit(nbformat.sign.TrustNotebookApp.launch_instance())
  File "/opt/conda/lib/python3.5/site-packages/jupyter_core/application.py", line 267, in launch_instance
    return super(JupyterApp, cls).launch_instance(argv=argv, **kwargs)
  File "/opt/conda/lib/python3.5/site-packages/traitlets/config/application.py", line 653, in launch_instance
    app.start()
  File "/opt/conda/lib/python3.5/site-packages/nbformat/sign.py", line 452, in start
    nb = reads(nb_s, NO_CONVERT)
  File "/opt/conda/lib/python3.5/site-packages/nbformat/__init__.py", line 74, in reads
    nb = reader.reads(s, **kwargs)
  File "/opt/conda/lib/python3.5/site-packages/nbformat/reader.py", line 58, in reads
    nb_dict = parse_json(s, **kwargs)
  File "/opt/conda/lib/python3.5/site-packages/nbformat/reader.py", line 17, in parse_json
    raise NotJSONError(("Notebook does not appear to be JSON: %r" % s)[:77] + "...")
nbformat.reader.NotJSONError: Notebook does not appear to be JSON: ''...
```

