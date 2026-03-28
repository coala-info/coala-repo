[ ]
[ ]

[![logo](../img/little_logo.svg)](.. "Nomadic")

Nomadic

Quick Start

Initializing search

[GitHub](https://github.com/JasonAHendry/nomadic.git "Go to repository")

[![logo](../img/little_logo.svg)](.. "Nomadic")
Nomadic

[GitHub](https://github.com/JasonAHendry/nomadic.git "Go to repository")

* [Overview](..)
* [Installation](../installation/)
* [x]

  Usage

  Usage
  + [ ]
    [Quick Start](./)
  + [Basic Usage](../basic/)
  + [Sharing and Backing up](../share_backup/)
  + [Advanced Usage](../advanced/)
* [Understanding the Dashboard](../understand/)
* [Output Files](../output_files/)
* [FAQ](../faq/)

# Quick Start

To run *Nomadic* for a sequencing run, open a terminal window and type the following:

```
conda activate nomadic
cd <path/to/your/workspace>
nomadic realtime <expt_name>
```

* `<path/to/your/workspace>` should be replaced with the path to your *Nomadic* workspace.
* `<expt_name>` should be replaced with the name of your experiment.
  + You should have given your experiment the same name in *MinKNOW*.
  + You should have given your metadata file this name, and put it in your workspace metadata folder (`<path/to/your/workspace>/metadata/<expt_name>.csv|xlsx`).

The dashboard will open in a browser window on your computer.

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)