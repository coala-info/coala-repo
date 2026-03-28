[ ]
[ ]

[Skip to content](#backing-up)

[![logo](../img/little_logo.svg)](.. "Nomadic")

Nomadic

Sharing and Backing up

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
  + [Quick Start](../quick_start/)
  + [Basic Usage](../basic/)
  + [ ]

    Sharing and Backing up

    [Sharing and Backing up](./)

    Table of contents
    - [Backing up](#backing-up)
    - [Sharing data](#sharing-data)
    - [Configuring default values](#configuring-default-values)
  + [Advanced Usage](../advanced/)
* [Understanding the Dashboard](../understand/)
* [Output Files](../output_files/)
* [FAQ](../faq/)

Table of contents

* [Backing up](#backing-up)
* [Sharing data](#sharing-data)
* [Configuring default values](#configuring-default-values)

# Sharing and Backing up

## Backing up

To create a complete backup of your workspace e.g. to an external hard disk drive or other location accessible on or from your computer (including an ssh location):

```
nomadic backup -t <path/to/your/backup/location>
```

The backup process will also backup all minknow data so be prepared for it to take a while the first time you run it. At the end you will see a short summary:

![metadata](../img/backup_share/backup_summary.png)

## Sharing data

The results folder for an experiment (`results/<expt_name>`) contains all the outputs from *Nomadic*. Only the CSV files starting `summary` and the `metadata` folder are required to relaunch the dashboard with the `nomadic dashboard` command (see [Basic Usage](../basic/)). `Nomadic` allows easy sharing of your workspace by copying key summary `Nomadic` and `MinKNOW` files to a new location, e.g. a cloud synchronised folder.

```
nomadic share -t <path/to/your/shared/location>
```

Once shared, `Nomadic` can be run by collaborators and other members of the group as needed.

## Configuring default values

The above settings can be saved per workspace so that you don't need to enter the details each time. To save the configuration do the following:

```
nomadic configure backup -t <path/to/your/backup/location>
nomadic configure share -t <path/to/your/shared/location>
```

Once configured you can omit the `-t` option e.g.

```
nomadic backup
nomadic share
```

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)