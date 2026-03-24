# AMR-Pathfinder CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://erasmusmc-bioinformatics.github.io/benchAMRking/
- **Package**: https://workflowhub.eu/workflows/1189
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/1189/ro_crate?version=2
- **Conda**: N/A
- **Total Downloads**: 804
- **Last updated**: 2024-12-24
- **GitHub**: https://github.com/galaxyproject/tools-iuc/issues/6467
- **Stars**: N/A
- **Version**: 2
- **License**: MIT
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-AMR-Pathfinder_v4.7.ga` (Main Workflow)
- **Project**: Seq4AMR
- **Views**: 4908
- **Creators**: Helena Rasche, Dennis Dollée, Birgit Rijvers

## Description

This is an aggregation of the work done in [Seq4AMR](https://workflowhub.eu/projects/110) consisting of the following workflows:

- [WF1: AbritAMR / AMRFinderPlus](https://workflowhub.eu/workflows/634)
- [WF2: Sciensano](https://workflowhub.eu/workflows/644) (**not currently included**)
- [WF3: SRST2](https://workflowhub.eu/workflows/407) 
- [WF4: StarAMR](https://workflowhub.eu/workflows/470)

## Installation

- You will need to:
    - run the [RGI Database Builder](https://my.galaxy.training/?path=?tool_id=toolshed.g2.bx.psu.edu%2Frepos%2Fcard%2Frgi%2Frgi_database_builder%2F1.2.0) as a Galaxy admin (if this hasn't been done already)
    - [Have the en_US.UTF-8 locale installed](https://github.com/galaxyproject/tools-iuc/issues/6467) on the compute nodes executing cast/melt jobs.
    - Install the requisite tools with e.g. [`shed-tools`](https://ephemeris.readthedocs.io/en/latest/commands/shed-tools.html) command from the [`ephemeris`](https://ephemeris.readthedocs.io/en/latest/) suite: `shed-tools install -g https://galaxy.example.com -a API_KEY -t tools.yaml` (tools.yaml is provided in this repository.)
- Then you can import this workflow
    - Navigate to `/workflows/import` of your Galaxy server
    - Select "GA4GH servers"
    - Enter `name:"AMR-Pathfinder"`
- And run it
    - You must provide a Sequencing collection (list:paired of fastq files)
    - And a Genomes collection (list of fasta files) 
    - Both of these should use **identical** collection element identifiers

## Outputs

This will produce two important tables: "Binary Comparison" and a "% Identity Scored Outputs". 

### Binary comparison

This file reports the discovery or absence of specific AMR genes across all tested AMR Analysis tools. You will mostly see 1s (presence) or 0s (absence) but you may occasionally see higher numbers when an AMR tool reports multiple hits for a specific gene.

### % Identity Scored Outputs

This is similar to binary comparison, but using the % identity reported by each AMR tool. For cases where multiple hits were detected, we take the highest.

## Known Issues

The names for identified AMR genes is highly inconsistent across AMR analysis tools. We urge the AMR community to rectify this by standardising gene names used in their tooling.
