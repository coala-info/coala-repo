# memote CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| memote_history | Not completed | needs a git repository with commit history in the working directory; none exists in the container run |
| memote_new | Not completed | interactive template questions and a git clone of the cookiecutter template from GitHub; Docker has no network here |
| memote_online | Not completed | needs a GitHub account, token and network; uploads a repository to GitHub |
| memote_report_diff | PASS | E. coli core and iAB_RBC_283 SBML models: HTML diff report written and names both models |
| memote_report_history | Not completed | needs a git repository with commit history in the working directory; none exists in the container run |
| memote_report_snapshot | PASS | E. coli core SBML model: HTML report written and holds the model name and biomass flux 0.8739 |
| memote_run | PASS | E. coli core SBML model: result.json.gz holds 77 tests and the biomass flux 0.8739 matches the known value |

## memote_history

### Tool Description
Re-compute test results for the git branch history.

### Metadata
- **Docker Image**: quay.io/biocontainers/memote:0.17.0--pyhdfd78af_0
- **Homepage**: https://memote.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/memote/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/memote/overview
- **Total Downloads**: 1.4K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: memote history [OPTIONS] MODEL MESSAGE [COMMIT] ...

  Re-compute test results for the git branch history.

  MODEL is the path to the model file.

  MESSAGE is a commit message in case results were modified or added.

  [COMMIT] ... It is possible to list out individual commits that should be
  re-computed or supply a range <oldest commit>..<newest commit>, for example,

      memote history model.xml "chore: re-compute history" 6b84d05..cd49c85

  There are two distinct modes:

  1. Completely re-compute test results for each commit in the git history.
     This should only be necessary when memote is first used with existing
     model repositories.
  2. By giving memote specific commit hashes, it will re-compute test results
     for those only. This can also be achieved by supplying a commit range.

Options:
  -h, --help                      Show this message and exit.
  --rewrite / --no-rewrite        Whether to overwrite existing results.
  --location TEXT                 Location of test results. Can either by a
                                  directory or an rfc1738 compatible database
                                  URL.
  -a, --pytest-args TEXT          Any additional arguments you want to pass to
                                  pytest. Should be given as one continuous
                                  string.
  --deployment TEXT               Results will be read from and committed to
                                  the given branch.  [default: gh-pages]
  --solver [glpk|cplex|gurobi|glpk_exact|hybrid]
                                  Set the solver to be used.  [default: glpk]
  --solver-timeout INTEGER        Timeout in seconds to set on the
                                  mathematical optimization solver.
  --exclusive TEST                The name of a test or test module to be run
                                  exclusively. All other tests are skipped.
                                  This option can be used multiple times and
                                  takes precedence over '--skip'.
  --skip TEST                     The name of a test or test module to be
                                  skipped. This option can be used multiple
                                  times.
```


## memote_new

### Tool Description
Create a suitable model repository structure from a template.

### Metadata
- **Docker Image**: quay.io/biocontainers/memote:0.17.0--pyhdfd78af_0
- **Homepage**: https://memote.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/memote/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: memote new [OPTIONS]

  Create a suitable model repository structure from a template.

  By using a cookiecutter template, memote will ask you a couple of questions
  and set up a new directory structure that will make your life easier. The
  new directory will be placed in the current directory or respect the given
  --directory option.

Options:
  -h, --help             Show this message and exit.
  --replay               Create a memote repository using the exact same
                         answers as before. This will not overwrite existing
                         directories. If you want to adjust the answers, edit
                         the template
                         '/root/.cookiecutter_replay/cookiecutter-
                         memote.json'.
  --directory DIRECTORY  Create a new model repository in the given directory.
```


## memote_online

### Tool Description
Upload the repository to GitHub and create a gh-pages branch.

### Metadata
- **Docker Image**: quay.io/biocontainers/memote:0.17.0--pyhdfd78af_0
- **Homepage**: https://memote.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/memote/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: memote online [OPTIONS]

  Upload the repository to GitHub and create a gh-pages branch.

Options:
  -h, --help                Show this message and exit.
  --github-token TEXT       Personal access token on GitHub.
  --github_repository TEXT  The repository name on GitHub. Usually this is
                            configured for you.
  --deployment TEXT         Deployment branch to be pushed. Usually this is
                            configured for you.
```


## memote_run

### Tool Description
Run the test suite on a single model and collect results.

### Metadata
- **Docker Image**: quay.io/biocontainers/memote:0.17.0--pyhdfd78af_0
- **Homepage**: https://memote.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/memote/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: memote run [OPTIONS] MODEL

  Run the test suite on a single model and collect results.

  MODEL: Path to model file. Can also be supplied via the environment variable
  MEMOTE_MODEL or configured in 'setup.cfg' or 'memote.ini'.

Options:
  -h, --help                      Show this message and exit.
  --collect / --no-collect        Whether or not to collect test data needed
                                  for generating a report.  [default: collect]
  --filename PATH                 Path for the collected results as JSON.
                                  Ignored when working with a git repository.
                                  [default: result.json.gz]
  --location TEXT                 If invoked inside a git repository, try to
                                  interpret the string as an rfc1738
                                  compatible database URL which will be used
                                  to store the test results. Otherwise write
                                  to this directory using the commit hash as
                                  the filename.
  --ignore-git                    Avoid checking the git repository status.
  -a, --pytest-args TEXT          Any additional arguments you want to pass to
                                  pytest. Should be given as one continuous
                                  string in quotes.
  --exclusive TEST                The name of a test or test module to be run
                                  exclusively. All other tests are skipped.
                                  This option can be used multiple times and
                                  takes precedence over '--skip'.
  --skip TEST                     The name of a test or test module to be
                                  skipped. This option can be used multiple
                                  times.
  --solver [glpk|cplex|gurobi|glpk_exact|hybrid]
                                  Set the solver to be used.  [default: glpk]
  --solver-timeout INTEGER        Timeout in seconds to set on the
                                  mathematical optimization solver.
  --experimental FILE             Define additional tests using experimental
                                  data.
  --custom-tests DIRECTORY        A path to a directory containing custom test
                                  modules. Please refer to the documentation
                                  for more information on how to write custom
                                  tests (memote.readthedocs.io). This option
                                  can be specified multiple times.
  --deployment TEXT               Results will be read from and committed to
                                  the given branch.  [default: gh-pages]
  --skip-unchanged                Skip memote run on commits where the model
                                  was not changed.
```


## memote_report_snapshot

### Tool Description
Take a snapshot of a model's state and generate a report.

### Metadata
- **Docker Image**: quay.io/biocontainers/memote:0.17.0--pyhdfd78af_0
- **Homepage**: https://memote.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/memote/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: memote report snapshot [OPTIONS] MODEL

  Take a snapshot of a model's state and generate a report.

  MODEL: Path to model file. Can also be supplied via the environment variable
  MEMOTE_MODEL or configured in 'setup.cfg' or 'memote.ini'.

Options:
  -h, --help                      Show this message and exit.
  --filename PATH                 Path for the HTML report output.  [default:
                                  index.html]
  -a, --pytest-args TEXT          Any additional arguments you want to pass to
                                  pytest. Should be given as one continuous
                                  string.
  --exclusive TEST                The name of a test or test module to be run
                                  exclusively. All other tests are skipped.
                                  This option can be used multiple times and
                                  takes precedence over '--skip'.
  --skip TEST                     The name of a test or test module to be
                                  skipped. This option can be used multiple
                                  times.
  --solver [glpk|cplex|gurobi|glpk_exact|hybrid]
                                  Set the solver to be used.  [default: glpk]
  --solver-timeout INTEGER        Timeout in seconds to set on the
                                  mathematical optimization solver.
  --experimental FILE             Define additional tests using experimental
                                  data.
  --custom-tests DIRECTORY        A path to a directory containing custom test
                                  modules. Please refer to the documentation
                                  for more information on how to write custom
                                  tests. May be specified multiple times.
  --custom-config FILE            A path to a report configuration file that
                                  will be merged into the default
                                  configuration. It's primary use is to
                                  configure the placement and scoring of
                                  custom tests but it can also alter the
                                  default behavior. Please refer to the
                                  documentation for the expected YAML format
                                  used. This option can be specified multiple
                                  times.
```

## memote_report_diff

### Tool Description
Take a snapshot of all the supplied models and generate a diff report.

### Metadata
- **Docker Image**: quay.io/biocontainers/memote:0.17.0--pyhdfd78af_0
- **Homepage**: https://memote.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/memote/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: memote report diff [OPTIONS] [MODELS]...

  Take a snapshot of all the supplied models and generate a diff report.

  MODELS: List of paths to two or more model files.

Options:
  -h, --help                      Show this message and exit.
  --filename PATH                 Path for the HTML report output.  [default:
                                  index.html]
  -a, --pytest-args TEXT          Any additional arguments you want to pass to
                                  pytest. Should be given as one continuous
                                  string.
  --exclusive TEST                The name of a test or test module to be run
                                  exclusively. All other tests are skipped.
                                  This option can be used multiple times and
                                  takes precedence over '--skip'.
  --skip TEST                     The name of a test or test module to be
                                  skipped. This option can be used multiple
                                  times.
  --solver [glpk|cplex|gurobi|glpk_exact|hybrid]
                                  Set the solver to be used.  [default: glpk]
  --solver-timeout INTEGER        Timeout in seconds to set on the
                                  mathematical optimization solver.
  --experimental FILE             Define additional tests using experimental
                                  data.
  --custom-tests DIRECTORY        A path to a directory containing custom test
                                  modules. Please refer to the documentation
                                  for more information on how to write custom
                                  tests (memote.readthedocs.io). This option
                                  can be specified multiple times.
  --custom-config FILE            A path to a report configuration file that
                                  will be merged into the default
                                  configuration. It's primary use is to
                                  configure the placement and scoring of
                                  custom tests but it can also alter the
                                  default behavior. Please refer to the
                                  documentation for the expected YAML format
                                  used (memote.readthedocs.io). This option
                                  can be specified multiple times.
```

## memote_report_history

### Tool Description
Generate a report over a model's git commit history.

### Metadata
- **Docker Image**: quay.io/biocontainers/memote:0.17.0--pyhdfd78af_0
- **Homepage**: https://memote.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/memote/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: memote report history [OPTIONS]

  Generate a report over a model's git commit history.

Options:
  -h, --help            Show this message and exit.
  --location TEXT       Location of test results. Can either by a directory or
                        an rfc1738 compatible database URL.
  --model TEXT          The path of the model file. Used to check if it was
                        modified.
  --filename PATH       Path for the HTML report output.  [default:
                        index.html]
  --deployment TEXT     Results will be read from and committed to the given
                        branch.  [default: gh-pages]
  --custom-config FILE  A path to a report configuration file that will be
                        merged into the default configuration. It's primary
                        use is to configure the placement and scoring of
                        custom tests but it can also alter the default
                        behavior. Please refer to the documentation for the
                        expected YAML format used. This option can be
                        specified multiple times.
```

## Metadata
- **Skill**: generated
