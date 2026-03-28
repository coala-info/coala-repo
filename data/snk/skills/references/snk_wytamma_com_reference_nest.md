[ ]
[ ]

[Skip to content](#snk.nest)

snk

Nest

Initializing search

[GitHub](https://github.com/Wytamma/snk "Go to repository")

snk

[GitHub](https://github.com/Wytamma/snk "Go to repository")

* [Home](../..)
* [Managing Workflows](../../managing_workflows/)
* [Snk Config File](../../snk_config_file/)
* [Workflow Packages](../../workflow_packages/)
* [x]

  Reference

  Reference
  + [ ]

    Nest

    [Nest](./)

    Table of contents
    - [snk.nest](#snk.nest)
    - [Nest](#snk.nest.Nest)

      * [\_\_init\_\_()](#snk.nest.Nest.__init__)
      * [additional\_resources()](#snk.nest.Nest.additional_resources)
      * [check\_for\_snakemake\_min\_version()](#snk.nest.Nest.check_for_snakemake_min_version)
      * [check\_for\_snk\_cli\_min\_version()](#snk.nest.Nest.check_for_snk_cli_min_version)
      * [copy\_nonstandard\_config()](#snk.nest.Nest.copy_nonstandard_config)
      * [create\_virtual\_environment()](#snk.nest.Nest.create_virtual_environment)
      * [delete\_paths()](#snk.nest.Nest.delete_paths)
      * [download()](#snk.nest.Nest.download)
      * [get\_paths\_to\_delete()](#snk.nest.Nest.get_paths_to_delete)
      * [install()](#snk.nest.Nest.install)
      * [link\_workflow\_executable\_to\_bin()](#snk.nest.Nest.link_workflow_executable_to_bin)
      * [local()](#snk.nest.Nest.local)
      * [modify\_snk\_config()](#snk.nest.Nest.modify_snk_config)
      * [uninstall()](#snk.nest.Nest.uninstall)
      * [validate\_Snakemake\_repo()](#snk.nest.Nest.validate_Snakemake_repo)
* [ ]

  Snk cli

  Snk cli
  + [The Snk CLI](../../snk-cli/)
  + [Config](../../snk-cli/config/)
  + [Env](../../snk-cli/env/)
  + [Info](../../snk-cli/info/)
  + [Profile](../../snk-cli/profile/)
  + [Run](../../snk-cli/run/)
  + [Script](../../snk-cli/script/)

Table of contents

* [snk.nest](#snk.nest)
* [Nest](#snk.nest.Nest)

  + [\_\_init\_\_()](#snk.nest.Nest.__init__)
  + [additional\_resources()](#snk.nest.Nest.additional_resources)
  + [check\_for\_snakemake\_min\_version()](#snk.nest.Nest.check_for_snakemake_min_version)
  + [check\_for\_snk\_cli\_min\_version()](#snk.nest.Nest.check_for_snk_cli_min_version)
  + [copy\_nonstandard\_config()](#snk.nest.Nest.copy_nonstandard_config)
  + [create\_virtual\_environment()](#snk.nest.Nest.create_virtual_environment)
  + [delete\_paths()](#snk.nest.Nest.delete_paths)
  + [download()](#snk.nest.Nest.download)
  + [get\_paths\_to\_delete()](#snk.nest.Nest.get_paths_to_delete)
  + [install()](#snk.nest.Nest.install)
  + [link\_workflow\_executable\_to\_bin()](#snk.nest.Nest.link_workflow_executable_to_bin)
  + [local()](#snk.nest.Nest.local)
  + [modify\_snk\_config()](#snk.nest.Nest.modify_snk_config)
  + [uninstall()](#snk.nest.Nest.uninstall)
  + [validate\_Snakemake\_repo()](#snk.nest.Nest.validate_Snakemake_repo)

# Nest

## `Nest`

Initializes a Nest object.

**Parameters:**

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `snk_home` | `Path` | The path to the SNK home directory. Defaults to None. | `None` |
| `bin_dir` | `Path` | The path to the bin directory. Defaults to None. | `None` |

Side Effects

Creates the SNK home and bin directories if they do not exist.

**Examples:**

```
>>> nest = Nest()
```

Source code in `snk/nest.py`

|  |  |
| --- | --- |
| ```  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39  40  41  42  43  44  45  46  47  48  49  50  51  52  53  54  55  56  57  58  59  60  61  62  63  64  65  66  67  68  69  70  71  72  73  74  75  76  77  78  79  80  81  82  83  84  85  86  87  88  89  90  91  92  93  94  95  96  97  98  99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256 257 258 259 260 261 262 263 264 265 266 267 268 269 270 271 272 273 274 275 276 277 278 279 280 281 282 283 284 285 286 287 288 289 290 291 292 293 294 295 296 297 298 299 300 301 302 303 304 305 306 307 308 309 310 311 312 313 314 315 316 317 318 319 320 321 322 323 324 325 326 327 328 329 330 331 332 333 334 335 336 337 338 339 340 341 342 343 344 345 346 347 348 349 350 351 352 353 354 355 356 357 358 359 360 361 362 363 364 365 366 367 368 369 370 371 372 373 374 375 376 377 378 379 380 381 382 383 384 385 386 387 388 389 390 391 392 393 394 395 396 397 398 399 400 401 402 403 404 405 406 407 408 409 410 411 412 413 414 415 416 417 418 419 420 421 422 423 424 425 426 427 428 429 430 431 432 433 434 435 436 437 438 439 440 441 442 443 444 445 446 447 448 449 450 451 452 453 454 455 456 457 458 459 460 461 462 463 464 465 466 467 468 469 470 471 472 473 474 475 476 477 478 479 480 481 482 483 484 485 486 487 488 489 490 491 492 493 494 495 496 497 498 499 500 501 502 503 504 505 506 507 508 509 510 511 512 513 514 515 516 517 518 519 520 521 522 523 524 525 526 527 528 529 530 531 532 533 534 535 536 537 538 539 540 541 542 543 544 545 546 547 548 549 550 551 552 553 554 555 556 557 558 559 560 561 562 563 564 565 566 567 568 569 570 571 572 573 574 575 576 577 578 579 580 581 582 583 584 585 586 587 588 589 590 591 592 593 594 595 596 597 598 599 600 601 602 603 604 605 606 607 608 609 610 611 612 613 614 615 616 617 618 619 620 621 622 623 624 625 626 627 628 629 630 631 632 633 634 635 636 637 638 639 640 641 642 643 644 645 646 647 648 649 650 651 652 653 654 655 656 657 658 659 660 661 662 663 664 665 666 667 668 669 670 671 672 673 674 675 676 677 678 679 680 681 682 683 684 685 686 687 688 689 690 691 692 693 694 695 696 697 698 699 700 701 702 703 704 705 706 707 708 709 710 711 712 713 714 715 716 717 718 719 720 721 722 723 724 725 726 727 728 729 730 731 732 733 734 735 736 737 738 739 740 741 742 743 744 745 746 747 748 749 750 751 752 753 754 755 756 757 758 759 760 761 762 763 764 765 766 767 768 769 770 771 772 773 774 775 776 777 778 779 780 781 782 783 784 785 786 ``` | ``` class Nest:     """     Initializes a Nest object.      Args:       snk_home (Path, optional): The path to the SNK home directory. Defaults to None.       bin_dir (Path, optional): The path to the bin directory. Defaults to None.      Side Effects:       Creates the SNK home and bin directories if they do not exist.      Examples:       >>> nest = Nest()     """      def __init__(self, snk_home: Path = None, bin_dir: Path = None) -> None:         """         Initializes a Nest object.          Args:           snk_home (Path, optional): The path to the SNK home directory. Defaults to None.           bin_dir (Path, optional): The path to the bin directory. Defaults to None.          Side Effects:           Creates the SNK home and bin directories if they do not exist.          Examples:           >>> nest = Nest()         """         self.python_interpreter_path = Path(             sys.executable         )  # needs to be the same python that has snk          if not snk_home:             home_path = self.python_interpreter_path.parent.parent             if not os.access(home_path, os.W_OK):                 user_home_path = Path("~").expanduser()                 snk_home = user_home_path / ".local" / "snk"             else:                 snk_home = home_path / "snk"          if not bin_dir:             bin_dir = self.python_interpreter_path.parent             if not os.access(bin_dir, os.W_OK):                 user_home_path = Path("~").expanduser()                 bin_dir = user_home_path / ".local" / "bin"          self.bin_dir = Path(bin_dir).absolute()         self.snk_home = Path(snk_home).absolute()         self.snk_workflows_dir = self.snk_home / "workflows"         self.snk_venv_dir = self.snk_home / "venvs"         self.snk_executable_dir = self.snk_home / "bin"          # Create dirs         self.snk_home.mkdir(parents=True, exist_ok=True)         self.snk_workflows_dir.mkdir(parents=True, exist_ok=True)         self.snk_executable_dir.mkdir(parents=True, exist_ok=True)         self.bin_dir.mkdir(parents=True, exist_ok=True)      def bin_dir_in_path(self) -> bool:         path_dirs = os.environ["PATH"].split(os.pathsep)         return str(self.bin_dir) in path_dirs      def _format_repo_url(self, repo: str):         """         Checks that the given repo URL is valid.          Args:           repo (str): The URL of the repo.          Raises:           InvalidWorkflowRepositoryError: If the repo URL is not valid.          Examples:           >>> nest._format_repo_url("https://github.com/example/repo.git")         """         if not repo.endswith(".git"):             repo += ".git"         if not repo.startswith("http"):             raise InvalidWorkflowRepositoryError("Repo url must start with http")         return repo      def install(         self,         workflow: str,         editable=False,         name=None,         tag=None,         commit=None,         config: Path = None,         snakefile: Path = None,         force=False,         additional_resources=[],         conda: bool = None,         snakemake_version=None,         dependencies=[],         isolate=False,     ) -> Workflow:         """         Installs a Snakemake workflow as a CLI.          Args:           workflow (str): The URL of the repo or the path to the local workflow.           editable (bool, optional): Whether to install the workflow in editable mode. Defaults to False.           name (str, optional): The name of the workflow. Defaults to None.           tag (str, optional): The tag of the workflow. Defaults to None.           commit (str, optional): The commit SHA of the workflow. Defaults to None.           config (Path, optional): The path to the snakemake config file. Defaults to None.           snakefile (Path, optional): The path to the Snakefile. Defaults to None.           force (bool, optional): Whether to force the installation. Defaults to False.           additional_resources (list, optional): A list of resources additional to the resources folder to copy. Defaults to [].           conda (bool, optional): Modify the snk config file to control conda use. If None, will not modify the config file. Defaults to None.           snakemake_version (str, optional): The version of Snakemake to install in the virtual environment. Defaults to None.           dependencies (list, optional): A list of dependencies to install. Defaults to [].         Returns:           Workflow: The installed workflow.          Examples:           >>> nest.install(           ...     "https://github.com/example/repo.git", name="example", tag="v1.0.0"           ... )           >>> nest.install(           ...     "https://github.com/example/repo.git", name="example", commit="0123456"           ... )         """          def handle_force_installation(name: str):             try:                 self.uninstall(name=name, force=True)             except WorkflowNotFoundError:                 pass          workflow = str(workflow)  # ensure it is a string         try:             workflow = self._format_repo_url(workflow)             if not name:                 name = self._get_name_from_git_url(workflow)             if not force:                 self._check_workflow_name_available(name)             else:                 handle_force_installation(name)             workflow_path = self.download(workflow, name, tag_name=tag, commit=commit)         except WorkflowNotFoundError as e:             to_remove = self.get_paths_to_delete(name)             self.delete_paths(to_remove)             raise e         except InvalidWorkflowRepositoryError:             workflow_local_path = Path(workflow).resolve()             if workflow_local_path.is_file():                 raise InvalidWorkflowError(                     f"When installing a local workflow, the path must be a directory. Found: {workflow_local_path}"                 )             if (                 self.snk_workflows_dir.resolve().is_relative_to(workflow_local_path)                 and not editable             ):                 raise InvalidWorkflowError(                     f"The workflow directory contains SNK_HOME!\nWORKFLOW: {workflow_local_path}\nSNK_HOME: {self.snk_workflows_dir.resolve()}.\n\nTry installing the workflow with --editable."                 )             if not name:                 name = workflow_local_path.name             if not force:                 self._check_workflow_name_available(name)             else:                 handle_force_installation(name)             workflow_path = self.local(workflow_local_path, name, editable)         try:             self.validate_Snakemake_repo(workflow_path)             # update non standard files             if config:                 config_path = workflow_path / config                 if not config_path.exists():                     raise FileNotFoundError(f"Config file not found at {config_path}")                 self.modify_snk_config(workflow_path, configfile=config_path)             if snakefile:                 snakefile_path = workflow_path / snakefile                 if not snakefile_path.exists():                     raise FileNotFoundError(f"Snakefile not found at {snakefile_path}")                 self.modify_snk_config(workflow_path, snakefile=snakefile_path)             # set the version of the workflow             if editable:                 version = "editable"             elif tag:                 version = tag             elif commit:                 version = commit             else:                 try:                     repo = Repo(workflow_path)                     sha = repo.head.object.hexsha                     version = repo.git.rev_parse(sha, short=8)                 except Exception:                     version = None             self.modify_snk_config(workflow_path, version=version)             # check if we need to install snakemake in a virtual environment             snakemake_version_to_install_in_venv = None             snakemake_min_version = self.check_for_snakemake_min_version(workflow_path, snakefile)             if snakemake_version is not None:                 snakemake_version_to_install_in_venv = snakemake_version                 if parse_version(self._current_snakemake_version) < parse_version(                     snakemake_min_version                 ):                     # The current version of Snakemake is less than the minimum version required by the workflow                     snakemake_version_to_install_in_venv = f">={snakemake_min_version}"             min_snk_cli_version = self.check_for_snk_cli_min_version(workflow_path)             snk_cli_in_deps 