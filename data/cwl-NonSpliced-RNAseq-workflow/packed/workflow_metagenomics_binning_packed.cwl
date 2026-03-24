{
    "$graph": [
        {
            "class": "CommandLineTool",
            "id": "#bakta.cwl",
            "label": "Bakta: rapid & standardized annotation of bacterial genomes, MAGs & plasmids",
            "doc": "The software and documentation can be found here:\nhttps://github.com/oschwengers/bakta\n\nNecessary database files can be found here:\nhttps://doi.org/10.5281/zenodo.4247252\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "ramMin": 4096,
                    "coresMin": 1,
                    "class": "ResourceRequirement"
                }
            ],
            "hints": [
                {
                    "class": "LoadListingRequirement",
                    "loadListing": "deep_listing"
                },
                {
                    "class": "NetworkAccess",
                    "networkAccess": true
                },
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/bakta:1.9.4-db-light5.1",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "1.9.4"
                            ],
                            "specs": [
                                "https://github.com/oschwengers/bakta",
                                "doi.org/10.1099/mgen.0.000685"
                            ],
                            "package": "bakta"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "arguments": [
                {
                    "prefix": "--db",
                    "valueFrom": "${\n  // check if custom profile directory is used\n  if (inputs.db){\n    return inputs.db.path\n  }\n  // else use default built-in bakta db-light database\n  else { \n    return \"/bakta-db_v5.1-light\";\n  }\n}\n"
                }
            ],
            "inputs": [
                {
                    "doc": "Genome assembly in Fasta format",
                    "id": "#bakta.cwl/bakta/fasta_file",
                    "inputBinding": {
                        "position": 100
                    },
                    "type": "File"
                },
                {
                    "doc": "Database path (default = build-in light database)",
                    "id": "#bakta.cwl/bakta/db",
                    "type": [
                        "null",
                        "Directory"
                    ]
                },
                {
                    "doc": "Minimum contig size (default = 1; 200 in compliant mode)",
                    "id": "#bakta.cwl/bakta/min_contig_length",
                    "inputBinding": {
                        "prefix": "--min-contig-length"
                    },
                    "type": [
                        "null",
                        "int"
                    ]
                },
                {
                    "doc": "Prefix for output files",
                    "id": "#bakta.cwl/bakta/prefix",
                    "inputBinding": {
                        "prefix": "--prefix"
                    },
                    "type": [
                        "null",
                        "string"
                    ]
                },
                {
                    "doc": "Output directory (default = current working directory)",
                    "id": "#bakta.cwl/bakta/output",
                    "inputBinding": {
                        "prefix": "--output"
                    },
                    "type": [
                        "null",
                        "Directory"
                    ]
                },
                {
                    "doc": "Force overwriting existing output folder (except for current working directory)",
                    "id": "#bakta.cwl/bakta/force",
                    "inputBinding": {
                        "prefix": "--force"
                    },
                    "default": true,
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Genus name",
                    "id": "#bakta.cwl/bakta/genus",
                    "inputBinding": {
                        "prefix": "--genus"
                    },
                    "type": [
                        "null",
                        "string"
                    ]
                },
                {
                    "doc": "Species name",
                    "id": "#bakta.cwl/bakta/species",
                    "inputBinding": {
                        "prefix": "--species"
                    },
                    "type": [
                        "null",
                        "string"
                    ]
                },
                {
                    "doc": "Strain name",
                    "id": "#bakta.cwl/bakta/strain",
                    "inputBinding": {
                        "prefix": "--strain"
                    },
                    "type": [
                        "null",
                        "string"
                    ]
                },
                {
                    "doc": "Plasmid name",
                    "id": "#bakta.cwl/bakta/plasmid",
                    "inputBinding": {
                        "prefix": "--plasmid"
                    },
                    "type": [
                        "null",
                        "string"
                    ]
                },
                {
                    "doc": "All sequences are complete replicons (chromosome/plasmid[s])",
                    "id": "#bakta.cwl/bakta/complete",
                    "inputBinding": {
                        "prefix": "--complete"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Prodigal training file for CDS prediction",
                    "id": "#bakta.cwl/bakta/prodigal_tf_file",
                    "inputBinding": {
                        "prefix": "--prodigal-tf"
                    },
                    "type": [
                        "null",
                        "File"
                    ]
                },
                {
                    "doc": "Translation table 11/4 (default = 11)",
                    "id": "#bakta.cwl/bakta/translation_table",
                    "inputBinding": {
                        "prefix": "--translation-table"
                    },
                    "type": [
                        "null",
                        "int"
                    ]
                },
                {
                    "doc": "Gram type (default = ?)",
                    "id": "#bakta.cwl/bakta/gram",
                    "inputBinding": {
                        "prefix": "--gram"
                    },
                    "type": [
                        "null",
                        "string"
                    ]
                },
                {
                    "doc": "Locus prefix (default = contig)",
                    "id": "#bakta.cwl/bakta/locus",
                    "inputBinding": {
                        "prefix": "--locus"
                    },
                    "type": [
                        "null",
                        "string"
                    ]
                },
                {
                    "doc": "Locus tag prefix (default = autogenerated)",
                    "id": "#bakta.cwl/bakta/locus_tag",
                    "inputBinding": {
                        "prefix": "--locus-tag"
                    },
                    "type": [
                        "null",
                        "string"
                    ]
                },
                {
                    "doc": "Keep original contig headers",
                    "id": "#bakta.cwl/bakta/keep_contig_headers",
                    "inputBinding": {
                        "prefix": "--keep-contig-headers"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Force Genbank/ENA/DDJB compliance",
                    "id": "#bakta.cwl/bakta/compliant",
                    "inputBinding": {
                        "prefix": "--compliant"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Replicon information table (tsv/csv)",
                    "id": "#bakta.cwl/bakta/replicons",
                    "inputBinding": {
                        "prefix": "--replicons"
                    },
                    "type": [
                        "null",
                        "File"
                    ]
                },
                {
                    "doc": "Genbank/GFF3 file of trusted regions for pre-detected feature coordinates",
                    "id": "#bakta.cwl/bakta/regions",
                    "inputBinding": {
                        "prefix": "--regions"
                    },
                    "type": [
                        "null",
                        "File"
                    ]
                },
                {
                    "doc": "Fasta file of trusted protein sequences for CDS annotation",
                    "id": "#bakta.cwl/bakta/proteins",
                    "inputBinding": {
                        "prefix": "--proteins"
                    },
                    "type": [
                        "null",
                        "File"
                    ]
                },
                {
                    "doc": "Run in metagenome mode",
                    "id": "#bakta.cwl/bakta/meta",
                    "inputBinding": {
                        "prefix": "--meta"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Skip tRNA detection & annotation",
                    "id": "#bakta.cwl/bakta/skip_tRNA",
                    "inputBinding": {
                        "prefix": "--skip-trna"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Skip tmRNA detection & annotation",
                    "id": "#bakta.cwl/bakta/skip_tmrna",
                    "inputBinding": {
                        "prefix": "--skip-tmrna"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Skip rRNA detection & annotation",
                    "id": "#bakta.cwl/bakta/skip_rrna",
                    "inputBinding": {
                        "prefix": "--skip-rrna"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Skip ncRNA detection & annotation",
                    "id": "#bakta.cwl/bakta/skip_ncrna",
                    "inputBinding": {
                        "prefix": "--skip-ncrna"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Skip ncRNA region detection & annotation",
                    "id": "#bakta.cwl/bakta/skip_ncrna_region",
                    "inputBinding": {
                        "prefix": "--skip-ncrna-region"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Skip CRISPR detection & annotation",
                    "id": "#bakta.cwl/bakta/skip_crispr",
                    "inputBinding": {
                        "prefix": "--skip-crispr"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Skip CDS detection & annotation",
                    "id": "#bakta.cwl/bakta/skip_cds",
                    "inputBinding": {
                        "prefix": "--skip-cds"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Skip Pseudogene detection & annotation",
                    "id": "#bakta.cwl/bakta/skip_pseudo",
                    "inputBinding": {
                        "prefix": "--skip-pseudo"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Skip sORF detection & annotation",
                    "id": "#bakta.cwl/bakta/skip_sorf",
                    "inputBinding": {
                        "prefix": "--skip-sorf"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Skip gap detection & annotation",
                    "id": "#bakta.cwl/bakta/skip_gap",
                    "inputBinding": {
                        "prefix": "--skip-gap"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Skip ori detection & annotation",
                    "id": "#bakta.cwl/bakta/skip_ori",
                    "inputBinding": {
                        "prefix": "--skip-ori"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Skip genome plotting",
                    "id": "#bakta.cwl/bakta/skip_plot",
                    "inputBinding": {
                        "prefix": "--skip-plot"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Print verbose information",
                    "id": "#bakta.cwl/bakta/verbose",
                    "inputBinding": {
                        "prefix": "--verbose"
                    },
                    "default": true,
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Run Bakta in debug mode",
                    "id": "#bakta.cwl/bakta/debug",
                    "inputBinding": {
                        "prefix": "--debug"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Threads",
                    "id": "#bakta.cwl/bakta/threads",
                    "inputBinding": {
                        "prefix": "--threads"
                    },
                    "type": [
                        "null",
                        "int"
                    ]
                },
                {
                    "doc": "Directory for temporary files (default = system dependent auto detection)",
                    "id": "#bakta.cwl/bakta/tmp_dir",
                    "inputBinding": {
                        "prefix": "--tmp-dir"
                    },
                    "type": [
                        "null",
                        "Directory"
                    ]
                }
            ],
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0003-4216-2721",
                    "https://schema.org/email": "mailto:oliver.schwengers@computational.bio.uni-giessen.de",
                    "https://schema.org/name": "Oliver Schwengers"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateCreated": "2020-00-00",
            "https://schema.org/dateModified": "2024-07-08",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential",
            "outputs": [
                {
                    "doc": "Hypothetical CDS AA sequences as Fasta",
                    "id": "#bakta.cwl/bakta/hypo_sequences_cds",
                    "type": "File",
                    "format": "http://edamontology.org/format_2200",
                    "outputBinding": {
                        "glob": "*.hypotheticals.faa"
                    }
                },
                {
                    "doc": "Information on hypothetical CDS as TSV",
                    "id": "#bakta.cwl/bakta/hypo_annotation_tsv",
                    "type": "File",
                    "format": "http://edamontology.org/format_3475",
                    "outputBinding": {
                        "glob": "*.hypotheticals.tsv"
                    }
                },
                {
                    "doc": "Annotation as TSV",
                    "id": "#bakta.cwl/bakta/annotation_tsv",
                    "type": "File",
                    "format": "http://edamontology.org/format_3475",
                    "outputBinding": {
                        "glob": "${ if (inputs.prefix !== null) { return inputs.prefix + '.tsv'; } else{ return inputs.fasta_file.basename.replace(/\\.[^/.]+$/, '') + '.tsv'; } }"
                    }
                },
                {
                    "doc": "Annotation summary as txt",
                    "id": "#bakta.cwl/bakta/summary_txt",
                    "type": "File",
                    "format": "http://edamontology.org/format_2330",
                    "outputBinding": {
                        "glob": "*.txt"
                    }
                },
                {
                    "doc": "Annotation as JSON",
                    "id": "#bakta.cwl/bakta/annotation_json",
                    "type": "File",
                    "format": "http://edamontology.org/format_3464",
                    "outputBinding": {
                        "glob": "*.json"
                    }
                },
                {
                    "doc": "Annotation as GFF3",
                    "id": "#bakta.cwl/bakta/annotation_gff3",
                    "type": "File",
                    "format": "http://edamontology.org/format_1939",
                    "outputBinding": {
                        "glob": "*.gff3"
                    }
                },
                {
                    "doc": "Annotation as GenBank",
                    "id": "#bakta.cwl/bakta/annotation_gbff",
                    "type": "File",
                    "format": "http://edamontology.org/format_1936",
                    "outputBinding": {
                        "glob": "*.gbff"
                    }
                },
                {
                    "doc": "Annotation as EMBL",
                    "id": "#bakta.cwl/bakta/annotation_embl",
                    "type": "File",
                    "format": "http://edamontology.org/format_1927",
                    "outputBinding": {
                        "glob": "*.embl"
                    }
                },
                {
                    "doc": "Genome Sequences as Fasta",
                    "id": "#bakta.cwl/bakta/sequences_fna",
                    "type": "File",
                    "format": "http://edamontology.org/format_2200",
                    "outputBinding": {
                        "glob": "*.fna"
                    }
                },
                {
                    "doc": "Gene DNA sequences as Fasta",
                    "id": "#bakta.cwl/bakta/sequences_ffn",
                    "type": "File",
                    "format": "http://edamontology.org/format_2200",
                    "outputBinding": {
                        "glob": "*.ffn"
                    }
                },
                {
                    "doc": "CDS AA sequences as Fasta",
                    "id": "#bakta.cwl/bakta/sequences_cds",
                    "type": "File",
                    "format": "http://edamontology.org/format_2200",
                    "outputBinding": {
                        "glob": "${ if (inputs.prefix !== null) { return inputs.prefix + '.faa'; } else{ return inputs.fasta_file.basename.replace(/\\.[^/.]+$/, '') + '.faa'; } }"
                    }
                },
                {
                    "doc": "Circular genome plot as PNG",
                    "id": "#bakta.cwl/bakta/plot_png",
                    "type": [
                        "null",
                        "File"
                    ],
                    "format": "http://edamontology.org/format_3603",
                    "outputBinding": {
                        "glob": "*.png"
                    }
                },
                {
                    "doc": "Circular genome plot as SVG",
                    "id": "#bakta.cwl/bakta/plot_svg",
                    "type": [
                        "null",
                        "File"
                    ],
                    "format": "http://edamontology.org/format_3604",
                    "outputBinding": {
                        "glob": "*.svg"
                    }
                }
            ]
        },
        {
            "class": "CommandLineTool",
            "label": "Compress a directory (tar)",
            "hints": [
                {
                    "dockerPull": "debian:buster",
                    "class": "DockerRequirement"
                }
            ],
            "baseCommand": [
                "tar",
                "czfh"
            ],
            "arguments": [
                {
                    "valueFrom": "$(inputs.indir.basename).tar.gz"
                },
                {
                    "valueFrom": "-C"
                },
                {
                    "valueFrom": "$(inputs.indir.path)/.."
                },
                {
                    "valueFrom": "$(inputs.indir.basename)"
                }
            ],
            "inputs": [
                {
                    "type": "Directory",
                    "id": "#compress_directory.cwl/indir"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.indir.basename).tar.gz"
                    },
                    "id": "#compress_directory.cwl/outfile"
                }
            ],
            "id": "#compress_directory.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateModified": "2024-10-07",
            "https://schema.org/dateCreated": "2021-00-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "compress a file multithreaded with pigz",
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/pigz:2.8",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "2.8"
                            ],
                            "specs": [
                                "https://anaconda.org/conda-forge/pigz"
                            ],
                            "package": "pigz"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "pigz",
                "-c"
            ],
            "arguments": [
                {
                    "valueFrom": "$(inputs.inputfile)"
                }
            ],
            "stdout": "$(inputs.inputfile.basename).gz",
            "inputs": [
                {
                    "type": "File",
                    "id": "#pigz.cwl/inputfile"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 1,
                    "inputBinding": {
                        "prefix": "-p"
                    },
                    "id": "#pigz.cwl/threads"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.inputfile.basename).gz"
                    },
                    "id": "#pigz.cwl/outfile"
                }
            ],
            "id": "#pigz.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateModified": "2024-10-07",
            "https://schema.org/dateCreated": "2020-00-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "Binette",
            "doc": "Binette is a fast and accurate binning refinement tool designed to construct high-quality MAGs from the output of multiple binning tools.\nThe docker image contains the already downloaded checkm2 database.\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/binette:1.1.2_uniref100",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "1.1.2"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/binette",
                                "https://doi.org/10.21105/joss.06782"
                            ],
                            "package": "binette"
                        },
                        {
                            "version": [
                                "1.1.0"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/checkm2",
                                "https://doi.org/10.1038/s41592-020-00923-9"
                            ],
                            "package": "checkm2"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "binette"
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "Directory"
                        }
                    ],
                    "doc": "Array of bin folders containing each bin in a fasta file.",
                    "label": "Bins directories",
                    "inputBinding": {
                        "prefix": "--bin_dirs"
                    },
                    "id": "#binette.cwl/bins_dirs"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "doc": "CheckM2 database location. Optional when using the container image, it has the database already downloaded.",
                    "label": "CheckM2 database",
                    "inputBinding": {
                        "prefix": "--checkm2_db"
                    },
                    "id": "#binette.cwl/checkm2_db"
                },
                {
                    "type": "float",
                    "doc": "Bin are scored as follow; completeness - weight * contamination. A low contamination_weight favor complete bins over low contaminated bins. Default 2",
                    "label": "Contamination weight",
                    "inputBinding": {
                        "prefix": "--contamination_weight"
                    },
                    "default": 2.0,
                    "id": "#binette.cwl/contamination_weight"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "List of contig2bin table with two columns separated with a tabulation; contig, bin",
                    "label": "Contig2Bin table",
                    "inputBinding": {
                        "prefix": "--contig2bin_tables"
                    },
                    "id": "#binette.cwl/contig2bin_tables"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "Contigs in fasta format.",
                    "label": "Contigs",
                    "inputBinding": {
                        "prefix": "--contigs"
                    },
                    "id": "#binette.cwl/contigs"
                },
                {
                    "type": "boolean",
                    "doc": "Debug output. Default false",
                    "label": "Debug",
                    "inputBinding": {
                        "prefix": "--debug"
                    },
                    "default": false,
                    "id": "#binette.cwl/debug"
                },
                {
                    "type": "boolean",
                    "doc": "Use low mem mode when running diamond. Defaullt false",
                    "label": "Low memory",
                    "inputBinding": {
                        "prefix": "--low_mem"
                    },
                    "default": false,
                    "id": "#binette.cwl/low_mem"
                },
                {
                    "type": "int",
                    "doc": "Minimum completeness required for final bin selections. Default 40",
                    "label": "Minimum completeness",
                    "inputBinding": {
                        "prefix": "--min_completeness"
                    },
                    "default": 40,
                    "id": "#binette.cwl/min_completeness"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "FASTA file of predicted proteins in Prodigal format",
                    "label": "Proteins",
                    "inputBinding": {
                        "prefix": "--proteins"
                    },
                    "id": "#binette.cwl/proteins"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "doc": "Maximum threads to use. Default 1",
                    "label": "Threads",
                    "inputBinding": {
                        "prefix": "--threads"
                    },
                    "default": 1,
                    "id": "#binette.cwl/threads"
                },
                {
                    "type": "boolean",
                    "doc": "Verbose output. Default false",
                    "label": "Verbose",
                    "inputBinding": {
                        "prefix": "--verbose"
                    },
                    "default": false,
                    "id": "#binette.cwl/verbose"
                }
            ],
            "outputs": [
                {
                    "type": "Directory",
                    "doc": "This directory stores all the selected bins in fasta format.",
                    "outputBinding": {
                        "glob": "results/final_bins"
                    },
                    "id": "#binette.cwl/final_bins"
                },
                {
                    "type": "File",
                    "doc": "This is a TSV (tab-separated values) file containing quality information about the final selected bins.",
                    "outputBinding": {
                        "glob": "results/final_bins_quality_reports.tsv"
                    },
                    "id": "#binette.cwl/final_bins_quality_report"
                },
                {
                    "type": "Directory",
                    "doc": "A directory storing quality reports for the input bin sets, with files following the same structure as final_bins_quality_reports.tsv",
                    "outputBinding": {
                        "glob": "results/input_bins_quality_reports"
                    },
                    "id": "#binette.cwl/input_bins_quality_reports"
                }
            ],
            "id": "#binette.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateModified": "2025-09-02",
            "https://schema.org/dateCreated": "2025-05-02",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "BUSCO",
            "doc": "Based on evolutionarily-informed expectations of gene content of near-universal single-copy orthologs, \nBUSCO metric is complementary to technical metrics like N50.\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "networkAccess": "$(inputs.busco_data !== undefined)",
                    "class": "NetworkAccess"
                }
            ],
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/busco:5.7.0--pyhdfd78af_1",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "5.7.0"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/busco",
                                "file:///home/bart/git/cwl/tools/busco/doi.org/10.1093/molbev/msab199"
                            ],
                            "package": "busco"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "busco"
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "label": "Auto-lineage detection",
                    "doc": "Run auto-lineage to find optimum lineage path",
                    "inputBinding": {
                        "prefix": "--auto-lineage"
                    },
                    "id": "#busco.cwl/auto-lineage"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "label": "Eukaryote auto-lineage detection",
                    "doc": "Run auto-placement just on eukaryote tree to find optimum lineage path.",
                    "inputBinding": {
                        "prefix": "--auto-lineage-euk"
                    },
                    "id": "#busco.cwl/auto-lineage-euk"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "label": "Prokaryote auto-lineage detection",
                    "doc": "Run auto-lineage just on non-eukaryote trees to find optimum lineage path.",
                    "inputBinding": {
                        "prefix": "--auto-lineage-prok"
                    },
                    "id": "#busco.cwl/auto-lineage-prok"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "label": "Dataset location",
                    "doc": "This assumes --offline mode. Specify local filepath for finding BUSCO dataset downloads",
                    "inputBinding": {
                        "prefix": "--download_path"
                    },
                    "id": "#busco.cwl/busco_data"
                },
                {
                    "type": "string",
                    "label": "Name of the output file",
                    "doc": "Give your analysis run a recognisable short name. Output folders and files will be labelled with this name.",
                    "inputBinding": {
                        "prefix": "--out"
                    },
                    "id": "#busco.cwl/identifier"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "Lineage",
                    "doc": "Specify the name of the BUSCO lineage to be used.",
                    "inputBinding": {
                        "prefix": "--lineage_dataset"
                    },
                    "id": "#busco.cwl/lineage"
                },
                {
                    "type": "string",
                    "label": "Input molecule type",
                    "doc": "Specify which BUSCO analysis mode to run.\nThere are three valid modes:\n- geno or genome, for genome assemblies (DNA)\n- tran or transcriptome, for transcriptome assemblies (DNA)\n- prot or proteins, for annotated gene sets (protein)\n",
                    "inputBinding": {
                        "prefix": "--mode"
                    },
                    "id": "#busco.cwl/mode"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "Input fasta file",
                    "doc": "Input sequence file in FASTA format. Can be an assembled genome or transcriptome (DNA), or protein sequences from an annotated gene set. Also possible to use a path to a directory containing multiple input files.",
                    "inputBinding": {
                        "prefix": "--in"
                    },
                    "id": "#busco.cwl/sequence_file"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "label": "Input folder",
                    "doc": "Input folder with sequence files in FASTA format. Can be an assembled genome or transcriptome (DNA), or protein sequences from an annotated gene set. Also possible to use a path to a directory containing multiple input files.",
                    "inputBinding": {
                        "prefix": "--in"
                    },
                    "id": "#busco.cwl/sequence_folder"
                },
                {
                    "type": "boolean",
                    "label": "Skip BBTools",
                    "doc": "Skip BBTools steps",
                    "default": false,
                    "inputBinding": {
                        "prefix": "--skip_bbtools"
                    },
                    "id": "#busco.cwl/skip_bbtools"
                },
                {
                    "type": "boolean",
                    "label": "Compress output",
                    "doc": "Compress some subdirectories with many files to save space",
                    "default": true,
                    "inputBinding": {
                        "prefix": "--tar"
                    },
                    "id": "#busco.cwl/tar_output"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Number of threads",
                    "default": 1,
                    "inputBinding": {
                        "prefix": "--cpu"
                    },
                    "id": "#busco.cwl/threads"
                }
            ],
            "arguments": [
                "${\n  if (inputs.busco_data){\n    return '--offline';\n  } else {\n    return null;\n  }\n}\n"
            ],
            "outputs": [
                {
                    "label": "Batch summary",
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "Summary file when input is multiple files",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)/batch_summary.txt",
                        "outputEval": "${self[0].basename=inputs.identifier+\"_batch_summary.txt\"; return self;}"
                    },
                    "id": "#busco.cwl/batch_summary"
                },
                {
                    "label": "BUSCO logs folder",
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.identifier)/logs"
                    },
                    "id": "#busco.cwl/logs"
                },
                {
                    "label": "BUSCO short summary files",
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.identifier)/short_summary.*"
                    },
                    "id": "#busco.cwl/short_summaries"
                }
            ],
            "id": "#busco.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0002-5516-8391",
                    "https://schema.org/email": "mailto:german.royvalgarcia@wur.nl",
                    "https://schema.org/name": "Germ\u00e1n Royval"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateCreated": "2022-01-01",
            "https://schema.org/dateModified": "2025-08-28",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "CoverM",
            "doc": "CoverM calculates coverage of genomes/MAGs coverm genome or individual contigs coverm contig. \nCalculating coverage by read mapping, its input can either be BAM files sorted by reference, or raw reads and reference genomes in various formats.\n\nCurrently only bam files and genome directory input is implemented in this CWL.\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/coverm:0.7.0--hcb7b614_4",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "0.7.0"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/coverm",
                                "https://doi.org/10.1093/bioinformatics/btaf147"
                            ],
                            "package": "coverm"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "coverm",
                "genome"
            ],
            "inputs": [
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "label": "BAM files",
                    "doc": "Path to BAM file(s). These must be reference sorted (e.g. with samtools sort).\n",
                    "inputBinding": {
                        "prefix": "--bam-files"
                    },
                    "id": "#coverm_genome.cwl/bam_files"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "label": "Genome fasta directory",
                    "doc": "Directory containing genome fasta files",
                    "inputBinding": {
                        "prefix": "--genome-fasta-directory"
                    },
                    "id": "#coverm_genome.cwl/genome_fasta_directory"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "doc": "File extension of genomes in the directory specified with genome-fasta-directory. (default; fna)",
                    "label": "Genome fasta extension",
                    "inputBinding": {
                        "prefix": "--genome-fasta-extension"
                    },
                    "id": "#coverm_genome.cwl/genome_fasta_extension"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "label": "Genome files",
                    "doc": "Path to genome file(s) in fasta format.",
                    "inputBinding": {
                        "prefix": "--genome-fasta-files"
                    },
                    "id": "#coverm_genome.cwl/genome_fasta_files"
                },
                {
                    "type": "string",
                    "doc": "Identifier for this dataset used in this workflow",
                    "label": "identifier used",
                    "id": "#coverm_genome.cwl/identifier"
                },
                {
                    "type": [
                        {
                            "type": "enum",
                            "symbols": [
                                "#coverm_genome.cwl/method/relative_abundance",
                                "#coverm_genome.cwl/method/mean",
                                "#coverm_genome.cwl/method/trimmed_mean",
                                "#coverm_genome.cwl/method/coverage_histogram",
                                "#coverm_genome.cwl/method/covered_bases",
                                "#coverm_genome.cwl/method/length",
                                "#coverm_genome.cwl/method/count",
                                "#coverm_genome.cwl/method/reads_per_base",
                                "#coverm_genome.cwl/method/anir",
                                "#coverm_genome.cwl/method/rpkm",
                                "#coverm_genome.cwl/method/tpm"
                            ]
                        }
                    ],
                    "doc": "Method to calculate coverage (default; relative_abundance)",
                    "label": "Method to calculate coverage",
                    "default": "relative_abundance",
                    "inputBinding": {
                        "prefix": "--methods"
                    },
                    "id": "#coverm_genome.cwl/method"
                },
                {
                    "type": [
                        "null",
                        "float"
                    ],
                    "doc": "Genomes with less covered bases than this are reported as having zero coverage.(default; 10)",
                    "label": "Minimum covered fraction",
                    "default": 10,
                    "inputBinding": {
                        "prefix": "--min-covered-fraction"
                    },
                    "id": "#coverm_genome.cwl/min_covered_fraction"
                }
            ],
            "stdout": "coverm.tsv",
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "coverm.tsv",
                        "outputEval": "${self[0].basename=inputs.identifier+\"_coverm.tsv\"; return self;}"
                    },
                    "id": "#coverm_genome.cwl/coverm_tsv"
                }
            ],
            "id": "#coverm_genome.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateModified": "2025-09-03",
            "https://schema.org/dateCreated": "2025-09-03",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "eggNOG",
            "doc": "eggNOG is a public resource that provides Orthologous Groups (OGs)\nof proteins at different taxonomic levels, each with integrated and summarized functional annotations.\n",
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/eggnog-mapper:2.1.12--pyhdfd78af_0",
                    "class": "DockerRequirement"
                },
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "2.1.12"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/eggnog-mapper",
                                "https://doi.org/10.1101/2021.06.03.446934"
                            ],
                            "package": "eggnog"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "emapper.py"
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--cpu"
                    },
                    "default": 4,
                    "id": "#eggnog-mapper.cwl/cpu"
                },
                {
                    "type": "boolean",
                    "inputBinding": {
                        "prefix": "--dbmem"
                    },
                    "doc": "Use this option to allocate the whole eggnog.db DB in memory. Database will be unloaded after execution. (default false)",
                    "default": false,
                    "id": "#eggnog-mapper.cwl/dbmem"
                },
                {
                    "type": [
                        {
                            "type": "record",
                            "name": "#eggnog-mapper.cwl/eggnog_dbs/eggnog",
                            "fields": [
                                {
                                    "type": "Directory",
                                    "inputBinding": {
                                        "prefix": "--data_dir"
                                    },
                                    "doc": "Directory containing all data files for the eggNOG database.",
                                    "name": "#eggnog-mapper.cwl/eggnog_dbs/eggnog/data_dir"
                                },
                                {
                                    "type": "File",
                                    "inputBinding": {
                                        "prefix": "--database"
                                    },
                                    "doc": "eggNOG database file",
                                    "name": "#eggnog-mapper.cwl/eggnog_dbs/eggnog/db"
                                },
                                {
                                    "type": "File",
                                    "inputBinding": {
                                        "prefix": "--dmnd_db"
                                    },
                                    "doc": "eggNOG database file for diamond blast search",
                                    "name": "#eggnog-mapper.cwl/eggnog_dbs/eggnog/diamond_db"
                                }
                            ]
                        }
                    ],
                    "id": "#eggnog-mapper.cwl/eggnog_dbs"
                },
                {
                    "type": [
                        {
                            "type": "enum",
                            "symbols": [
                                "#eggnog-mapper.cwl/go_evidence/experimental",
                                "#eggnog-mapper.cwl/go_evidence/non-electronic",
                                "#eggnog-mapper.cwl/go_evidence/all"
                            ],
                            "inputBinding": {
                                "prefix": "--go_evidence"
                            }
                        }
                    ],
                    "default": "non-electronic",
                    "doc": "Defines what type of GO terms should be used for annotation. \nexperimental = Use only terms inferred from experimental evidence. \nnon-electronic = Use only non-electronically curated terms.\nDefault non-electronic.\n",
                    "id": "#eggnog-mapper.cwl/go_evidence"
                },
                {
                    "type": "File",
                    "inputBinding": {
                        "separate": true,
                        "prefix": "-i"
                    },
                    "label": "Input FASTA file containing protein sequences",
                    "id": "#eggnog-mapper.cwl/input_fasta"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "enum",
                            "symbols": [
                                "#eggnog-mapper.cwl/mode/diamond",
                                "#eggnog-mapper.cwl/mode/hmmer"
                            ],
                            "inputBinding": {
                                "prefix": "-m"
                            }
                        }
                    ],
                    "default": "diamond",
                    "doc": "Run with hmmer or diamond. Default diamond",
                    "id": "#eggnog-mapper.cwl/mode"
                }
            ],
            "arguments": [
                {
                    "position": 2,
                    "prefix": "--annotate_hits_table",
                    "valueFrom": "$(inputs.input_fasta.nameroot)"
                },
                {
                    "position": 3,
                    "prefix": "-o",
                    "valueFrom": "$(inputs.input_fasta.nameroot)"
                }
            ],
            "outputs": [
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "format": "http://edamontology.org/format_3475",
                    "outputBinding": {
                        "glob": "$(inputs.input_fasta.nameroot)*annotations*"
                    },
                    "id": "#eggnog-mapper.cwl/output_annotations"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "format": "http://edamontology.org/format_3475",
                    "outputBinding": {
                        "glob": "$(inputs.input_fasta.nameroot)*orthologs*"
                    },
                    "id": "#eggnog-mapper.cwl/output_orthologs"
                }
            ],
            "id": "#eggnog-mapper.cwl",
            "http://schema.org/author": [
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "http://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "http://schema.org/name": "Changlin Ke"
                },
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/author": "Ekaterina Sakharova"
                },
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "http://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "http://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "http://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "http://schema.org/name": "Bart Nijsse"
                }
            ],
            "http://schema.org/copyrightHolder": "EMBL - European Bioinformatics Institute",
            "http://schema.org/license": "https://www.apache.org/licenses/LICENSE-2.0",
            "http://schema.org/dateCreated": "2019-06-14",
            "http://schema.org/dateModified": "2024-10-03"
        },
        {
            "class": "CommandLineTool",
            "label": "EukRep",
            "doc": "EukRep, Classification of Eukaryotic and Prokaryotic sequences from metagenomic datasets",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/eukrep:0.6.7",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "0.6.7"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/eukrep",
                                "file:///home/bart/git/cwl/tools/eukrep/doi.org/10.1101/171355"
                            ],
                            "package": "diamond"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "EukRep"
            ],
            "inputs": [
                {
                    "type": "File",
                    "doc": "Input assembly in fasta format",
                    "label": "Input assembly",
                    "inputBinding": {
                        "prefix": "-i"
                    },
                    "id": "#eukrep.cwl/assembly"
                },
                {
                    "type": "string",
                    "doc": "Identifier for this dataset used in this workflow",
                    "label": "identifier used",
                    "id": "#eukrep.cwl/identifier"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "Minumum contig length",
                    "doc": "Minimum sequence length cutoff for sequences to be included in prediction. Default is 3kb",
                    "id": "#eukrep.cwl/min_contig_size"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "doc": "{strict,balanced,lenient} Default is balanced.\nHow stringent the algorithm is in identifying eukaryotic scaffolds. Strict has a lower false positive rate and true positive rate; vice verso for leneient.\n",
                    "label": "Algorithm stringency",
                    "inputBinding": {
                        "prefix": "-m"
                    },
                    "id": "#eukrep.cwl/stringency"
                }
            ],
            "arguments": [
                {
                    "prefix": "-o",
                    "valueFrom": "$(inputs.identifier)_eukrep.fasta"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_eukrep.fasta"
                    },
                    "id": "#eukrep.cwl/euk_fasta_out"
                }
            ],
            "id": "#eukrep.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateModified": "2024-05-30",
            "https://schema.org/dateCreated": "2022-06-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "ExpressionTool",
            "doc": "Transforms the input files to a mentioned directory\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "inputs": [
                {
                    "type": "string",
                    "id": "#files_to_folder.cwl/destination"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "id": "#files_to_folder.cwl/files"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "Directory"
                        }
                    ],
                    "id": "#files_to_folder.cwl/folders"
                }
            ],
            "expression": "${\n  var array = []\n  if (inputs.files != null) {\n    array = array.concat(inputs.files)\n  }\n  if (inputs.folders != null) {\n    array = array.concat(inputs.folders)\n  }\n  var r = {\n     'results':\n       { \"class\": \"Directory\",\n         \"basename\": inputs.destination,\n         \"listing\": array\n       } \n     };\n   return r; \n }\n",
            "outputs": [
                {
                    "type": "Directory",
                    "id": "#files_to_folder.cwl/results"
                }
            ],
            "id": "#files_to_folder.cwl",
            "http://schema.org/citation": "https://m-unlock.nl",
            "http://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "http://schema.org/dateModified": "2024-10-07",
            "http://schema.org/dateCreated": "2020-00-00",
            "http://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "http://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "ExpressionTool",
            "doc": "Expression to filter files (by name) in a directory using a regular expression.\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "loadListing": "shallow_listing",
                    "class": "LoadListingRequirement"
                }
            ],
            "inputs": [
                {
                    "type": "boolean",
                    "label": "Reverse",
                    "doc": "Exclude files with regex. (default false)",
                    "default": false,
                    "id": "#folder_file_regex.cwl/exclude"
                },
                {
                    "label": "Input folder",
                    "doc": "Folder with only files",
                    "type": "Directory",
                    "id": "#folder_file_regex.cwl/folder"
                },
                {
                    "type": "boolean",
                    "label": "Output as folder",
                    "doc": "Output files in folder when true. (default false)",
                    "default": false,
                    "id": "#folder_file_regex.cwl/output_as_folder"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "Output folder name",
                    "doc": "Output folder name. When output folder is true. (default 'filtered')",
                    "default": "filtered",
                    "id": "#folder_file_regex.cwl/output_folder_name"
                },
                {
                    "label": "Regex (JS)",
                    "doc": "JavaScript regular expression to be used on the filenames\nMetaBAT2 example: \"bin\\.[0-9]+\\.fa\"\n",
                    "type": "string",
                    "id": "#folder_file_regex.cwl/regex"
                }
            ],
            "expression": "${\n  var regex = new RegExp(inputs.regex);\n  var array = [];\n  if (inputs.exclude == false) {\n    for (var i = 0; i < inputs.folder.listing.length; i++) {\n      if (regex.test(inputs.folder.listing[i].location)){\n        array = array.concat(inputs.folder.listing[i]);\n      }\n    }\n  } else {\n    for (var i = 0; i < inputs.folder.listing.length; i++) {\n      if (!regex.test(inputs.folder.listing[i].location)){\n        array = array.concat(inputs.folder.listing[i]);\n      }  \n    }    \n  }\n  if (inputs.output_as_folder) {\n        var r = {\n     'output_folder':\n       { \"class\": \"Directory\",\n         \"basename\": inputs.output_folder_name,\n         \"listing\": array\n       }\n     };\n  } else {\n    r = array;\n  }\n   return r;\n}\n",
            "outputs": [
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "id": "#folder_file_regex.cwl/output_files"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "id": "#folder_file_regex.cwl/output_folder"
                }
            ],
            "id": "#folder_file_regex.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateCreated": "2022-10-00",
            "https://schema.org/dateModified": "2022-10-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "ExpressionTool",
            "doc": "Transforms the input folder to an array of files\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "loadListing": "shallow_listing",
                    "class": "LoadListingRequirement"
                }
            ],
            "inputs": [
                {
                    "type": "Directory",
                    "id": "#folder_to_files.cwl/folder"
                }
            ],
            "expression": "${\n  var files = [];\n  for (var i = 0; i < inputs.folder.listing.length; i++) {\n    files.push(inputs.folder.listing[i]);\n  }\n  return {\"files\": files};\n}  \n",
            "outputs": [
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "id": "#folder_to_files.cwl/files"
                }
            ],
            "id": "#folder_to_files.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateModified": "2024-10-07",
            "https://schema.org/dateCreated": "2022-10-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "ExpressionTool",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "label": "Merge file arrays",
            "doc": "Merges arrays of files in an array to a array of files\n",
            "inputs": [
                {
                    "type": {
                        "type": "array",
                        "items": {
                            "type": "array",
                            "items": "File"
                        }
                    },
                    "id": "#merge_file_arrays.cwl/input"
                }
            ],
            "outputs": [
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "id": "#merge_file_arrays.cwl/output"
                }
            ],
            "expression": "${\n  var output = [];\n  for (var i = 0; i < inputs.input.length; i++) {\n    var readgroup_array = inputs.input[i];\n    for (var j = 0; j < readgroup_array.length; j++) {\n      var readgroup = readgroup_array[j];\n      output.push(readgroup);\n    }\n  }\n  return {'output': output}\n}",
            "id": "#merge_file_arrays.cwl"
        },
        {
            "class": "CommandLineTool",
            "label": "GTDBTK Classify Workflow",
            "doc": "Taxonomic genome classification workflow with GTDBTK. \n",
            "baseCommand": [
                "bash",
                "script.sh"
            ],
            "requirements": [
                {
                    "listing": [
                        {
                            "entryname": "script.sh",
                            "entry": "#!/bin/bash\nexport GTDBTK_DATA_PATH=$1\nshift;\ngtdbtk classify_wf $@"
                        }
                    ],
                    "class": "InitialWorkDirRequirement"
                },
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/gtdbtk:2.4.0--pyhdfd78af_1",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "2.4.0"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/gtdbtk",
                                "file:///home/bart/git/cwl/tools/gtdbtk/doi.org/10.1093/bioinformatics/btac672"
                            ],
                            "package": "gtdbtk"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "inputs": [
                {
                    "type": "Directory",
                    "doc": "Directory containing bins in fasta format from metagenomic binning",
                    "label": "bins with directory",
                    "inputBinding": {
                        "position": 2,
                        "prefix": "--genome_dir"
                    },
                    "id": "#gtdbtk_classify_wf.cwl/bin_dir"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "fasta file extension",
                    "inputBinding": {
                        "position": 2,
                        "prefix": "--extension"
                    },
                    "default": "fa",
                    "id": "#gtdbtk_classify_wf.cwl/fasta_extension"
                },
                {
                    "type": "Directory",
                    "doc": "Directory containing the GTDBTK repository",
                    "label": "gtdbtk data directory",
                    "loadListing": "no_listing",
                    "inputBinding": {
                        "position": 1
                    },
                    "id": "#gtdbtk_classify_wf.cwl/gtdbtk_data"
                },
                {
                    "type": "string",
                    "doc": "Identifier for this dataset used in this workflow",
                    "label": "identifier used",
                    "id": "#gtdbtk_classify_wf.cwl/identifier"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "label": "skip ani screen, or specify a --mash_db location",
                    "inputBinding": {
                        "position": 2,
                        "prefix": "--skip_ani_screen"
                    },
                    "default": true,
                    "id": "#gtdbtk_classify_wf.cwl/skip_ani_screen"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Number of threads to use",
                    "default": 8,
                    "inputBinding": {
                        "position": 2,
                        "prefix": "--cpus"
                    },
                    "id": "#gtdbtk_classify_wf.cwl/threads"
                }
            ],
            "arguments": [
                {
                    "valueFrom": "--force",
                    "position": 10
                },
                {
                    "prefix": "--prefix",
                    "valueFrom": "$(inputs.identifier).gtdbtk",
                    "position": 11
                },
                {
                    "prefix": "--out_dir",
                    "position": 12,
                    "valueFrom": "$(inputs.identifier)_GTDB-Tk"
                }
            ],
            "stdout": "$(inputs.identifier)_GTDB-Tk.stdout.log",
            "outputs": [
                {
                    "type": "Directory",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_GTDB-Tk"
                    },
                    "id": "#gtdbtk_classify_wf.cwl/gtdbtk_out_folder"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_GTDB-Tk/classify/$(inputs.identifier).gtdbtk.bac120.summary.tsv"
                    },
                    "id": "#gtdbtk_classify_wf.cwl/gtdbtk_summary"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_GTDB-Tk.stdout.log"
                    },
                    "id": "#gtdbtk_classify_wf.cwl/stdout_out"
                }
            ],
            "id": "#gtdbtk_classify_wf.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateCreated": "2021-00-00",
            "https://schema.org/dateModified": "2022-02-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "InterProScan",
            "doc": "InterProScan is the software package that allows sequences to be scanned  against InterPro's signatures. Signatures are predictive models,  provided by several different databases, that make up the InterPro consortium.\nYou need to to download a copy of InterProScan v5 here:  https://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/\nBefore you run InterProScan 5 for the first time, you should run the command: > python3 setup.py -f interproscan.properties\nDocumentation on InterProScan can be found here: https://interproscan-docs.readthedocs.io",
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/interproscan_v5:base",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "5"
                            ],
                            "specs": [
                                "https://doi.org/10.1093/bioinformatics/btu031"
                            ],
                            "package": "interproscan"
                        },
                        {
                            "version": [
                                "21.0.2"
                            ],
                            "specs": [
                                "https://anaconda.org/conda-forge/openjdk"
                            ],
                            "package": "openjdk"
                        },
                        {
                            "version": [
                                "5.32"
                            ],
                            "specs": [
                                "https://anaconda.org/conda-forge/perl"
                            ],
                            "package": "perl"
                        },
                        {
                            "version": [
                                "3.12.2"
                            ],
                            "specs": [
                                "https://anaconda.org/conda-forge/python"
                            ],
                            "package": "python"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "networkAccess": true,
                    "class": "NetworkAccess"
                }
            ],
            "baseCommand": [
                "bash",
                "-x"
            ],
            "arguments": [
                {
                    "position": 1,
                    "valueFrom": "$(inputs.interproscan_directory.path)/interproscan.sh"
                },
                {
                    "prefix": "--output-file-base",
                    "position": 9,
                    "valueFrom": "$(inputs.protein_fasta.nameroot).interproscan"
                }
            ],
            "inputs": [
                {
                    "type": "string",
                    "inputBinding": {
                        "position": 4,
                        "prefix": "--applications"
                    },
                    "default": "Pfam,SFLD,SMART,AntiFam,NCBIfam",
                    "label": "Applications",
                    "doc": "Comma separated list of analyses:\nFunFam,SFLD,PANTHER,Gene3D,Hamap,PRINTS,ProSiteProfiles,Coils,SUPERFAMILY,SMART,CDD,PIRSR,ProSitePatterns,AntiFam,Pfam,MobiDBLite,PIRSF,NCBIfam\ndefault Pfam,SFLD,SMART,AntiFam,NCBIfam\n",
                    "id": "#interproscan_v5.cwl/applications"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "default": true,
                    "inputBinding": {
                        "position": 7,
                        "prefix": "--goterms"
                    },
                    "label": "GOterms",
                    "doc": "Lookup of corresponding Gene Ontology annotation (IMPLIES -iprlookup option). Default true",
                    "id": "#interproscan_v5.cwl/goterms"
                },
                {
                    "inputBinding": {
                        "position": 1
                    },
                    "type": "Directory",
                    "label": "IPR directory",
                    "doc": "InterProScan (full) program directory path",
                    "id": "#interproscan_v5.cwl/interproscan_directory"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "default": true,
                    "inputBinding": {
                        "position": 6,
                        "prefix": "--iprlookup"
                    },
                    "label": "IPR lookup",
                    "doc": "Also include lookup of corresponding InterPro annotation in the TSV and GFF3 output formats. Default true",
                    "id": "#interproscan_v5.cwl/ipr_lookup"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "default": "TSV,JSON",
                    "inputBinding": {
                        "position": 5,
                        "prefix": "--formats"
                    },
                    "label": "Output format",
                    "doc": "Optional, case-insensitive, comma separated list of output formats. Supported formats are TSV, XML, JSON, and GFF3. Default  JSON,TSV",
                    "id": "#interproscan_v5.cwl/output_formats"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "default": true,
                    "inputBinding": {
                        "position": 8,
                        "prefix": "--pathways"
                    },
                    "label": "Pathways",
                    "doc": "Lookup of corresponding Pathway annotation (IMPLIES -iprlookup option). Default true",
                    "id": "#interproscan_v5.cwl/pathways"
                },
                {
                    "type": "File",
                    "inputBinding": {
                        "position": 2,
                        "prefix": "--input"
                    },
                    "label": "Input protein fasta file path",
                    "id": "#interproscan_v5.cwl/protein_fasta"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 1,
                    "inputBinding": {
                        "position": 3,
                        "prefix": "--cpu"
                    },
                    "id": "#interproscan_v5.cwl/threads"
                }
            ],
            "outputs": [
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "*.gff3"
                    },
                    "id": "#interproscan_v5.cwl/gff3_annotations"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "*.json"
                    },
                    "id": "#interproscan_v5.cwl/json_annotations"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "*.tsv"
                    },
                    "id": "#interproscan_v5.cwl/tsv_annotations"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "*.xml"
                    },
                    "id": "#interproscan_v5.cwl/xml_annotations"
                }
            ],
            "id": "#interproscan_v5.cwl",
            "http://schema.org/author": [
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/author": "Michael Crusoe, Aleksandra Ola Tarkowska, Maxim Scheremetjew, Ekaterina Sakharova"
                },
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "http://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "http://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "http://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "http://schema.org/name": "Bart Nijsse"
                },
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "http://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "http://schema.org/name": "Changlin Ke"
                }
            ],
            "http://schema.org/copyrightHolder": "EMBL - European Bioinformatics Institute",
            "http://schema.org/license": "https://www.apache.org/licenses/LICENSE-2.0",
            "http://schema.org/dateCreated": "2019-06-14",
            "http://schema.org/dateModified": "2024-03-00",
            "http://schema.org/citation": "https://m-unlock.nl",
            "http://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl"
        },
        {
            "class": "CommandLineTool",
            "label": "KofamScan",
            "doc": "KofamScan / KofamKOALA assigns K numbers to the user's sequence data by HMMER/HMMSEARCH against KOfam, a customized HMM database of KEGG Orthologs (KOs). \nK number assignments with scores above the predefined thresholds for individual KOs are more reliable than other proposed assignments. \nSuch high score assignments are highlighted with asterisks '*' in the output. \nThe K number assignments facilitate the interpretation of the annotation results by linking the user's sequence data to the KEGG pathways and EC numbers..\n",
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/kofamscan:1.3.0-db.2024-01-01",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "3.2.1"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/hmmer",
                                "file:///home/bart/git/cwl/tools/kofamscan/doi.org/10.1093/nar/gkr367"
                            ],
                            "package": "hmmer"
                        },
                        {
                            "version": [
                                "1.3.0"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/kofamscan",
                                "file:///home/bart/git/cwl/tools/kofamscan/doi.org/10.1093/bioinformatics/btu031"
                            ],
                            "package": "kofamscan"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "baseCommand": [
                "exec_annotation"
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        {
                            "type": "enum",
                            "symbols": [
                                "#kofamscan.cwl/format/detail",
                                "#kofamscan.cwl/format/detail-tsv",
                                "#kofamscan.cwl/format/mapper",
                                "#kofamscan.cwl/format/mapper-one-line"
                            ],
                            "inputBinding": {
                                "prefix": "--format"
                            }
                        }
                    ],
                    "default": "detail-tsv",
                    "doc": "Format of the output. (default detail-tsv)\ndetail:          Detail for each hits (including hits below threshold)\ndetail-tsv:      Tab separeted values for detail format\nmapper:          KEGG Mapper compatible format\nmapper-one-line: Similar to mapper, but all hit KOs are listed in one line\n",
                    "id": "#kofamscan.cwl/format"
                },
                {
                    "type": "File",
                    "doc": "Protein sequences in fasta file format",
                    "label": "Protein fasta file",
                    "inputBinding": {
                        "position": 100
                    },
                    "id": "#kofamscan.cwl/input_fasta"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "id": "#kofamscan.cwl/ko_list"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "label": "Profile directory",
                    "doc": "Use a custom profile directory instead of the build-in version.",
                    "id": "#kofamscan.cwl/profile_directory"
                },
                {
                    "label": "Profile organism",
                    "type": [
                        "null",
                        "string"
                    ],
                    "doc": "Specify organism profile; 'eukaryote' and 'prokaryote' are valid choices for the build-in database. Takes the \".hal\" file in the profile directory with given name.",
                    "id": "#kofamscan.cwl/profile_organism"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 3,
                    "inputBinding": {
                        "prefix": "--cpu"
                    },
                    "id": "#kofamscan.cwl/threads"
                }
            ],
            "arguments": [
                {
                    "prefix": "-f",
                    "valueFrom": "detail-tsv"
                },
                {
                    "prefix": "-o",
                    "valueFrom": "$(inputs.input_fasta.nameroot).KofamKOALA.txt"
                },
                {
                    "prefix": "--profile",
                    "valueFrom": "${\n  // set profile organism subset (.hal) file\n  var po = \"\";\n  if (inputs.profile_organism){\n    po = \"/\"+inputs.profile_organism+\".hal\" ;\n  }\n  // check if custom profile directory is used\n  if (inputs.profile_directory){\n    return inputs.profile_directory.path+po\n  }\n  // else use default built-in kofam database\n  else { \n    return \"/profiles\"+po;\n  }\n}\n"
                },
                {
                    "prefix": "--ko-list",
                    "valueFrom": "${\n  if (inputs.ko_list){\n    return inputs.ko_list;\n  } else {\n    return '/ko_list';\n  }\n}\n"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.input_fasta.nameroot).KofamKOALA.txt"
                    },
                    "id": "#kofamscan.cwl/output"
                }
            ],
            "id": "#kofamscan.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                }
            ],
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateCreated": "2022-00-00",
            "https://schema.org/dateModified": "2024-03-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "MaxBin2",
            "doc": "MaxBin2 is a software for binning assembled metagenomic sequences based on an Expectation-Maximization algorithm.",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/maxbin2:2.2.7",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "2.2.7"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/maxbin2",
                                "file:///home/bart/git/cwl/tools/maxbin2/doi.org/10.1093/bioinformatics/btv638"
                            ],
                            "package": "maxbin2"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "run_MaxBin.pl"
            ],
            "inputs": [
                {
                    "type": "File",
                    "doc": "Abundances file",
                    "label": "Abundances",
                    "inputBinding": {
                        "prefix": "-abund"
                    },
                    "id": "#maxbin2.cwl/abundances"
                },
                {
                    "type": "File",
                    "doc": "Input assembly in fasta format",
                    "label": "Input assembly",
                    "inputBinding": {
                        "prefix": "-contig"
                    },
                    "id": "#maxbin2.cwl/contigs"
                },
                {
                    "type": "string",
                    "doc": "Identifier for this dataset used in this workflow",
                    "label": "identifier used",
                    "id": "#maxbin2.cwl/identifier"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Number of threads to use",
                    "default": 1,
                    "inputBinding": {
                        "position": 0,
                        "prefix": "-thread"
                    },
                    "id": "#maxbin2.cwl/threads"
                }
            ],
            "arguments": [
                {
                    "prefix": "-out",
                    "valueFrom": "$(inputs.identifier)_maxbin2.bin"
                }
            ],
            "stdout": "$(inputs.identifier)_maxbin2.log",
            "outputs": [
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "label": "Bins",
                    "doc": "Bin fasta files. The XX bin. XX are numbers, e.g. out.001.fasta",
                    "outputBinding": {
                        "glob": "*.fasta"
                    },
                    "id": "#maxbin2.cwl/bins"
                },
                {
                    "type": "File",
                    "label": "Log",
                    "doc": "Log file recording the core steps of MaxBin algorithm",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_maxbin2.log"
                    },
                    "id": "#maxbin2.cwl/log"
                },
                {
                    "type": "File",
                    "label": "Markers",
                    "doc": "Marker gene presence numbers for each bin. This table is ready to be plotted by R or other 3rd-party software.",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_maxbin2.bin.marker"
                    },
                    "id": "#maxbin2.cwl/markers"
                },
                {
                    "type": "File",
                    "label": "MaxBin2 Summary",
                    "doc": "Summary file describing which contigs are being classified into which bin.",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_maxbin2.bin.summary"
                    },
                    "id": "#maxbin2.cwl/summary"
                }
            ],
            "id": "#maxbin2.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateModified": "2025-05-30",
            "https://schema.org/dateCreated": "2022-08-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "MetaBAT2 binning",
            "doc": "Metagenome Binning based on Abundance and Tetranucleotide frequency (MetaBat2)\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/metabat2:2.15--h4da6f23_2",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "2.15"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/metabat2",
                                "file:///home/bart/git/cwl/tools/metabat2/doi.org/10.7717%2Fpeerj.7359"
                            ],
                            "package": "metabat2"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "metabat2"
            ],
            "arguments": [
                {
                    "prefix": "--outFile",
                    "valueFrom": "metabat2_bins/$(inputs.identifier)_metabat2_bin"
                }
            ],
            "inputs": [
                {
                    "type": "File",
                    "label": "The input assembly in fasta format",
                    "inputBinding": {
                        "position": 4,
                        "prefix": "--inFile"
                    },
                    "id": "#metabat2.cwl/assembly"
                },
                {
                    "type": "File",
                    "inputBinding": {
                        "position": 5,
                        "prefix": "--abdFile"
                    },
                    "id": "#metabat2.cwl/depths"
                },
                {
                    "type": "string",
                    "doc": "Identifier for this dataset used in this workflow",
                    "label": "identifier used",
                    "id": "#metabat2.cwl/identifier"
                },
                {
                    "type": "int",
                    "label": "Number of threads to use",
                    "default": 1,
                    "inputBinding": {
                        "position": 0,
                        "prefix": "--numThreads"
                    },
                    "id": "#metabat2.cwl/threads"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "doc": "Export unbinned contigs as fasta file",
                    "label": "Write unbinned",
                    "inputBinding": {
                        "prefix": "--unbinned"
                    },
                    "id": "#metabat2.cwl/write_unbinned"
                }
            ],
            "stdout": "$(inputs.identifier)_metabat2.log",
            "outputs": [
                {
                    "type": "Directory",
                    "label": "Bin directory",
                    "doc": "Bin directory",
                    "outputBinding": {
                        "glob": "metabat2_bins"
                    },
                    "id": "#metabat2.cwl/bin_dir"
                },
                {
                    "type": "File",
                    "label": "Log",
                    "doc": "MetaBat2 log file",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_metabat2.log"
                    },
                    "id": "#metabat2.cwl/log"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "Unbinned contigs",
                    "doc": "Unbinned contig fasta files",
                    "outputBinding": {
                        "glob": "metabat2_bins/$(inputs.identifier)_metabat2_bin.unbinned.fa"
                    },
                    "id": "#metabat2.cwl/unbinned"
                }
            ],
            "id": "#metabat2.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateModified": "2025-05-30",
            "https://schema.org/dateCreated": "2022-10-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "jgi_summarize_bam_contig_depths",
            "doc": "Summarize contig read depth from bam file for metabat2 binning.\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/metabat2:2.15--h4da6f23_2",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "2.15"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/metabat2",
                                "file:///home/bart/git/cwl/tools/metabat2/doi.org/10.7717%2Fpeerj.7359"
                            ],
                            "package": "metabat2"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "jgi_summarize_bam_contig_depths"
            ],
            "arguments": [
                {
                    "position": 1,
                    "prefix": "--outputDepth",
                    "valueFrom": "$(inputs.identifier)_contigdepths.tsv"
                }
            ],
            "inputs": [
                {
                    "type": "File",
                    "inputBinding": {
                        "position": 2
                    },
                    "id": "#metabatContigDepths.cwl/bamFile"
                },
                {
                    "type": "string",
                    "doc": "Name of the output file",
                    "label": "output file name",
                    "id": "#metabatContigDepths.cwl/identifier"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_contigdepths.tsv"
                    },
                    "id": "#metabatContigDepths.cwl/depths"
                }
            ],
            "id": "#metabatContigDepths.cwl",
            "http://schema.org/author": [
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "http://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "http://schema.org/name": "Bart Nijsse"
                },
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "http://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "http://schema.org/name": "Changlin Ke"
                },
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "http://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "http://schema.org/name": "Jasper Koehorst"
                }
            ],
            "http://schema.org/citation": "https://m-unlock.nl",
            "http://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "http://schema.org/dateModified": "2025-05-30",
            "http://schema.org/dateCreated": "2020-00-00",
            "http://schema.org/license": "https://spdx.org/licenses/CC0-1.0.html",
            "http://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "Bin read mapping stats",
            "doc": "Table of general read mapping statistics of the bins and assembly\n\nid\nreads\nassembly_size\ncontigs\nn50\nlargest_contig\nmapped reads (percentage)\nbins\ntotal_binned_size\nunbinned_size\nbinned (percentage)\nreads_mapped_to_bins (percentage)\nbinned_contigs\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/scripts:e197a628",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "0.23.2"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/pysam"
                            ],
                            "package": "pysam"
                        },
                        {
                            "version": [
                                "3.12.0"
                            ],
                            "specs": [
                                "https://anaconda.org/conda-forge/python"
                            ],
                            "package": "python3"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "python3",
                "/scripts/metagenomics/assembly_bins_readstats.py"
            ],
            "inputs": [
                {
                    "type": "File",
                    "doc": "BAM file with reads mapped to the assembly",
                    "label": "BAM file",
                    "inputBinding": {
                        "prefix": "--bam"
                    },
                    "id": "#assembly_bins_readstats.cwl/bam_file"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "doc": "Directory containing bins in fasta format from metagenomic binning",
                    "label": "Bins directory",
                    "inputBinding": {
                        "prefix": "--bin_dir"
                    },
                    "id": "#assembly_bins_readstats.cwl/bin_dir"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "doc": "Array of bin files in fasta format",
                    "label": "Bin files",
                    "inputBinding": {
                        "prefix": "--bin_files"
                    },
                    "id": "#assembly_bins_readstats.cwl/bin_files"
                },
                {
                    "type": "string",
                    "doc": "Identifier for this dataset used in this workflow",
                    "label": "identifier used",
                    "inputBinding": {
                        "prefix": "--identifier"
                    },
                    "id": "#assembly_bins_readstats.cwl/identifier"
                }
            ],
            "stdout": "$(inputs.identifier)_binning-stats.tsv",
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_binning-stats.tsv"
                    },
                    "id": "#assembly_bins_readstats.cwl/binReadStats"
                }
            ],
            "id": "#assembly_bins_readstats.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateModified": "2025-09-05",
            "https://schema.org/dateCreated": "2022-12-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "Bin summary",
            "doc": "Creates a summary table of the bins and their quality and taxonomy.\n\nColumns are:\nBin\nContigs\nSize\nLargest_contig\nN50\nGC\nRelative abundance\nGTDB-Tk_taxonomy\nBUSCO_Taxonomy\nBUSCO_score\nCheckM_Completeness\nCheckM_Contamination\nCheckM_Strain-heterogeneity    \n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/scripts:e197a628",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "2.2.2"
                            ],
                            "specs": [
                                "https://anaconda.org/conda-forge/pandas",
                                "file:///home/bart/git/cwl/tools/metagenomics/doi.org/10.5281/zenodo.3509134"
                            ],
                            "package": "pandas"
                        },
                        {
                            "version": [
                                "3.12.0"
                            ],
                            "specs": [
                                "https://anaconda.org/conda-forge/python"
                            ],
                            "package": "python3"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "python3",
                "/scripts/metagenomics/bins_summary.py"
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "doc": "Directory containing bins in fasta format from metagenomic binning",
                    "label": "Bins directory",
                    "inputBinding": {
                        "prefix": "--bin_dir"
                    },
                    "id": "#bins_summary.cwl/bin_dir"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "doc": "Array of bin files in fasta format",
                    "label": "Bin files",
                    "inputBinding": {
                        "prefix": "--bin_files"
                    },
                    "id": "#bins_summary.cwl/bin_files"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "Binette report file",
                    "label": "Binette report",
                    "inputBinding": {
                        "prefix": "--binette"
                    },
                    "id": "#bins_summary.cwl/binette_report"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "BUSCO batch report file",
                    "label": "BUSCO batch",
                    "inputBinding": {
                        "prefix": "--busco_batch"
                    },
                    "id": "#bins_summary.cwl/busco_batch"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "CoverM tsv with bins coverages/abundances",
                    "label": "CoverM tsv",
                    "inputBinding": {
                        "prefix": "--coverm"
                    },
                    "id": "#bins_summary.cwl/coverm"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "GTDB-Tk summary file",
                    "label": "GTDB-Tk summary",
                    "inputBinding": {
                        "prefix": "--gtdbtk"
                    },
                    "id": "#bins_summary.cwl/gtdbtk_summary"
                },
                {
                    "type": "string",
                    "doc": "Identifier for this dataset used in this workflow",
                    "label": "identifier used",
                    "id": "#bins_summary.cwl/identifier"
                }
            ],
            "arguments": [
                {
                    "prefix": "--output",
                    "valueFrom": "$(inputs.identifier)"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_bin-contigs.tsv"
                    },
                    "id": "#bins_summary.cwl/bin_contigs"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_bin-summary.tsv"
                    },
                    "id": "#bins_summary.cwl/bins_summary_table"
                }
            ],
            "id": "#bins_summary.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateCreated": "2021-00-00",
            "https://schema.org/dateModified": "2025-09-03",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "Unbinned contigs",
            "doc": "Get unbinned contigs of the assembbly from a set of binned fasta files in fasta format.\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/scripts:d98a4a55",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "5"
                            ],
                            "package": "bash"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "bash",
                "/scripts/metagenomics/get_unbinned_contigs.sh"
            ],
            "inputs": [
                {
                    "type": "File",
                    "doc": "fasta file that was used for the binning.",
                    "label": "assembly fasta file",
                    "inputBinding": {
                        "prefix": "-a"
                    },
                    "id": "#get_unbinned_contigs.cwl/assembly_fasta"
                },
                {
                    "type": "Directory",
                    "doc": "Folder containing bins in fasta format",
                    "label": "Bin folder",
                    "inputBinding": {
                        "prefix": "-b"
                    },
                    "id": "#get_unbinned_contigs.cwl/bin_dir"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "doc": "Extension of bin files (default; fa)",
                    "label": "Bin file extension",
                    "default": "fa",
                    "inputBinding": {
                        "prefix": "-e"
                    },
                    "id": "#get_unbinned_contigs.cwl/bin_extension"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "doc": "Enable compression with pigz",
                    "label": "Enable compression",
                    "inputBinding": {
                        "prefix": "-z"
                    },
                    "id": "#get_unbinned_contigs.cwl/compress"
                },
                {
                    "type": "string",
                    "doc": "Identifier for this dataset used in this workflow",
                    "label": "identifier used",
                    "inputBinding": {
                        "prefix": "-i"
                    },
                    "id": "#get_unbinned_contigs.cwl/identifier"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Threads",
                    "doc": "Number of threads for compression (default; 4)",
                    "default": 4,
                    "inputBinding": {
                        "prefix": "-t"
                    },
                    "id": "#get_unbinned_contigs.cwl/threads"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_unbinned-contigs.*"
                    },
                    "id": "#get_unbinned_contigs.cwl/unbinned_fasta"
                }
            ],
            "id": "#get_unbinned_contigs.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateModified": "2025-09-01",
            "https://schema.org/dateCreated": "2021-00-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "Genome conversion",
            "doc": "Runs Genome conversion tool from SAPP\n",
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/sapp:2.0",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "17.0.3"
                            ],
                            "specs": [
                                "https://anaconda.org/conda-forge/openjdk"
                            ],
                            "package": "openjdk"
                        },
                        {
                            "version": [
                                "2.0"
                            ],
                            "specs": [
                                "https://sapp.gitlab.io/docs/index.html",
                                "file:///home/bart/git/cwl/tools/sapp/doi.org/10.1101/184747"
                            ],
                            "package": "sapp"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "doc": "Codon table used for this organism",
                    "label": "Codon table",
                    "inputBinding": {
                        "prefix": "-codon"
                    },
                    "id": "#conversion.cwl/codon_table"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "Reference genome file used in EMBL format",
                    "label": "Reference genome",
                    "inputBinding": {
                        "prefix": "-input"
                    },
                    "id": "#conversion.cwl/embl"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "Reference genome file used in fasta format",
                    "label": "Reference genome",
                    "inputBinding": {
                        "prefix": "-input"
                    },
                    "id": "#conversion.cwl/fasta"
                },
                {
                    "type": "string",
                    "doc": "Name of the sample being analysed",
                    "label": "Sample name",
                    "inputBinding": {
                        "prefix": "-id"
                    },
                    "id": "#conversion.cwl/identifier"
                }
            ],
            "baseCommand": [
                "java",
                "-Xmx5g",
                "-jar",
                "/SAPP-2.0.jar"
            ],
            "arguments": [
                {
                    "valueFrom": "${\n  if (inputs.embl) {\n    return '-embl2rdf';\n  }\n  if (inputs.fasta) {\n    return '-fasta2rdf';\n  }\n}\n"
                },
                {
                    "valueFrom": "${\n  if (inputs.fasta) {\n    return '-genome';\n  } \n  return null;\n}\n"
                },
                {
                    "prefix": "-output",
                    "valueFrom": "$(inputs.identifier).ttl"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier).ttl"
                    },
                    "id": "#conversion.cwl/output"
                }
            ],
            "id": "#conversion.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateModified": "2024-10-07",
            "https://schema.org/dateCreated": "2020-00-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "SAPP conversion -kofamscan",
            "doc": "SAPP conversion from eggNOG-mapper output to GBOL RDF file (TTL)\n",
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/sapp:2.0",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "17.0.3"
                            ],
                            "specs": [
                                "https://anaconda.org/conda-forge/openjdk"
                            ],
                            "package": "openjdk"
                        },
                        {
                            "version": [
                                "2.0"
                            ],
                            "specs": [
                                "https://sapp.gitlab.io/docs/index.html",
                                "file:///home/bart/git/cwl/tools/sapp/conversion/doi.org/10.1101/184747"
                            ],
                            "package": "sapp"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "inputs": [
                {
                    "type": "string",
                    "label": "Output prefix",
                    "doc": "Output filename prefix. Suffix '.eggnog.ttl' will be added.",
                    "id": "#conversion_eggnog.cwl/output_prefix"
                },
                {
                    "type": "File",
                    "label": "RDF",
                    "doc": "Input RDF file",
                    "inputBinding": {
                        "prefix": "-input"
                    },
                    "id": "#conversion_eggnog.cwl/rdf"
                },
                {
                    "type": "File",
                    "label": "KofamScan tsv",
                    "doc": "KofamScan detail-tsv output",
                    "inputBinding": {
                        "prefix": "-resultFile"
                    },
                    "id": "#conversion_eggnog.cwl/resultfile"
                }
            ],
            "arguments": [
                {
                    "prefix": "-output",
                    "valueFrom": "$(inputs.output_prefix).eggnog.ttl"
                }
            ],
            "baseCommand": [
                "java",
                "-Xmx5G",
                "-jar",
                "/SAPP-2.0.jar",
                "-eggnog"
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.output_prefix).eggnog.ttl"
                    },
                    "id": "#conversion_eggnog.cwl/eggnog_ttl"
                }
            ],
            "id": "#conversion_eggnog.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateModified": "2025-05-05",
            "https://schema.org/dateCreated": "2023-09-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "SAPP conversion -interproscan",
            "doc": "SAPP conversion from InterProScan 5 output to GBOL RDF file (TTL)\n",
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/sapp:2.0",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "17.0.3"
                            ],
                            "specs": [
                                "https://anaconda.org/conda-forge/openjdk"
                            ],
                            "package": "openjdk"
                        },
                        {
                            "version": [
                                "2.0"
                            ],
                            "specs": [
                                "https://sapp.gitlab.io/docs/index.html",
                                "file:///home/bart/git/cwl/tools/sapp/conversion/doi.org/10.1101/184747"
                            ],
                            "package": "sapp"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "inputs": [
                {
                    "type": "string",
                    "label": "Output prefix",
                    "doc": "Output filename prefix. Suffix '.interproscan.ttl' will be added.",
                    "id": "#conversion_interproscan.cwl/output_prefix"
                },
                {
                    "type": "File",
                    "label": "RDF",
                    "doc": "Input RDF file",
                    "inputBinding": {
                        "prefix": "-input"
                    },
                    "id": "#conversion_interproscan.cwl/rdf"
                },
                {
                    "type": "File",
                    "label": "KofamScan tsv",
                    "doc": "KofamScan detail-tsv output",
                    "inputBinding": {
                        "prefix": "-resultFile"
                    },
                    "id": "#conversion_interproscan.cwl/resultfile"
                }
            ],
            "arguments": [
                {
                    "prefix": "-output",
                    "valueFrom": "$(inputs.output_prefix).interproscan.ttl"
                }
            ],
            "baseCommand": [
                "java",
                "-Xmx5G",
                "-jar",
                "/SAPP-2.0.jar",
                "-interpro"
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.output_prefix).interproscan.ttl"
                    },
                    "id": "#conversion_interproscan.cwl/interproscan_ttl"
                }
            ],
            "id": "#conversion_interproscan.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateCreated": "2023-09-00",
            "https://schema.org/dateModified": "2024-04-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "SAPP conversion -kofamscan",
            "doc": "SAPP conversion from KoFamScan/KoFamKOALA output to GBOL RDF file (TTL)\n",
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/sapp:2.0",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "17.0.3"
                            ],
                            "specs": [
                                "https://anaconda.org/conda-forge/openjdk"
                            ],
                            "package": "openjdk"
                        },
                        {
                            "version": [
                                "2.0"
                            ],
                            "specs": [
                                "https://sapp.gitlab.io/docs/index.html",
                                "file:///home/bart/git/cwl/tools/sapp/conversion/doi.org/10.1101/184747"
                            ],
                            "package": "sapp"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Limit",
                    "doc": "Limit the number of hits per locus tag (0=no limit) (optional). Default 0",
                    "inputBinding": {
                        "prefix": "-limit"
                    },
                    "default": 0,
                    "id": "#conversion_kofamscan.cwl/limit"
                },
                {
                    "type": "string",
                    "label": "Output prefix",
                    "doc": "Output filename prefix. Suffix '.KoFamKOALA.ttl' will be added.",
                    "id": "#conversion_kofamscan.cwl/output_prefix"
                },
                {
                    "type": "File",
                    "label": "RDF",
                    "doc": "Input RDF file",
                    "inputBinding": {
                        "prefix": "-input"
                    },
                    "id": "#conversion_kofamscan.cwl/rdf"
                },
                {
                    "type": "File",
                    "label": "KofamScan tsv",
                    "doc": "KofamScan detail-tsv output",
                    "inputBinding": {
                        "prefix": "-resultFile"
                    },
                    "id": "#conversion_kofamscan.cwl/resultfile"
                }
            ],
            "arguments": [
                {
                    "prefix": "-output",
                    "valueFrom": "$(inputs.output_prefix).KoFamKOALA.ttl"
                }
            ],
            "baseCommand": [
                "java",
                "-Xmx5G",
                "-jar",
                "/SAPP-2.0.jar",
                "-kofamscan"
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.output_prefix).KoFamKOALA.ttl"
                    },
                    "id": "#conversion_kofamscan.cwl/kofamscan_ttl"
                }
            ],
            "id": "#conversion_kofamscan.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateCreated": "2023-09-00",
            "https://schema.org/dateModified": "2024-04-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "Genome conversion",
            "doc": "Runs Genome conversion tool from SAPP\n",
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/sapp:2.0",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "17.0.3"
                            ],
                            "specs": [
                                "https://anaconda.org/conda-forge/openjdk"
                            ],
                            "package": "openjdk"
                        },
                        {
                            "version": [
                                "2.0"
                            ],
                            "specs": [
                                "https://sapp.gitlab.io/docs/index.html",
                                "file:///home/bart/git/cwl/tools/sapp/doi.org/10.1101/184747"
                            ],
                            "package": "sapp"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "inputs": [
                {
                    "type": "File",
                    "doc": "RDF file in any format with the right extension",
                    "label": "RDF input file (hdt, ttl, nt, etc...)",
                    "inputBinding": {
                        "prefix": "-i"
                    },
                    "id": "#toHDT.cwl/input"
                },
                {
                    "type": "string",
                    "doc": "Name of the output file with the right extension",
                    "label": "RDF output file (hdt, ttl, nt, etc...)",
                    "inputBinding": {
                        "prefix": "-o"
                    },
                    "id": "#toHDT.cwl/output"
                }
            ],
            "baseCommand": [
                "java",
                "-Xmx5g",
                "-jar",
                "/SAPP-2.0.jar",
                "-convert"
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.output)"
                    },
                    "id": "#toHDT.cwl/hdt_output"
                }
            ],
            "id": "#toHDT.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateModified": "2024-10-07",
            "https://schema.org/dateCreated": "2020-00-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "SemiBin2",
            "doc": "Single-sample Metagenomic binning with semi-supervised deep learning using information from reference genomes.",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "networkAccess": true,
                    "class": "NetworkAccess"
                }
            ],
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/semibin:2.2.0--pyhdfd78af_0",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "2.2.0"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/semibin",
                                "file:///home/bart/git/cwl/tools/semibin/doi.org/10.1038/s41467-022-29843-y"
                            ],
                            "package": "semibin"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "SemiBin2",
                "single_easy_bin"
            ],
            "inputs": [
                {
                    "type": "File",
                    "doc": "Input assembly in fasta format",
                    "label": "Input assembly",
                    "inputBinding": {
                        "prefix": "--input-fasta"
                    },
                    "id": "#semibin2_single_easy_bin.cwl/assembly"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "Mapped reads to assembly in sorted BAM format",
                    "label": "BAM file",
                    "inputBinding": {
                        "prefix": "--input-bam"
                    },
                    "id": "#semibin2_single_easy_bin.cwl/bam_file"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "doc": "Built-in models (human_gut/dog_gut/ocean/soil/cat_gut/human_oral/mouse_gut/pig_gut/built_environment/wastewater/chicken_caecum/global)",
                    "label": "Environment",
                    "inputBinding": {
                        "prefix": "--environment"
                    },
                    "id": "#semibin2_single_easy_bin.cwl/environment"
                },
                {
                    "type": "string",
                    "doc": "Identifier for this dataset used in this workflow",
                    "label": "identifier used",
                    "inputBinding": {
                        "prefix": "--tag-output"
                    },
                    "default": "semibin2",
                    "id": "#semibin2_single_easy_bin.cwl/identifier"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "Contig depth file from MetaBAT2",
                    "label": "MetaBAT2 depths",
                    "inputBinding": {
                        "prefix": "--depth-metabat2"
                    },
                    "id": "#semibin2_single_easy_bin.cwl/metabat2_depth_file"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "doc": "Reference Database data directory (usually, MMseqs2 GTDB)",
                    "label": "Reference Database",
                    "inputBinding": {
                        "prefix": "--reference-db"
                    },
                    "id": "#semibin2_single_easy_bin.cwl/reference_database"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "doc": "An alternative binning algorithm for assemblies from long-read datasets.",
                    "label": "Long read assembly",
                    "inputBinding": {
                        "prefix": "--sequencing-type=long_read"
                    },
                    "id": "#semibin2_single_easy_bin.cwl/sequencing_type_longread"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Number of threads to use",
                    "default": 1,
                    "inputBinding": {
                        "prefix": "--threads"
                    },
                    "id": "#semibin2_single_easy_bin.cwl/threads"
                }
            ],
            "arguments": [
                {
                    "prefix": "-o",
                    "valueFrom": "semibin2"
                },
                {
                    "prefix": "--compression",
                    "valueFrom": "none"
                }
            ],
            "outputs": [
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "Coverage data",
                    "doc": "Coverage data generated from depth file.",
                    "outputBinding": {
                        "glob": "semibin2/\"*_cov.csv\""
                    },
                    "id": "#semibin2_single_easy_bin.cwl/coverage"
                },
                {
                    "type": "File",
                    "label": "Training data",
                    "doc": "Data used in the training of deep learning model",
                    "outputBinding": {
                        "glob": "semibin2/data.csv",
                        "outputEval": "${self[0].basename=inputs.identifier+\"_semibin2_data.csv\"; return self;}"
                    },
                    "id": "#semibin2_single_easy_bin.cwl/data"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "Training data",
                    "doc": "Data used in the training of deep learning model, not generated when using MetaBAT2 depth file.",
                    "outputBinding": {
                        "glob": "semibin2/data_split.csv"
                    },
                    "id": "#semibin2_single_easy_bin.cwl/data_split"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "Bins info",
                    "doc": "Info on (reclustered) bins (contig,nbs,n50 etc..)",
                    "outputBinding": {
                        "glob": "semibin2/recluster_bins_info.tsv",
                        "outputEval": "${self[0].basename=inputs.identifier+\"_semibin2_recluster_bins_info.tsv\"; return self;}"
                    },
                    "id": "#semibin2_single_easy_bin.cwl/info"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "label": "MMseqs annotation",
                    "doc": "MMseqs contig annotation",
                    "outputBinding": {
                        "glob": "mmseqs_contig_annotation"
                    },
                    "id": "#semibin2_single_easy_bin.cwl/mmseqs_contig_annotation"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "Deep learning model",
                    "doc": "Saved semi-supervised deep learning model.",
                    "outputBinding": {
                        "glob": "semibin2/model.h5"
                    },
                    "id": "#semibin2_single_easy_bin.cwl/model"
                },
                {
                    "type": "Directory",
                    "label": "Bins",
                    "doc": "Directory of all reconstructed bins before reclustering.",
                    "outputBinding": {
                        "glob": "semibin2/output_bins",
                        "outputEval": "${self[0].basename=inputs.identifier+\"_semibin2_output_bins\"; return self;}"
                    },
                    "id": "#semibin2_single_easy_bin.cwl/output_bins"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "label": "Markers",
                    "doc": "Directory with HMM marker hits",
                    "outputBinding": {
                        "glob": "semibin2/sample0"
                    },
                    "id": "#semibin2_single_easy_bin.cwl/sample0"
                }
            ],
            "id": "#semibin2_single_easy_bin.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateCreated": "2022-09-00",
            "https://schema.org/dateModified": "2025-08-28",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "Fasta statistics",
            "doc": "Fasta statistics like N50, total length, etc..",
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/raw_n50:idba-1.1.3",
                    "class": "DockerRequirement"
                }
            ],
            "baseCommand": [
                "raw_n50"
            ],
            "stdout": "$(inputs.identifier)_stats.txt",
            "inputs": [
                {
                    "type": "string",
                    "doc": "Identifier for this dataset used in this workflow",
                    "label": "identifier used",
                    "id": "#raw_n50.cwl/identifier"
                },
                {
                    "type": "File",
                    "label": "Input fasta",
                    "doc": "Input multi fasta file",
                    "inputBinding": {
                        "position": 1
                    },
                    "id": "#raw_n50.cwl/input_fasta"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_stats.txt"
                    },
                    "id": "#raw_n50.cwl/output"
                }
            ],
            "id": "#raw_n50.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateCreated": "2022-00-06",
            "https://schema.org/dateModified": "2024-03-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "Workflow",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "class": "MultipleInputFeatureRequirement"
                },
                {
                    "class": "ScatterFeatureRequirement"
                },
                {
                    "class": "StepInputExpressionRequirement"
                },
                {
                    "class": "SubworkflowFeatureRequirement"
                }
            ],
            "label": "Metagenomic Binning from Assembly",
            "doc": "Workflow for Metagenomics binning from assembly.<br>\n\nMinimal inputs are: Identifier, assembly (fasta) and a associated sorted BAM file\n\nSummary\n  - MetaBAT2 (binning)\n  - MaxBin2 (binning)\n  - SemiBin2 (binning)\n  - BinSPreader (bin refinement)\n  - DAS Tool (bin merging)\n  - binette (bin merging) In Development\n  - EukRep (eukaryotic classification)\n  - CheckM (bin completeness and contamination)\n  - BUSCO (bin completeness)\n  - GTDB-Tk (bin taxonomic classification)\n\nOther UNLOCK workflows on WorkflowHub: https://workflowhub.eu/projects/16/workflows?view=default<br><br>\n\n**All tool CWL files and other workflows can be found here:**<br>\n  Tools: https://gitlab.com/m-unlock/cwl<br>\n  Workflows: https://gitlab.com/m-unlock/cwl/workflows<br>\n\n**How to setup and use an UNLOCK workflow:**<br>\nhttps://docs.m-unlock.nl/docs/workflows/setup.html<br>\n",
            "outputs": [
                {
                    "label": "Annotation",
                    "doc": "Bin annotation",
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "outputSource": "#main/annotation_files_to_folder_bins/results",
                    "id": "#main/annotation_output"
                },
                {
                    "label": "DAS Tool",
                    "doc": "DAS Tool output directory",
                    "type": "Directory",
                    "outputSource": "#main/binette_files_to_folder/results",
                    "id": "#main/binette_output"
                },
                {
                    "label": "Binned contigs",
                    "doc": "File with contig to bin assignment",
                    "type": "File",
                    "outputSource": "#main/bins_summary/bin_contigs",
                    "id": "#main/binned_contigs"
                },
                {
                    "label": "Bin files",
                    "doc": "Bins files in fasta format. To be be used in other workflows.",
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputSource": "#main/binette_bins/files",
                    "id": "#main/bins"
                },
                {
                    "label": "Assembly/Bin read stats",
                    "doc": "General assembly and bin coverage",
                    "type": "File",
                    "outputSource": "#main/bin_readstats/binReadStats",
                    "id": "#main/bins_read_stats"
                },
                {
                    "label": "Bins summary",
                    "doc": "Summary of info about the bins",
                    "type": "File",
                    "outputSource": "#main/bins_summary/bins_summary_table",
                    "id": "#main/bins_summary_table"
                },
                {
                    "label": "BUSCO",
                    "doc": "BUSCO output directory",
                    "type": "Directory",
                    "outputSource": "#main/busco_files_to_folder/results",
                    "id": "#main/busco_output"
                },
                {
                    "label": "EukRep fasta",
                    "doc": "EukRep eukaryotic classified contigs",
                    "type": "File",
                    "outputSource": "#main/eukrep/euk_fasta_out",
                    "id": "#main/eukrep_fasta"
                },
                {
                    "label": "EukRep stats",
                    "doc": "EukRep fasta statistics",
                    "type": "File",
                    "outputSource": "#main/eukrep_stats/output",
                    "id": "#main/eukrep_stats_file"
                },
                {
                    "label": "GTDB-Tk",
                    "doc": "GTDB-Tk output directory",
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "outputSource": "#main/gtdbtk_files_to_folder/results",
                    "id": "#main/gtdbtk_output"
                },
                {
                    "label": "MaxBin2",
                    "doc": "MaxBin2 output directory\u00df",
                    "type": "Directory",
                    "outputSource": "#main/maxbin2_files_to_folder/results",
                    "id": "#main/maxbin2_output"
                },
                {
                    "label": "MetaBAT2",
                    "doc": "MetaBAT2 output directory",
                    "type": "Directory",
                    "outputSource": "#main/metabat2_files_to_folder/results",
                    "id": "#main/metabat2_output"
                },
                {
                    "label": "SemiBin",
                    "doc": "MaxBin2 output directory",
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "outputSource": "#main/semibin_files_to_folder/results",
                    "id": "#main/semibin_output"
                }
            ],
            "inputs": [
                {
                    "type": "boolean",
                    "label": "Annotate bins",
                    "doc": "Annotate bins. Default false",
                    "default": false,
                    "id": "#main/annotate_bins"
                },
                {
                    "type": "boolean",
                    "label": "Annotate unbinned",
                    "doc": "Annotate unbinned contigs. Will be treated as metagenome. Default false",
                    "default": false,
                    "id": "#main/annotate_unbinned"
                },
                {
                    "type": "File",
                    "doc": "Assembly in fasta format",
                    "label": "Assembly fasta",
                    "loadListing": "no_listing",
                    "id": "#main/assembly"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "Assembly graph file from asssembler for BinSPreader",
                    "label": "BinSPreader graph file",
                    "id": "#main/assembly_graph"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "label": "Bakta DB",
                    "doc": "Bakta Database directory (required when annotating bins)",
                    "id": "#main/bakta_db"
                },
                {
                    "type": "File",
                    "doc": "Mapping file in sorted bam format containing reads mapped to the assembly",
                    "label": "Bam file",
                    "loadListing": "no_listing",
                    "id": "#main/bam_file"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "label": "BUSCO dataset",
                    "doc": "Directory containing the BUSCO dataset location.",
                    "loadListing": "no_listing",
                    "id": "#main/busco_data"
                },
                {
                    "type": "float",
                    "doc": "Score metric used in Binette bin refinement. Bin are scored as follow; completeness - weight * contamination. A low contamination_weight favor complete bins over low contaminated bins. Default 2.0",
                    "label": "Contamination weight",
                    "default": 2.0,
                    "id": "#main/contamination_weight"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "Output destination",
                    "doc": "Optional output destination path for cwl-prov reporting. (not used in the workflow itself)",
                    "id": "#main/destination"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "record",
                            "name": "#main/eggnog_dbs/eggnog_dbs",
                            "fields": [
                                {
                                    "type": [
                                        "null",
                                        "Directory"
                                    ],
                                    "doc": "Directory containing all data files for the eggNOG database.",
                                    "loadListing": "no_listing",
                                    "name": "#main/eggnog_dbs/eggnog_dbs/data_dir"
                                },
                                {
                                    "type": [
                                        "null",
                                        "File"
                                    ],
                                    "doc": "eggNOG database file",
                                    "loadListing": "no_listing",
                                    "name": "#main/eggnog_dbs/eggnog_dbs/db"
                                },
                                {
                                    "type": [
                                        "null",
                                        "File"
                                    ],
                                    "doc": "eggNOG database file for diamond blast search",
                                    "loadListing": "no_listing",
                                    "name": "#main/eggnog_dbs/eggnog_dbs/diamond_db"
                                }
                            ]
                        }
                    ],
                    "id": "#main/eggnog_dbs"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "doc": "Directory containing the GTDB database. When none is given GTDB-Tk will be skipped.",
                    "label": "gtdbtk data directory",
                    "loadListing": "no_listing",
                    "id": "#main/gtdbtk_data"
                },
                {
                    "type": "string",
                    "doc": "Identifier for this dataset used in this workflow",
                    "label": "Identifier used",
                    "id": "#main/identifier"
                },
                {
                    "type": "string",
                    "label": "InterProScan applications",
                    "doc": "Comma separated list of analyses:\nFunFam,SFLD,PANTHER,Gene3D,Hamap,PRINTS,ProSiteProfiles,Coils,SUPERFAMILY,SMART,CDD,PIRSR,ProSitePatterns,AntiFam,Pfam,MobiDBLite,PIRSF,NCBIfam\ndefault Pfam,SFLD,SMART,AntiFam,NCBIfam\n",
                    "default": "Pfam",
                    "id": "#main/interproscan_applications"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "label": "InterProScan 5 directory",
                    "doc": "Directory of the (full) InterProScan 5 program. Used for annotating bins. (required when running with interproscan)",
                    "loadListing": "no_listing",
                    "id": "#main/interproscan_directory"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "SAPP kofamscan limit",
                    "doc": "Limit max number of entries of kofamscan hits per locus in SAPP. Default 5",
                    "default": 5,
                    "id": "#main/kofamscan_limit_sapp"
                },
                {
                    "type": "int",
                    "doc": "Minimum completeness for Binette bin refinement. Default 40",
                    "label": "Minimum completeness",
                    "default": 40,
                    "id": "#main/min_completeness"
                },
                {
                    "type": "boolean",
                    "doc": "Run with BUSCO bin completeness assessment. Default false",
                    "label": "Run BUSCO",
                    "default": false,
                    "id": "#main/run_busco"
                },
                {
                    "type": "boolean",
                    "label": "Run eggNOG-mapper",
                    "doc": "Run with eggNOG-mapper annotation. Requires eggnog database files. Default false",
                    "default": false,
                    "id": "#main/run_eggnog"
                },
                {
                    "type": "boolean",
                    "label": "Run InterProScan",
                    "doc": "Run with eggNOG-mapper annotation. Requires InterProScan v5 program files. Default false",
                    "default": false,
                    "id": "#main/run_interproscan"
                },
                {
                    "type": "boolean",
                    "label": "Run kofamscan",
                    "doc": "Run with KEGG KO KoFamKOALA annotation. Default false",
                    "default": false,
                    "id": "#main/run_kofamscan"
                },
                {
                    "type": "boolean",
                    "doc": "Run with MaxBin2 binner. Default true",
                    "label": "Run Maxbin2",
                    "default": true,
                    "id": "#main/run_maxbin2"
                },
                {
                    "type": "boolean",
                    "doc": "Run with SemiBin2 binner. Default true",
                    "label": "Run SemiBin",
                    "default": true,
                    "id": "#main/run_semibin2"
                },
                {
                    "doc": "Semibin2 Built-in models (none/global/human_gut/dog_gut/ocean/soil/cat_gut/human_oral/mouse_gut/pig_gut/built_environment/wastewater/chicken_caecum). \nChoosing a built-in model is generally faster. Otherwise it will do (single-sample) training on the data.\nDefault global\n",
                    "label": "SemiBin Environment",
                    "type": [
                        {
                            "type": "enum",
                            "symbols": [
                                "#main/semibin2_environment/none",
                                "#main/semibin2_environment/global",
                                "#main/semibin2_environment/human_gut",
                                "#main/semibin2_environment/dog_gut",
                                "#main/semibin2_environment/ocean",
                                "#main/semibin2_environment/soil",
                                "#main/semibin2_environment/cat_gut",
                                "#main/semibin2_environment/human_oral",
                                "#main/semibin2_environment/mouse_gut",
                                "#main/semibin2_environment/pig_gut",
                                "#main/semibin2_environment/built_environment",
                                "#main/semibin2_environment/wastewater",
                                "#main/semibin2_environment/chicken_caecum"
                            ]
                        }
                    ],
                    "default": "global",
                    "id": "#main/semibin2_environment"
                },
                {
                    "type": "boolean",
                    "label": "Skip CRISPR",
                    "doc": "Skip CRISPR array prediction using PILER-CR",
                    "default": false,
                    "id": "#main/skip_bakta_crispr"
                },
                {
                    "type": "int",
                    "doc": "Number of threads to use for computational processes",
                    "label": "Threads",
                    "default": 2,
                    "id": "#main/threads"
                }
            ],
            "steps": [
                {
                    "doc": "Preparation of annotation output files to a specific output folder",
                    "label": "Annotation output folder",
                    "when": "$((inputs.annotate_bins || inputs.annotate_unbinned))",
                    "run": "#files_to_folder.cwl",
                    "in": [
                        {
                            "source": "#main/annotate_bins",
                            "id": "#main/annotation_files_to_folder_bins/annotate_bins"
                        },
                        {
                            "source": "#main/annotate_unbinned",
                            "id": "#main/annotation_files_to_folder_bins/annotate_unbinned"
                        },
                        {
                            "valueFrom": "bin_annotation",
                            "id": "#main/annotation_files_to_folder_bins/destination"
                        },
                        {
                            "source": [
                                "#main/workflow_microbial_annotation_unbinned/compressed_other_files",
                                "#main/workflow_microbial_annotation_unbinned/sapp_hdt_file",
                                "#main/workflow_microbial_annotation_bins/sapp_hdt_file",
                                "#main/annotation_output_to_array_bins/output"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#main/annotation_files_to_folder_bins/files"
                        },
                        {
                            "source": [
                                "#main/workflow_microbial_annotation_bins/bakta_folder_compressed",
                                "#main/workflow_microbial_annotation_unbinned/bakta_folder_compressed"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#main/annotation_files_to_folder_bins/folders"
                        }
                    ],
                    "out": [
                        "#main/annotation_files_to_folder_bins/results"
                    ],
                    "id": "#main/annotation_files_to_folder_bins"
                },
                {
                    "when": "$(inputs.annotate_bins)",
                    "run": "#merge_file_arrays.cwl",
                    "in": [
                        {
                            "source": "#main/annotate_bins",
                            "id": "#main/annotation_output_to_array_bins/annotate_bins"
                        },
                        {
                            "source": [
                                "#main/workflow_microbial_annotation_bins/compressed_other_files"
                            ],
                            "id": "#main/annotation_output_to_array_bins/input"
                        }
                    ],
                    "out": [
                        "#main/annotation_output_to_array_bins/output"
                    ],
                    "id": "#main/annotation_output_to_array_bins"
                },
                {
                    "doc": "Table general bin and assembly read mapping stats",
                    "label": "Bin and assembly read stats",
                    "run": "#assembly_bins_readstats.cwl",
                    "in": [
                        {
                            "source": "#main/bam_file",
                            "id": "#main/bin_readstats/bam_file"
                        },
                        {
                            "source": "#main/binette/final_bins",
                            "id": "#main/bin_readstats/bin_dir"
                        },
                        {
                            "source": "#main/identifier",
                            "id": "#main/bin_readstats/identifier"
                        }
                    ],
                    "out": [
                        "#main/bin_readstats/binReadStats"
                    ],
                    "id": "#main/bin_readstats"
                },
                {
                    "doc": "Binning refinement using Binette",
                    "label": "Binette",
                    "run": "#binette.cwl",
                    "in": [
                        {
                            "source": [
                                "#main/metabat2_filter_bins/output_folder",
                                "#main/maxbin2_to_folder/results",
                                "#main/semibin2/output_bins"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#main/binette/bins_dirs"
                        },
                        {
                            "source": "#main/contamination_weight",
                            "id": "#main/binette/contamination_weight"
                        },
                        {
                            "source": "#main/assembly",
                            "id": "#main/binette/contigs"
                        },
                        {
                            "source": "#main/min_completeness",
                            "id": "#main/binette/min_completeness"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/binette/threads"
                        },
                        {
                            "default": true,
                            "id": "#main/binette/verbose"
                        }
                    ],
                    "out": [
                        "#main/binette/final_bins",
                        "#main/binette/final_bins_quality_report",
                        "#main/binette/input_bins_quality_reports"
                    ],
                    "id": "#main/binette"
                },
                {
                    "doc": "Binette bins folder to File array for further analysis",
                    "label": "Bin folder to files[]",
                    "run": "#folder_to_files.cwl",
                    "in": [
                        {
                            "source": "#main/binette/final_bins",
                            "id": "#main/binette_bins/folder"
                        }
                    ],
                    "out": [
                        "#main/binette_bins/files"
                    ],
                    "id": "#main/binette_bins"
                },
                {
                    "doc": "Preparation of DAS Tool output files to a specific output folder.",
                    "label": "DAS Tool output folder",
                    "run": "#files_to_folder.cwl",
                    "in": [
                        {
                            "valueFrom": "bin_refinement_binette",
                            "id": "#main/binette_files_to_folder/destination"
                        },
                        {
                            "source": [
                                "#main/binette/final_bins_quality_report",
                                "#main/get_unbinned_contigs/unbinned_fasta"
                            ],
                            "linkMerge": "merge_flattened",
                            "id": "#main/binette_files_to_folder/files"
                        },
                        {
                            "source": [
                                "#main/binette/final_bins",
                                "#main/binette/input_bins_quality_reports"
                            ],
                            "linkMerge": "merge_flattened",
                            "id": "#main/binette_files_to_folder/folders"
                        }
                    ],
                    "out": [
                        "#main/binette_files_to_folder/results"
                    ],
                    "id": "#main/binette_files_to_folder"
                },
                {
                    "doc": "Table of final bins and their statistics like size, contigs, completeness etc",
                    "label": "Bins summary",
                    "run": "#bins_summary.cwl",
                    "in": [
                        {
                            "source": [
                                "#main/binette_bins/files",
                                "#main/get_unbinned_contigs/unbinned_fasta"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#main/bins_summary/bin_files"
                        },
                        {
                            "source": "#main/binette/final_bins_quality_report",
                            "id": "#main/bins_summary/binette_report"
                        },
                        {
                            "source": "#main/busco/batch_summary",
                            "id": "#main/bins_summary/busco_batch"
                        },
                        {
                            "source": "#main/coverm/coverm_tsv",
                            "id": "#main/bins_summary/coverm"
                        },
                        {
                            "source": "#main/gtdbtk/gtdbtk_summary",
                            "id": "#main/bins_summary/gtdbtk_summary"
                        },
                        {
                            "source": "#main/identifier",
                            "id": "#main/bins_summary/identifier"
                        }
                    ],
                    "out": [
                        "#main/bins_summary/bins_summary_table",
                        "#main/bins_summary/bin_contigs"
                    ],
                    "id": "#main/bins_summary"
                },
                {
                    "doc": "BUSCO assembly completeness workflow",
                    "label": "BUSCO",
                    "run": "#busco.cwl",
                    "when": "$(inputs.bins.length !== 0 && inputs.run_busco)",
                    "in": [
                        {
                            "valueFrom": "$(true)",
                            "id": "#main/busco/auto-lineage-prok"
                        },
                        {
                            "source": "#main/binette_bins/files",
                            "id": "#main/busco/bins"
                        },
                        {
                            "source": "#main/busco_data",
                            "id": "#main/busco/busco_data"
                        },
                        {
                            "source": "#main/identifier",
                            "id": "#main/busco/identifier"
                        },
                        {
                            "valueFrom": "geno",
                            "id": "#main/busco/mode"
                        },
                        {
                            "source": "#main/run_busco",
                            "id": "#main/busco/run_busco"
                        },
                        {
                            "source": "#main/binette/final_bins",
                            "id": "#main/busco/sequence_folder"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/busco/threads"
                        }
                    ],
                    "out": [
                        "#main/busco/batch_summary"
                    ],
                    "id": "#main/busco"
                },
                {
                    "doc": "Preparation of BUSCO output files to a specific output folder",
                    "label": "BUSCO output folder",
                    "when": "$(inputs.run_busco)",
                    "run": "#files_to_folder.cwl",
                    "in": [
                        {
                            "valueFrom": "busco_bin_completeness",
                            "id": "#main/busco_files_to_folder/destination"
                        },
                        {
                            "source": [
                                "#main/busco/batch_summary"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#main/busco_files_to_folder/files"
                        },
                        {
                            "source": "#main/run_busco",
                            "id": "#main/busco_files_to_folder/run_busco"
                        }
                    ],
                    "out": [
                        "#main/busco_files_to_folder/results"
                    ],
                    "id": "#main/busco_files_to_folder"
                },
                {
                    "doc": "Compress GTDB-Tk output folder",
                    "label": "Compress GTDB-Tk",
                    "when": "$(inputs.gtdbtk_data !== null)",
                    "run": "#compress_directory.cwl",
                    "in": [
                        {
                            "source": "#main/gtdbtk_data",
                            "id": "#main/compress_gtdbtk/gtdbtk_data"
                        },
                        {
                            "source": "#main/gtdbtk/gtdbtk_out_folder",
                            "id": "#main/compress_gtdbtk/indir"
                        }
                    ],
                    "out": [
                        "#main/compress_gtdbtk/outfile"
                    ],
                    "id": "#main/compress_gtdbtk"
                },
                {
                    "doc": "CoverM to obtain bin coverages/abundances",
                    "label": "CoverM",
                    "run": "#coverm_genome.cwl",
                    "when": "$(inputs.genome_fasta_files.length !== 0)",
                    "in": [
                        {
                            "source": [
                                "#main/bam_file"
                            ],
                            "linkMerge": "merge_nested",
                            "id": "#main/coverm/bam_files"
                        },
                        {
                            "source": [
                                "#main/binette_bins/files",
                                "#main/get_unbinned_contigs/unbinned_fasta"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#main/coverm/genome_fasta_files"
                        },
                        {
                            "source": "#main/identifier",
                            "id": "#main/coverm/identifier"
                        }
                    ],
                    "out": [
                        "#main/coverm/coverm_tsv"
                    ],
                    "id": "#main/coverm"
                },
                {
                    "doc": "EukRep, eukaryotic sequence classification",
                    "label": "EukRep",
                    "run": "#eukrep.cwl",
                    "in": [
                        {
                            "source": "#main/assembly",
                            "id": "#main/eukrep/assembly"
                        },
                        {
                            "source": "#main/identifier",
                            "id": "#main/eukrep/identifier"
                        }
                    ],
                    "out": [
                        "#main/eukrep/euk_fasta_out"
                    ],
                    "id": "#main/eukrep"
                },
                {
                    "doc": "EukRep fasta statistics",
                    "label": "EukRep stats",
                    "run": "#raw_n50.cwl",
                    "in": [
                        {
                            "source": "#main/identifier",
                            "valueFrom": "$(self)_eukrep",
                            "id": "#main/eukrep_stats/identifier"
                        },
                        {
                            "source": "#main/eukrep/euk_fasta_out",
                            "id": "#main/eukrep_stats/input_fasta"
                        }
                    ],
                    "out": [
                        "#main/eukrep_stats/output"
                    ],
                    "id": "#main/eukrep_stats"
                },
                {
                    "doc": "Extract unbinned contigs",
                    "label": "Extract unbinned contigs from assembly and bins",
                    "when": "$(inputs.bins.length !== 0)",
                    "run": "#get_unbinned_contigs.cwl",
                    "in": [
                        {
                            "source": "#main/assembly",
                            "id": "#main/get_unbinned_contigs/assembly_fasta"
                        },
                        {
                            "source": "#main/binette/final_bins",
                            "id": "#main/get_unbinned_contigs/bin_dir"
                        },
                        {
                            "valueFrom": "fa",
                            "id": "#main/get_unbinned_contigs/bin_extension"
                        },
                        {
                            "source": "#main/binette_bins/files",
                            "id": "#main/get_unbinned_contigs/bins"
                        },
                        {
                            "source": "#main/identifier",
                            "valueFrom": "$(self)_binette",
                            "id": "#main/get_unbinned_contigs/identifier"
                        }
                    ],
                    "out": [
                        "#main/get_unbinned_contigs/unbinned_fasta"
                    ],
                    "id": "#main/get_unbinned_contigs"
                },
                {
                    "doc": "Taxonomic assigment of bins with GTDB-Tk",
                    "label": "GTDBTK",
                    "when": "$(inputs.gtdbtk_data !== null && inputs.bins.length !== 0)",
                    "run": "#gtdbtk_classify_wf.cwl",
                    "in": [
                        {
                            "source": "#main/binette/final_bins",
                            "id": "#main/gtdbtk/bin_dir"
                        },
                        {
                            "source": "#main/binette_bins/files",
                            "id": "#main/gtdbtk/bins"
                        },
                        {
                            "source": "#main/gtdbtk_data",
                            "id": "#main/gtdbtk/gtdbtk_data"
                        },
                        {
                            "source": "#main/identifier",
                            "id": "#main/gtdbtk/identifier"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/gtdbtk/threads"
                        }
                    ],
                    "out": [
                        "#main/gtdbtk/gtdbtk_summary",
                        "#main/gtdbtk/gtdbtk_out_folder"
                    ],
                    "id": "#main/gtdbtk"
                },
                {
                    "doc": "Preparation of GTDB-Tk output files to a specific output folder",
                    "label": "GTBD-Tk output folder",
                    "when": "$(inputs.gtdbtk_data !== null)",
                    "run": "#files_to_folder.cwl",
                    "in": [
                        {
                            "valueFrom": "gtdb-tk_bin_classification",
                            "id": "#main/gtdbtk_files_to_folder/destination"
                        },
                        {
                            "source": [
                                "#main/gtdbtk/gtdbtk_summary",
                                "#main/compress_gtdbtk/outfile"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#main/gtdbtk_files_to_folder/files"
                        },
                        {
                            "source": "#main/gtdbtk_data",
                            "id": "#main/gtdbtk_files_to_folder/gtdbtk_data"
                        }
                    ],
                    "out": [
                        "#main/gtdbtk_files_to_folder/results"
                    ],
                    "id": "#main/gtdbtk_files_to_folder"
                },
                {
                    "doc": "Binning procedure using MaxBin2",
                    "label": "MaxBin2 binning",
                    "when": "$(inputs.run_maxbin2)",
                    "run": "#maxbin2.cwl",
                    "in": [
                        {
                            "source": "#main/metabat2_contig_depths/depths",
                            "id": "#main/maxbin2/abundances"
                        },
                        {
                            "source": "#main/assembly",
                            "id": "#main/maxbin2/contigs"
                        },
                        {
                            "source": "#main/identifier",
                            "id": "#main/maxbin2/identifier"
                        },
                        {
                            "source": "#main/run_maxbin2",
                            "id": "#main/maxbin2/run_maxbin2"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/maxbin2/threads"
                        }
                    ],
                    "out": [
                        "#main/maxbin2/bins",
                        "#main/maxbin2/summary",
                        "#main/maxbin2/log"
                    ],
                    "id": "#main/maxbin2"
                },
                {
                    "doc": "Preparation of maxbin2 output files to a specific output folder.",
                    "label": "MaxBin2 output folder",
                    "when": "$(inputs.run_maxbin2)",
                    "run": "#files_to_folder.cwl",
                    "in": [
                        {
                            "valueFrom": "binner_maxbin2",
                            "id": "#main/maxbin2_files_to_folder/destination"
                        },
                        {
                            "source": [
                                "#main/maxbin2/summary",
                                "#main/maxbin2/log"
                            ],
                            "linkMerge": "merge_flattened",
                            "id": "#main/maxbin2_files_to_folder/files"
                        },
                        {
                            "source": [
                                "#main/maxbin2_to_folder/results"
                            ],
                            "linkMerge": "merge_flattened",
                            "id": "#main/maxbin2_files_to_folder/folders"
                        },
                        {
                            "source": "#main/run_maxbin2",
                            "id": "#main/maxbin2_files_to_folder/run_maxbin2"
                        }
                    ],
                    "out": [
                        "#main/maxbin2_files_to_folder/results"
                    ],
                    "id": "#main/maxbin2_files_to_folder"
                },
                {
                    "doc": "Create folder with MaxBin2 bins",
                    "label": "MaxBin2 bins to folder",
                    "when": "$(inputs.run_maxbin2)",
                    "run": "#files_to_folder.cwl",
                    "in": [
                        {
                            "valueFrom": "maxbin2_bins",
                            "id": "#main/maxbin2_to_folder/destination"
                        },
                        {
                            "source": "#main/maxbin2/bins",
                            "id": "#main/maxbin2_to_folder/files"
                        },
                        {
                            "source": "#main/run_maxbin2",
                            "id": "#main/maxbin2_to_folder/run_maxbin2"
                        }
                    ],
                    "out": [
                        "#main/maxbin2_to_folder/results"
                    ],
                    "id": "#main/maxbin2_to_folder"
                },
                {
                    "doc": "Binning procedure using MetaBAT2",
                    "label": "MetaBAT2 binning",
                    "run": "#metabat2.cwl",
                    "in": [
                        {
                            "source": "#main/assembly",
                            "id": "#main/metabat2/assembly"
                        },
                        {
                            "source": "#main/metabat2_contig_depths/depths",
                            "id": "#main/metabat2/depths"
                        },
                        {
                            "source": "#main/identifier",
                            "id": "#main/metabat2/identifier"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/metabat2/threads"
                        }
                    ],
                    "out": [
                        "#main/metabat2/bin_dir",
                        "#main/metabat2/log"
                    ],
                    "id": "#main/metabat2"
                },
                {
                    "label": "contig depths",
                    "doc": "MetabatContigDepths to obtain the depth file used in the MetaBat2 and SemiBin2 binning process",
                    "run": "#metabatContigDepths.cwl",
                    "in": [
                        {
                            "source": "#main/bam_file",
                            "id": "#main/metabat2_contig_depths/bamFile"
                        },
                        {
                            "source": "#main/identifier",
                            "id": "#main/metabat2_contig_depths/identifier"
                        }
                    ],
                    "out": [
                        "#main/metabat2_contig_depths/depths"
                    ],
                    "id": "#main/metabat2_contig_depths"
                },
                {
                    "doc": "Preparation of MetaBAT2 output files + unbinned contigs to a specific output folder",
                    "label": "MetaBAT2 output folder",
                    "run": "#files_to_folder.cwl",
                    "in": [
                        {
                            "valueFrom": "binner_metabat2",
                            "id": "#main/metabat2_files_to_folder/destination"
                        },
                        {
                            "source": [
                                "#main/metabat2/log",
                                "#main/metabat2_contig_depths/depths"
                            ],
                            "linkMerge": "merge_flattened",
                            "id": "#main/metabat2_files_to_folder/files"
                        },
                        {
                            "source": [
                                "#main/metabat2/bin_dir"
                            ],
                            "linkMerge": "merge_flattened",
                            "id": "#main/metabat2_files_to_folder/folders"
                        }
                    ],
                    "out": [
                        "#main/metabat2_files_to_folder/results"
                    ],
                    "id": "#main/metabat2_files_to_folder"
                },
                {
                    "doc": "Only keep genome bin fasta files (exlude e.g TooShort.fa)",
                    "label": "Keep MetaBAT2 genome bins",
                    "run": "#folder_file_regex.cwl",
                    "in": [
                        {
                            "source": "#main/metabat2/bin_dir",
                            "id": "#main/metabat2_filter_bins/folder"
                        },
                        {
                            "default": true,
                            "id": "#main/metabat2_filter_bins/output_as_folder"
                        },
                        {
                            "valueFrom": "metabat2_bins",
                            "id": "#main/metabat2_filter_bins/output_folder_name"
                        },
                        {
                            "valueFrom": "bin\\.[0-9]+\\.fa",
                            "id": "#main/metabat2_filter_bins/regex"
                        }
                    ],
                    "out": [
                        "#main/metabat2_filter_bins/output_folder"
                    ],
                    "id": "#main/metabat2_filter_bins"
                },
                {
                    "doc": "Binning procedure using SemiBin2",
                    "label": "Semibin2 binning",
                    "run": "#semibin2_single_easy_bin.cwl",
                    "when": "$(inputs.run_semibin2)",
                    "in": [
                        {
                            "source": "#main/assembly",
                            "id": "#main/semibin2/assembly"
                        },
                        {
                            "source": "#main/bam_file",
                            "valueFrom": "${ return inputs.environment === \"none\" ? self : null; }\n",
                            "id": "#main/semibin2/bam_file"
                        },
                        {
                            "source": "#main/semibin2_environment",
                            "valueFrom": "${ return self !== \"none\" ? self : null; }\n",
                            "id": "#main/semibin2/environment"
                        },
                        {
                            "source": "#main/identifier",
                            "valueFrom": "$(self)_SemiBin2",
                            "id": "#main/semibin2/identifier"
                        },
                        {
                            "source": "#main/metabat2_contig_depths/depths",
                            "valueFrom": "${ return inputs.environment !== \"none\" ? self : null; }\n",
                            "id": "#main/semibin2/metabat2_depth_file"
                        },
                        {
                            "source": "#main/run_semibin2",
                            "id": "#main/semibin2/run_semibin2"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/semibin2/threads"
                        }
                    ],
                    "out": [
                        "#main/semibin2/output_bins",
                        "#main/semibin2/data",
                        "#main/semibin2/data_split",
                        "#main/semibin2/model",
                        "#main/semibin2/coverage"
                    ],
                    "id": "#main/semibin2"
                },
                {
                    "doc": "Preparation of SemiBin output files to a specific output folder.",
                    "label": "SemiBin output folder",
                    "run": "#files_to_folder.cwl",
                    "when": "$(inputs.run_semibin2)",
                    "in": [
                        {
                            "valueFrom": "binner_semibin2",
                            "id": "#main/semibin_files_to_folder/destination"
                        },
                        {
                            "source": [
                                "#main/semibin2/data",
                                "#main/semibin2/data_split",
                                "#main/semibin2/model",
                                "#main/semibin2/coverage"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#main/semibin_files_to_folder/files"
                        },
                        {
                            "source": [
                                "#main/semibin2/output_bins"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#main/semibin_files_to_folder/folders"
                        },
                        {
                            "source": "#main/run_semibin2",
                            "id": "#main/semibin_files_to_folder/run_semibin2"
                        }
                    ],
                    "out": [
                        "#main/semibin_files_to_folder/results"
                    ],
                    "id": "#main/semibin_files_to_folder"
                },
                {
                    "doc": "Microbial annotation workflow of the predicted bins",
                    "label": "Annotate bins",
                    "when": "$(inputs.annotate_bins)",
                    "run": "#workflow_microbial_annotation.cwl",
                    "scatter": [
                        "#main/workflow_microbial_annotation_bins/genome_fasta"
                    ],
                    "scatterMethod": "dotproduct",
                    "in": [
                        {
                            "source": "#main/annotate_bins",
                            "id": "#main/workflow_microbial_annotation_bins/annotate_bins"
                        },
                        {
                            "source": "#main/bakta_db",
                            "id": "#main/workflow_microbial_annotation_bins/bakta_db"
                        },
                        {
                            "default": true,
                            "id": "#main/workflow_microbial_annotation_bins/compress_output"
                        },
                        {
                            "source": "#main/eggnog_dbs",
                            "id": "#main/workflow_microbial_annotation_bins/eggnog_dbs"
                        },
                        {
                            "source": "#main/binette_bins/files",
                            "default": [],
                            "id": "#main/workflow_microbial_annotation_bins/genome_fasta"
                        },
                        {
                            "source": "#main/interproscan_applications",
                            "id": "#main/workflow_microbial_annotation_bins/interproscan_applications"
                        },
                        {
                            "source": "#main/interproscan_directory",
                            "id": "#main/workflow_microbial_annotation_bins/interproscan_directory"
                        },
                        {
                            "source": "#main/kofamscan_limit_sapp",
                            "id": "#main/workflow_microbial_annotation_bins/kofamscan_limit_sapp"
                        },
                        {
                            "source": "#main/run_eggnog",
                            "id": "#main/workflow_microbial_annotation_bins/run_eggnog"
                        },
                        {
                            "source": "#main/run_interproscan",
                            "id": "#main/workflow_microbial_annotation_bins/run_interproscan"
                        },
                        {
                            "source": "#main/run_kofamscan",
                            "id": "#main/workflow_microbial_annotation_bins/run_kofamscan"
                        },
                        {
                            "default": true,
                            "id": "#main/workflow_microbial_annotation_bins/sapp_conversion"
                        },
                        {
                            "source": "#main/skip_bakta_crispr",
                            "id": "#main/workflow_microbial_annotation_bins/skip_bakta_crispr"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/workflow_microbial_annotation_bins/threads"
                        }
                    ],
                    "out": [
                        "#main/workflow_microbial_annotation_bins/bakta_folder_compressed",
                        "#main/workflow_microbial_annotation_bins/compressed_other_files",
                        "#main/workflow_microbial_annotation_bins/sapp_hdt_file"
                    ],
                    "id": "#main/workflow_microbial_annotation_bins"
                },
                {
                    "doc": "Microbial annotation workflow of the predicted bins",
                    "label": "Annotate bins",
                    "when": "$(inputs.annotate_unbinned && inputs.genome_fasta !== null)",
                    "run": "#workflow_microbial_annotation.cwl",
                    "in": [
                        {
                            "source": "#main/annotate_unbinned",
                            "id": "#main/workflow_microbial_annotation_unbinned/annotate_unbinned"
                        },
                        {
                            "source": "#main/bakta_db",
                            "id": "#main/workflow_microbial_annotation_unbinned/bakta_db"
                        },
                        {
                            "default": true,
                            "id": "#main/workflow_microbial_annotation_unbinned/compress_output"
                        },
                        {
                            "source": "#main/eggnog_dbs",
                            "id": "#main/workflow_microbial_annotation_unbinned/eggnog_dbs"
                        },
                        {
                            "source": "#main/get_unbinned_contigs/unbinned_fasta",
                            "id": "#main/workflow_microbial_annotation_unbinned/genome_fasta"
                        },
                        {
                            "source": "#main/interproscan_applications",
                            "id": "#main/workflow_microbial_annotation_unbinned/interproscan_applications"
                        },
                        {
                            "source": "#main/interproscan_directory",
                            "id": "#main/workflow_microbial_annotation_unbinned/interproscan_directory"
                        },
                        {
                            "source": "#main/kofamscan_limit_sapp",
                            "id": "#main/workflow_microbial_annotation_unbinned/kofamscan_limit_sapp"
                        },
                        {
                            "default": true,
                            "id": "#main/workflow_microbial_annotation_unbinned/metagenome"
                        },
                        {
                            "source": "#main/run_eggnog",
                            "id": "#main/workflow_microbial_annotation_unbinned/run_eggnog"
                        },
                        {
                            "source": "#main/run_interproscan",
                            "id": "#main/workflow_microbial_annotation_unbinned/run_interproscan"
                        },
                        {
                            "source": "#main/run_kofamscan",
                            "id": "#main/workflow_microbial_annotation_unbinned/run_kofamscan"
                        },
                        {
                            "default": true,
                            "id": "#main/workflow_microbial_annotation_unbinned/sapp_conversion"
                        },
                        {
                            "source": "#main/skip_bakta_crispr",
                            "id": "#main/workflow_microbial_annotation_unbinned/skip_bakta_crispr"
                        },
                        {
                            "default": true,
                            "id": "#main/workflow_microbial_annotation_unbinned/skip_bakta_plot"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/workflow_microbial_annotation_unbinned/threads"
                        }
                    ],
                    "out": [
                        "#main/workflow_microbial_annotation_unbinned/bakta_folder_compressed",
                        "#main/workflow_microbial_annotation_unbinned/compressed_other_files",
                        "#main/workflow_microbial_annotation_unbinned/sapp_hdt_file"
                    ],
                    "id": "#main/workflow_microbial_annotation_unbinned"
                }
            ],
            "id": "#main",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateCreated": "2025-05-02",
            "https://schema.org/dateModified": "2025-09-05",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "Workflow",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "class": "MultipleInputFeatureRequirement"
                },
                {
                    "class": "ScatterFeatureRequirement"
                },
                {
                    "class": "StepInputExpressionRequirement"
                },
                {
                    "class": "SubworkflowFeatureRequirement"
                }
            ],
            "label": "Microbial (meta-) genome annotation",
            "doc": "Workflow for microbial genome annotation.",
            "outputs": [
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "outputSource": "#workflow_microbial_annotation.cwl/bakta_to_folder_compressed/results",
                    "id": "#workflow_microbial_annotation.cwl/bakta_folder_compressed"
                },
                {
                    "type": "Directory",
                    "outputSource": "#workflow_microbial_annotation.cwl/bakta_to_folder_uncompressed/results",
                    "id": "#workflow_microbial_annotation.cwl/bakta_folder_uncompressed"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "outputSource": "#workflow_microbial_annotation.cwl/compress_other/outfile",
                    "linkMerge": "merge_flattened",
                    "pickValue": "all_non_null",
                    "id": "#workflow_microbial_annotation.cwl/compressed_other_files"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputSource": "#workflow_microbial_annotation.cwl/workflow_sapp_conversion/hdt_file",
                    "id": "#workflow_microbial_annotation.cwl/sapp_hdt_file"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputSource": "#workflow_microbial_annotation.cwl/uncompressed_other/outfiles",
                    "id": "#workflow_microbial_annotation.cwl/uncompressed_other_files"
                }
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "label": "Bakta DB",
                    "doc": "Bakta database directory (default bakta-db_v5.1-light built in the container) (optional)\n",
                    "id": "#workflow_microbial_annotation.cwl/bakta_db"
                },
                {
                    "type": "int",
                    "default": 11,
                    "doc": "Codon table 11/4. Default = 11",
                    "label": "Codon table",
                    "id": "#workflow_microbial_annotation.cwl/codon_table"
                },
                {
                    "type": "boolean",
                    "doc": "Compress output files. Default false",
                    "default": false,
                    "id": "#workflow_microbial_annotation.cwl/compress_output"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "Output Destination (prov only)",
                    "doc": "Not used in this workflow. Output destination used in cwl-prov reporting only.",
                    "id": "#workflow_microbial_annotation.cwl/destination"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "record",
                            "name": "#workflow_microbial_annotation.cwl/eggnog_dbs/eggnog_dbs",
                            "fields": [
                                {
                                    "type": [
                                        "null",
                                        "Directory"
                                    ],
                                    "doc": "Directory containing all data files for the eggNOG database.",
                                    "name": "#workflow_microbial_annotation.cwl/eggnog_dbs/eggnog_dbs/data_dir"
                                },
                                {
                                    "type": [
                                        "null",
                                        "File"
                                    ],
                                    "doc": "eggNOG database file",
                                    "name": "#workflow_microbial_annotation.cwl/eggnog_dbs/eggnog_dbs/db"
                                },
                                {
                                    "type": [
                                        "null",
                                        "File"
                                    ],
                                    "doc": "eggNOG database file for diamond blast search",
                                    "name": "#workflow_microbial_annotation.cwl/eggnog_dbs/eggnog_dbs/diamond_db"
                                }
                            ]
                        }
                    ],
                    "id": "#workflow_microbial_annotation.cwl/eggnog_dbs"
                },
                {
                    "type": "File",
                    "label": "Genome fasta file",
                    "doc": "Genome fasta file used for annotation (required)",
                    "id": "#workflow_microbial_annotation.cwl/genome_fasta"
                },
                {
                    "type": "string",
                    "default": "Pfam",
                    "label": "Interproscan applications",
                    "doc": "Comma separated list of analyses:\nFunFam,SFLD,PANTHER,Gene3D,Hamap,PRINTS,ProSiteProfiles,Coils,SUPERFAMILY,SMART,CDD,PIRSR,ProSitePatterns,AntiFam,Pfam,MobiDBLite,PIRSF,NCBIfam\ndefault Pfam,SFLD,SMART,AntiFam,NCBIfam\n",
                    "id": "#workflow_microbial_annotation.cwl/interproscan_applications"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "label": "InterProScan 5 directory",
                    "doc": "Directory of the (full) InterProScan 5 program. When not given InterProscan will not run. (optional)",
                    "id": "#workflow_microbial_annotation.cwl/interproscan_directory"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "SAPP kofamscan filter",
                    "doc": "Limit max number of entries of kofamscan hits per locus in SAPP. Default 5",
                    "default": 5,
                    "id": "#workflow_microbial_annotation.cwl/kofamscan_limit_sapp"
                },
                {
                    "type": "boolean",
                    "label": "metagenome",
                    "doc": "Run in metagenome mode. Affects only protein prediction. Default false",
                    "default": false,
                    "id": "#workflow_microbial_annotation.cwl/metagenome"
                },
                {
                    "type": "boolean",
                    "label": "Run eggNOG-mapper",
                    "doc": "Run with eggNOG-mapper annotation. Requires eggnog database files. Default false",
                    "default": false,
                    "id": "#workflow_microbial_annotation.cwl/run_eggnog"
                },
                {
                    "type": "boolean",
                    "label": "Run InterProScan",
                    "doc": "Run with eggNOG-mapper annotation. Requires InterProScan v5 program files. Default false",
                    "default": false,
                    "id": "#workflow_microbial_annotation.cwl/run_interproscan"
                },
                {
                    "type": "boolean",
                    "label": "Run kofamscan",
                    "doc": "Run with KEGG KO KoFamKOALA annotation. Default false",
                    "default": false,
                    "id": "#workflow_microbial_annotation.cwl/run_kofamscan"
                },
                {
                    "type": "boolean",
                    "doc": "Run SAPP (Semantic Annotation Platform with Provenance) on the annotations. Default true",
                    "default": true,
                    "id": "#workflow_microbial_annotation.cwl/sapp_conversion"
                },
                {
                    "type": "boolean",
                    "label": "Skip bakta CRISPR array prediction using PILER-CR",
                    "doc": "Skip CRISPR prediction",
                    "default": false,
                    "id": "#workflow_microbial_annotation.cwl/skip_bakta_crispr"
                },
                {
                    "type": "boolean",
                    "label": "Skip plot",
                    "doc": "Skip Bakta plotting",
                    "default": false,
                    "id": "#workflow_microbial_annotation.cwl/skip_bakta_plot"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 4,
                    "doc": "Number of threads to use for computational processes. Default 4",
                    "label": "Number of threads",
                    "id": "#workflow_microbial_annotation.cwl/threads"
                }
            ],
            "steps": [
                {
                    "label": "Bakta",
                    "doc": "Bacterial genome annotation tool",
                    "when": "$(inputs.bakta_db !== null)",
                    "run": "#bakta.cwl",
                    "in": [
                        {
                            "source": "#workflow_microbial_annotation.cwl/bakta_db",
                            "id": "#workflow_microbial_annotation.cwl/bakta/db"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/genome_fasta",
                            "id": "#workflow_microbial_annotation.cwl/bakta/fasta_file"
                        },
                        {
                            "default": true,
                            "id": "#workflow_microbial_annotation.cwl/bakta/keep_contig_headers"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/metagenome",
                            "id": "#workflow_microbial_annotation.cwl/bakta/meta"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/skip_bakta_crispr",
                            "id": "#workflow_microbial_annotation.cwl/bakta/skip_crispr"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/skip_bakta_plot",
                            "id": "#workflow_microbial_annotation.cwl/bakta/skip_plot"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/threads",
                            "id": "#workflow_microbial_annotation.cwl/bakta/threads"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/codon_table",
                            "id": "#workflow_microbial_annotation.cwl/bakta/translation_table"
                        }
                    ],
                    "out": [
                        "#workflow_microbial_annotation.cwl/bakta/hypo_sequences_cds",
                        "#workflow_microbial_annotation.cwl/bakta/hypo_annotation_tsv",
                        "#workflow_microbial_annotation.cwl/bakta/annotation_tsv",
                        "#workflow_microbial_annotation.cwl/bakta/summary_txt",
                        "#workflow_microbial_annotation.cwl/bakta/annotation_json",
                        "#workflow_microbial_annotation.cwl/bakta/annotation_gff3",
                        "#workflow_microbial_annotation.cwl/bakta/annotation_gbff",
                        "#workflow_microbial_annotation.cwl/bakta/annotation_embl",
                        "#workflow_microbial_annotation.cwl/bakta/sequences_fna",
                        "#workflow_microbial_annotation.cwl/bakta/sequences_ffn",
                        "#workflow_microbial_annotation.cwl/bakta/sequences_cds",
                        "#workflow_microbial_annotation.cwl/bakta/plot_png",
                        "#workflow_microbial_annotation.cwl/bakta/plot_svg"
                    ],
                    "id": "#workflow_microbial_annotation.cwl/bakta"
                },
                {
                    "label": "Compressed Bakta folder",
                    "doc": "Move all compressed bakta files to a folder",
                    "run": "#files_to_folder.cwl",
                    "when": "$(inputs.compress_output)",
                    "in": [
                        {
                            "source": "#workflow_microbial_annotation.cwl/compress_output",
                            "id": "#workflow_microbial_annotation.cwl/bakta_to_folder_compressed/compress_output"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/genome_fasta",
                            "valueFrom": "$(\"bakta_\"+self.nameroot)",
                            "id": "#workflow_microbial_annotation.cwl/bakta_to_folder_compressed/destination"
                        },
                        {
                            "source": [
                                "#workflow_microbial_annotation.cwl/compress_bakta/outfile",
                                "#workflow_microbial_annotation.cwl/bakta/plot_png"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#workflow_microbial_annotation.cwl/bakta_to_folder_compressed/files"
                        }
                    ],
                    "out": [
                        "#workflow_microbial_annotation.cwl/bakta_to_folder_compressed/results"
                    ],
                    "id": "#workflow_microbial_annotation.cwl/bakta_to_folder_compressed"
                },
                {
                    "label": "Uncompressed Bakta folder",
                    "doc": "Move all uncompressed bakta files to a folder",
                    "run": "#files_to_folder.cwl",
                    "when": "$(inputs.compress_output == false)",
                    "in": [
                        {
                            "source": "#workflow_microbial_annotation.cwl/compress_output",
                            "id": "#workflow_microbial_annotation.cwl/bakta_to_folder_uncompressed/compress_output"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/genome_fasta",
                            "valueFrom": "$(\"bakta_\"+self.nameroot)",
                            "id": "#workflow_microbial_annotation.cwl/bakta_to_folder_uncompressed/destination"
                        },
                        {
                            "source": [
                                "#workflow_microbial_annotation.cwl/bakta/hypo_sequences_cds",
                                "#workflow_microbial_annotation.cwl/bakta/hypo_annotation_tsv",
                                "#workflow_microbial_annotation.cwl/bakta/annotation_tsv",
                                "#workflow_microbial_annotation.cwl/bakta/summary_txt",
                                "#workflow_microbial_annotation.cwl/bakta/annotation_json",
                                "#workflow_microbial_annotation.cwl/bakta/annotation_gff3",
                                "#workflow_microbial_annotation.cwl/bakta/annotation_gbff",
                                "#workflow_microbial_annotation.cwl/bakta/annotation_embl",
                                "#workflow_microbial_annotation.cwl/bakta/sequences_fna",
                                "#workflow_microbial_annotation.cwl/bakta/sequences_ffn",
                                "#workflow_microbial_annotation.cwl/bakta/sequences_cds",
                                "#workflow_microbial_annotation.cwl/bakta/plot_svg",
                                "#workflow_microbial_annotation.cwl/bakta/plot_png"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#workflow_microbial_annotation.cwl/bakta_to_folder_uncompressed/files"
                        }
                    ],
                    "out": [
                        "#workflow_microbial_annotation.cwl/bakta_to_folder_uncompressed/results"
                    ],
                    "id": "#workflow_microbial_annotation.cwl/bakta_to_folder_uncompressed"
                },
                {
                    "label": "Compress Bakta",
                    "run": "#pigz.cwl",
                    "when": "$(inputs.compress_output)",
                    "scatter": [
                        "#workflow_microbial_annotation.cwl/compress_bakta/inputfile"
                    ],
                    "scatterMethod": "dotproduct",
                    "in": [
                        {
                            "source": "#workflow_microbial_annotation.cwl/compress_output",
                            "id": "#workflow_microbial_annotation.cwl/compress_bakta/compress_output"
                        },
                        {
                            "source": [
                                "#workflow_microbial_annotation.cwl/bakta/hypo_sequences_cds",
                                "#workflow_microbial_annotation.cwl/bakta/hypo_annotation_tsv",
                                "#workflow_microbial_annotation.cwl/bakta/annotation_tsv",
                                "#workflow_microbial_annotation.cwl/bakta/summary_txt",
                                "#workflow_microbial_annotation.cwl/bakta/annotation_json",
                                "#workflow_microbial_annotation.cwl/bakta/annotation_gff3",
                                "#workflow_microbial_annotation.cwl/bakta/annotation_gbff",
                                "#workflow_microbial_annotation.cwl/bakta/annotation_embl",
                                "#workflow_microbial_annotation.cwl/bakta/sequences_fna",
                                "#workflow_microbial_annotation.cwl/bakta/sequences_ffn",
                                "#workflow_microbial_annotation.cwl/bakta/sequences_cds",
                                "#workflow_microbial_annotation.cwl/bakta/plot_svg"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#workflow_microbial_annotation.cwl/compress_bakta/inputfile"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/threads",
                            "id": "#workflow_microbial_annotation.cwl/compress_bakta/threads"
                        }
                    ],
                    "out": [
                        "#workflow_microbial_annotation.cwl/compress_bakta/outfile"
                    ],
                    "id": "#workflow_microbial_annotation.cwl/compress_bakta"
                },
                {
                    "label": "Compressed other",
                    "doc": "Compress files when compression is true",
                    "when": "$(inputs.compress_output)",
                    "run": "#pigz.cwl",
                    "scatter": [
                        "#workflow_microbial_annotation.cwl/compress_other/inputfile"
                    ],
                    "scatterMethod": "dotproduct",
                    "in": [
                        {
                            "source": "#workflow_microbial_annotation.cwl/compress_output",
                            "id": "#workflow_microbial_annotation.cwl/compress_other/compress_output"
                        },
                        {
                            "source": [
                                "#workflow_microbial_annotation.cwl/kofamscan/output",
                                "#workflow_microbial_annotation.cwl/interproscan/json_annotations",
                                "#workflow_microbial_annotation.cwl/interproscan/tsv_annotations",
                                "#workflow_microbial_annotation.cwl/eggnogmapper/output_annotations",
                                "#workflow_microbial_annotation.cwl/eggnogmapper/output_orthologs"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#workflow_microbial_annotation.cwl/compress_other/inputfile"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/threads",
                            "id": "#workflow_microbial_annotation.cwl/compress_other/threads"
                        }
                    ],
                    "out": [
                        "#workflow_microbial_annotation.cwl/compress_other/outfile"
                    ],
                    "id": "#workflow_microbial_annotation.cwl/compress_other"
                },
                {
                    "label": "eggNOG-mapper",
                    "when": "$(inputs.run_eggnog && inputs.eggnog !== null && inputs.input_fasta.size > 1024)",
                    "run": "#eggnog-mapper.cwl",
                    "in": [
                        {
                            "source": "#workflow_microbial_annotation.cwl/threads",
                            "id": "#workflow_microbial_annotation.cwl/eggnogmapper/cpu"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/eggnog_dbs",
                            "id": "#workflow_microbial_annotation.cwl/eggnogmapper/eggnog_dbs"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/bakta/sequences_cds",
                            "id": "#workflow_microbial_annotation.cwl/eggnogmapper/input_fasta"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/run_eggnog",
                            "id": "#workflow_microbial_annotation.cwl/eggnogmapper/run_eggnog"
                        }
                    ],
                    "out": [
                        "#workflow_microbial_annotation.cwl/eggnogmapper/output_annotations",
                        "#workflow_microbial_annotation.cwl/eggnogmapper/output_orthologs"
                    ],
                    "id": "#workflow_microbial_annotation.cwl/eggnogmapper"
                },
                {
                    "label": "InterProScan 5",
                    "when": "$(inputs.run_interproscan && inputs.interproscan_directory !== null && inputs.protein_fasta.size > 1024)",
                    "run": "#interproscan_v5.cwl",
                    "in": [
                        {
                            "source": "#workflow_microbial_annotation.cwl/interproscan_applications",
                            "id": "#workflow_microbial_annotation.cwl/interproscan/applications"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/interproscan_directory",
                            "id": "#workflow_microbial_annotation.cwl/interproscan/interproscan_directory"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/bakta/sequences_cds",
                            "id": "#workflow_microbial_annotation.cwl/interproscan/protein_fasta"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/run_interproscan",
                            "id": "#workflow_microbial_annotation.cwl/interproscan/run_interproscan"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/threads",
                            "id": "#workflow_microbial_annotation.cwl/interproscan/threads"
                        }
                    ],
                    "out": [
                        "#workflow_microbial_annotation.cwl/interproscan/tsv_annotations",
                        "#workflow_microbial_annotation.cwl/interproscan/json_annotations"
                    ],
                    "id": "#workflow_microbial_annotation.cwl/interproscan"
                },
                {
                    "label": "KofamScan",
                    "when": "$(inputs.run_kofamscan && inputs.input_fasta.size > 1024)",
                    "run": "#kofamscan.cwl",
                    "in": [
                        {
                            "source": "#workflow_microbial_annotation.cwl/bakta/sequences_cds",
                            "id": "#workflow_microbial_annotation.cwl/kofamscan/input_fasta"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/run_kofamscan",
                            "id": "#workflow_microbial_annotation.cwl/kofamscan/run_kofamscan"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/threads",
                            "id": "#workflow_microbial_annotation.cwl/kofamscan/threads"
                        }
                    ],
                    "out": [
                        "#workflow_microbial_annotation.cwl/kofamscan/output"
                    ],
                    "id": "#workflow_microbial_annotation.cwl/kofamscan"
                },
                {
                    "label": "Uncompressed other",
                    "doc": "Gather files when compression is false",
                    "when": "$(inputs.compress_output == false)",
                    "run": {
                        "class": "ExpressionTool",
                        "requirements": [
                            {
                                "class": "InlineJavascriptRequirement"
                            }
                        ],
                        "inputs": [
                            {
                                "type": {
                                    "type": "array",
                                    "items": "File"
                                },
                                "id": "#workflow_microbial_annotation.cwl/uncompressed_other/run/files"
                            }
                        ],
                        "outputs": [
                            {
                                "type": {
                                    "type": "array",
                                    "items": "File"
                                },
                                "id": "#workflow_microbial_annotation.cwl/uncompressed_other/run/outfiles"
                            }
                        ],
                        "expression": "${return {'outfiles': inputs.files} }\n"
                    },
                    "in": [
                        {
                            "source": "#workflow_microbial_annotation.cwl/compress_output",
                            "id": "#workflow_microbial_annotation.cwl/uncompressed_other/compress_output"
                        },
                        {
                            "source": [
                                "#workflow_microbial_annotation.cwl/kofamscan/output",
                                "#workflow_microbial_annotation.cwl/interproscan/json_annotations",
                                "#workflow_microbial_annotation.cwl/interproscan/tsv_annotations",
                                "#workflow_microbial_annotation.cwl/eggnogmapper/output_annotations",
                                "#workflow_microbial_annotation.cwl/eggnogmapper/output_orthologs"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#workflow_microbial_annotation.cwl/uncompressed_other/files"
                        }
                    ],
                    "out": [
                        "#workflow_microbial_annotation.cwl/uncompressed_other/outfiles"
                    ],
                    "id": "#workflow_microbial_annotation.cwl/uncompressed_other"
                },
                {
                    "label": "SAPP conversion",
                    "doc": "Convert annotation output to SAPP (RDF) format",
                    "when": "$(inputs.sapp_conversion && inputs.embl_file.size > 1024)",
                    "run": "#workflow_sapp_conversion.cwl",
                    "in": [
                        {
                            "source": "#workflow_microbial_annotation.cwl/bakta/annotation_embl",
                            "id": "#workflow_microbial_annotation.cwl/workflow_sapp_conversion/embl_file"
                        },
                        {
                            "valueFrom": "$(inputs.embl_file.nameroot)",
                            "id": "#workflow_microbial_annotation.cwl/workflow_sapp_conversion/identifier"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/interproscan/json_annotations",
                            "id": "#workflow_microbial_annotation.cwl/workflow_sapp_conversion/interproscan_output"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/kofamscan_limit_sapp",
                            "id": "#workflow_microbial_annotation.cwl/workflow_sapp_conversion/kofamscan_limit"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/kofamscan/output",
                            "id": "#workflow_microbial_annotation.cwl/workflow_sapp_conversion/kofamscan_output"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/sapp_conversion",
                            "id": "#workflow_microbial_annotation.cwl/workflow_sapp_conversion/sapp_conversion"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/threads",
                            "id": "#workflow_microbial_annotation.cwl/workflow_sapp_conversion/threads"
                        }
                    ],
                    "out": [
                        "#workflow_microbial_annotation.cwl/workflow_sapp_conversion/hdt_file"
                    ],
                    "id": "#workflow_microbial_annotation.cwl/workflow_sapp_conversion"
                }
            ],
            "id": "#workflow_microbial_annotation.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateCreated": "2020-00-00",
            "https://schema.org/dateModified": "2025-08-04",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "Workflow",
            "requirements": [
                {
                    "class": "StepInputExpressionRequirement"
                },
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "class": "MultipleInputFeatureRequirement"
                }
            ],
            "label": "SAPP conversion Workflow",
            "doc": "Workflow for converting annotation tool output into a GBOL RDF file (TTL/HDT) using SAPP.\nCurrent implemented tools:\n    - Bakta (embl)\n    - InterProScan\n    - eggNOG-mapper\n    - Kofamscan\n",
            "outputs": [
                {
                    "type": "File",
                    "doc": "Output directory",
                    "outputSource": "#workflow_sapp_conversion.cwl/compress_hdt/outfile",
                    "id": "#workflow_sapp_conversion.cwl/hdt_file"
                }
            ],
            "inputs": [
                {
                    "type": "int",
                    "doc": "The codon table used for gene prediction",
                    "label": "Codon table",
                    "default": 11,
                    "id": "#workflow_sapp_conversion.cwl/codon_table"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "Output Destination",
                    "doc": "Output destination used for cwl-prov reporting.",
                    "id": "#workflow_sapp_conversion.cwl/destination"
                },
                {
                    "label": "eggnog-mapper output",
                    "doc": "eggnog-mapper output file. Annotations tsv file (optional)",
                    "type": [
                        "null",
                        "File"
                    ],
                    "id": "#workflow_sapp_conversion.cwl/eggnog_output"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "id": "#workflow_sapp_conversion.cwl/embl_file"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "FASTA input file",
                    "doc": "Genome sequence in FASTA format",
                    "id": "#workflow_sapp_conversion.cwl/genome_fasta"
                },
                {
                    "type": "string",
                    "doc": "Identifier of the sample being converted",
                    "label": "Identifier",
                    "id": "#workflow_sapp_conversion.cwl/identifier"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "InterProScan output",
                    "doc": "InterProScan output file. JSON or TSV (optional)",
                    "id": "#workflow_sapp_conversion.cwl/interproscan_output"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "SAPP kofamscan filter",
                    "doc": "Limit the number of hits per locus tag to be converted (0=no limit) (optional). Default 0",
                    "id": "#workflow_sapp_conversion.cwl/kofamscan_limit"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "kofamscan output",
                    "doc": "KoFamScan / KoFamKOALA output file. detail-tsv (optional)",
                    "id": "#workflow_sapp_conversion.cwl/kofamscan_output"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 4,
                    "id": "#workflow_sapp_conversion.cwl/threads"
                }
            ],
            "steps": [
                {
                    "label": "Compress HDT",
                    "run": "#pigz.cwl",
                    "in": [
                        {
                            "source": "#workflow_sapp_conversion.cwl/turtle_to_hdt/hdt_output",
                            "id": "#workflow_sapp_conversion.cwl/compress_hdt/inputfile"
                        },
                        {
                            "source": "#workflow_sapp_conversion.cwl/threads",
                            "id": "#workflow_sapp_conversion.cwl/compress_hdt/threads"
                        }
                    ],
                    "out": [
                        "#workflow_sapp_conversion.cwl/compress_hdt/outfile"
                    ],
                    "id": "#workflow_sapp_conversion.cwl/compress_hdt"
                },
                {
                    "when": "$(inputs.embl != null)",
                    "run": "#conversion.cwl",
                    "in": [
                        {
                            "source": "#workflow_sapp_conversion.cwl/codon_table",
                            "id": "#workflow_sapp_conversion.cwl/embl_conversion/codon_table"
                        },
                        {
                            "source": "#workflow_sapp_conversion.cwl/embl_file",
                            "id": "#workflow_sapp_conversion.cwl/embl_conversion/embl"
                        },
                        {
                            "source": "#workflow_sapp_conversion.cwl/identifier",
                            "id": "#workflow_sapp_conversion.cwl/embl_conversion/identifier"
                        }
                    ],
                    "out": [
                        "#workflow_sapp_conversion.cwl/embl_conversion/output"
                    ],
                    "id": "#workflow_sapp_conversion.cwl/embl_conversion"
                },
                {
                    "when": "$(inputs.fasta != null)",
                    "run": "#conversion.cwl",
                    "in": [
                        {
                            "source": "#workflow_sapp_conversion.cwl/codon_table",
                            "id": "#workflow_sapp_conversion.cwl/genome_conversion/codon_table"
                        },
                        {
                            "source": "#workflow_sapp_conversion.cwl/genome_fasta",
                            "id": "#workflow_sapp_conversion.cwl/genome_conversion/fasta"
                        },
                        {
                            "source": "#workflow_sapp_conversion.cwl/identifier",
                            "id": "#workflow_sapp_conversion.cwl/genome_conversion/identifier"
                        }
                    ],
                    "out": [
                        "#workflow_sapp_conversion.cwl/genome_conversion/output"
                    ],
                    "id": "#workflow_sapp_conversion.cwl/genome_conversion"
                },
                {
                    "label": "eggNOG conversion",
                    "when": "$(inputs.resultfile !== null)",
                    "run": "#conversion_eggnog.cwl",
                    "in": [
                        {
                            "source": "#workflow_sapp_conversion.cwl/identifier",
                            "id": "#workflow_sapp_conversion.cwl/sapp_eggnog/output_prefix"
                        },
                        {
                            "source": [
                                "#workflow_sapp_conversion.cwl/sapp_interproscan/interproscan_ttl",
                                "#workflow_sapp_conversion.cwl/sapp_kofamscan/kofamscan_ttl",
                                "#workflow_sapp_conversion.cwl/embl_conversion/output"
                            ],
                            "pickValue": "first_non_null",
                            "id": "#workflow_sapp_conversion.cwl/sapp_eggnog/rdf"
                        },
                        {
                            "source": "#workflow_sapp_conversion.cwl/eggnog_output",
                            "id": "#workflow_sapp_conversion.cwl/sapp_eggnog/resultfile"
                        }
                    ],
                    "out": [
                        "#workflow_sapp_conversion.cwl/sapp_eggnog/eggnog_ttl"
                    ],
                    "id": "#workflow_sapp_conversion.cwl/sapp_eggnog"
                },
                {
                    "label": "InterProScan conversion",
                    "when": "$(inputs.resultfile !== null)",
                    "run": "#conversion_interproscan.cwl",
                    "in": [
                        {
                            "source": "#workflow_sapp_conversion.cwl/identifier",
                            "id": "#workflow_sapp_conversion.cwl/sapp_interproscan/output_prefix"
                        },
                        {
                            "source": [
                                "#workflow_sapp_conversion.cwl/sapp_kofamscan/kofamscan_ttl",
                                "#workflow_sapp_conversion.cwl/embl_conversion/output"
                            ],
                            "pickValue": "first_non_null",
                            "id": "#workflow_sapp_conversion.cwl/sapp_interproscan/rdf"
                        },
                        {
                            "source": "#workflow_sapp_conversion.cwl/interproscan_output",
                            "id": "#workflow_sapp_conversion.cwl/sapp_interproscan/resultfile"
                        }
                    ],
                    "out": [
                        "#workflow_sapp_conversion.cwl/sapp_interproscan/interproscan_ttl"
                    ],
                    "id": "#workflow_sapp_conversion.cwl/sapp_interproscan"
                },
                {
                    "label": "Kofamscan conversion",
                    "when": "$(inputs.resultfile !== null)",
                    "run": "#conversion_kofamscan.cwl",
                    "in": [
                        {
                            "source": "#workflow_sapp_conversion.cwl/kofamscan_limit",
                            "id": "#workflow_sapp_conversion.cwl/sapp_kofamscan/limit"
                        },
                        {
                            "source": "#workflow_sapp_conversion.cwl/identifier",
                            "id": "#workflow_sapp_conversion.cwl/sapp_kofamscan/output_prefix"
                        },
                        {
                            "source": "#workflow_sapp_conversion.cwl/embl_conversion/output",
                            "id": "#workflow_sapp_conversion.cwl/sapp_kofamscan/rdf"
                        },
                        {
                            "source": "#workflow_sapp_conversion.cwl/kofamscan_output",
                            "id": "#workflow_sapp_conversion.cwl/sapp_kofamscan/resultfile"
                        }
                    ],
                    "out": [
                        "#workflow_sapp_conversion.cwl/sapp_kofamscan/kofamscan_ttl"
                    ],
                    "id": "#workflow_sapp_conversion.cwl/sapp_kofamscan"
                },
                {
                    "label": "TTL to HDT",
                    "run": "#toHDT.cwl",
                    "in": [
                        {
                            "source": [
                                "#workflow_sapp_conversion.cwl/sapp_eggnog/eggnog_ttl",
                                "#workflow_sapp_conversion.cwl/sapp_interproscan/interproscan_ttl",
                                "#workflow_sapp_conversion.cwl/sapp_kofamscan/kofamscan_ttl",
                                "#workflow_sapp_conversion.cwl/embl_conversion/output"
                            ],
                            "pickValue": "first_non_null",
                            "id": "#workflow_sapp_conversion.cwl/turtle_to_hdt/input"
                        },
                        {
                            "source": "#workflow_sapp_conversion.cwl/identifier",
                            "valueFrom": "$(self).SAPP.hdt",
                            "id": "#workflow_sapp_conversion.cwl/turtle_to_hdt/output"
                        }
                    ],
                    "out": [
                        "#workflow_sapp_conversion.cwl/turtle_to_hdt/hdt_output"
                    ],
                    "id": "#workflow_sapp_conversion.cwl/turtle_to_hdt"
                }
            ],
            "id": "#workflow_sapp_conversion.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateCreated": "2021-00-00",
            "https://schema.org/dateModified": "2025-05-05",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        }
    ],
    "cwlVersion": "v1.2",
    "$schemas": [
        "http://edamontology.org/EDAM_1.20.owl",
        "http://edamontology.org/EDAM_1.16.owl",
        "https://schema.org/version/latest/schemaorg-current-https.rdf",
        "http://edamontology.org/EDAM_1.18.owl",
        "https://schema.org/version/latest/schemaorg-current-http.rdf"
    ],
    "$namespaces": {
        "s": "https://schema.org/"
    }
}
