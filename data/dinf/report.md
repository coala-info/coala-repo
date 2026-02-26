# dinf CWL Generation Report

## dinf_check

### Tool Description
Basic dinf_model health checks.

Checks that the target and generator functions work and return the
same feature shapes and dtypes.

### Metadata
- **Docker Image**: quay.io/biocontainers/dinf:0.5.0--pyhdfd78af_0
- **Homepage**: https://github.com/RacimoLab/dinf
- **Package**: https://anaconda.org/channels/bioconda/packages/dinf/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dinf/overview
- **Total Downloads**: 7.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/RacimoLab/dinf
- **Stars**: N/A
### Original Help Text
```text
usage: dinf check [-h] [-v | -q] -m model.py

Basic dinf_model health checks.

Checks that the target and generator functions work and return the
same feature shapes and dtypes.

options:
  -h, --help            show this help message and exit
  -v, --verbose         Increase verbosity. Specify once for INFO messages and
                        twice for DEBUG messages. (default: 0)
  -q, --quiet           Disable output. Only ERROR and CRITICAL messages are
                        printed. (default: False)
  -m model.py, --model model.py
                        Python script from which to import the variable
                        "dinf_model". This is a dinf.DinfModel object that
                        describes the model components. See the examples/
                        folder of the git repository for example models.
                        https://github.com/RacimoLab/dinf (default: None)
```


## dinf_train

### Tool Description
Train a discriminator.

### Metadata
- **Docker Image**: quay.io/biocontainers/dinf:0.5.0--pyhdfd78af_0
- **Homepage**: https://github.com/RacimoLab/dinf
- **Package**: https://anaconda.org/channels/bioconda/packages/dinf/overview
- **Validation**: PASS

### Original Help Text
```text
usage: dinf train [-h] [-v | -q] [-S SEED] [-j PARALLELISM]
                  [-r TRAINING_REPLICATES] [-R TEST_REPLICATES] [-e EPOCHS] -m
                  model.py -d discriminator.nn

Train a discriminator.

options:
  -h, --help            show this help message and exit
  -v, --verbose         Increase verbosity. Specify once for INFO messages and
                        twice for DEBUG messages. (default: 0)
  -q, --quiet           Disable output. Only ERROR and CRITICAL messages are
                        printed. (default: False)

common arguments:
  -S SEED, --seed SEED  Seed for the random number generator. CPU-based
                        training is expected to produce deterministic results.
                        Results may differ between CPU and GPU trained
                        networks for the same seed value. Also note that
                        operations on a GPU are not fully determinstic, so
                        training or applying a neural network twice with the
                        same seed value will not produce identical results.
                        (default: None)
  -j PARALLELISM, --parallelism PARALLELISM
                        Number of processes to use for parallelising calls to
                        the DinfModel's generator_func and target_func. If not
                        specified, all CPU cores will be used. The number of
                        cores used for CPU-based neural networks is not set
                        with this parameter---instead use the`taskset`
                        command. See https://github.com/google/jax/issues/1539
                        (default: None)

training arguments:
  -r TRAINING_REPLICATES, --training-replicates TRAINING_REPLICATES
                        Size of the dataset used to train the discriminator.
                        (default: 1000)
  -R TEST_REPLICATES, --test-replicates TEST_REPLICATES
                        Size of the test dataset used to evaluate the
                        discriminator after each training epoch. (default:
                        1000)
  -e EPOCHS, --epochs EPOCHS
                        Number of full passes over the training dataset when
                        training the discriminator. (default: 1)

  -m model.py, --model model.py
                        Python script from which to import the variable
                        "dinf_model". This is a dinf.DinfModel object that
                        describes the model components. See the examples/
                        folder of the git repository for example models.
                        https://github.com/RacimoLab/dinf (default: None)
  -d discriminator.nn, --discriminator discriminator.nn
                        Output file where the discriminator will be saved.
                        (default: None)
```


## dinf_predict

### Tool Description
Make predictions using a trained discriminator.

### Metadata
- **Docker Image**: quay.io/biocontainers/dinf:0.5.0--pyhdfd78af_0
- **Homepage**: https://github.com/RacimoLab/dinf
- **Package**: https://anaconda.org/channels/bioconda/packages/dinf/overview
- **Validation**: PASS

### Original Help Text
```text
usage: dinf predict [-h] [-v | -q] [-S SEED] [-j PARALLELISM] [-r REPLICATES]
                    [--target] -m model.py -d discriminator.nn [-o output.npz]

Make predictions using a trained discriminator.

By default, features will be obtained by sampling replicates from
the generator (using parameters from the prior distribution).
To instead sample features from the target dataset, use the
--target option.

options:
  -h, --help            show this help message and exit
  -v, --verbose         Increase verbosity. Specify once for INFO messages and
                        twice for DEBUG messages. (default: 0)
  -q, --quiet           Disable output. Only ERROR and CRITICAL messages are
                        printed. (default: False)
  --target              Sample features from the target dataset. (default:
                        False)

common arguments:
  -S SEED, --seed SEED  Seed for the random number generator. CPU-based
                        training is expected to produce deterministic results.
                        Results may differ between CPU and GPU trained
                        networks for the same seed value. Also note that
                        operations on a GPU are not fully determinstic, so
                        training or applying a neural network twice with the
                        same seed value will not produce identical results.
                        (default: None)
  -j PARALLELISM, --parallelism PARALLELISM
                        Number of processes to use for parallelising calls to
                        the DinfModel's generator_func and target_func. If not
                        specified, all CPU cores will be used. The number of
                        cores used for CPU-based neural networks is not set
                        with this parameter---instead use the`taskset`
                        command. See https://github.com/google/jax/issues/1539
                        (default: None)

predict arguments:
  -r REPLICATES, --replicates REPLICATES
                        Number of theta replicates to generate and predict
                        with the discriminator. (default: 1000)

  -m model.py, --model model.py
                        Python script from which to import the variable
                        "dinf_model". This is a dinf.DinfModel object that
                        describes the model components. See the examples/
                        folder of the git repository for example models.
                        https://github.com/RacimoLab/dinf (default: None)
  -d discriminator.nn, --discriminator discriminator.nn
                        File containing discriminator network weights.
                        (default: None)
  -o output.npz, --output-file output.npz
                        Output data, matching thetas to discriminator
                        predictions. (default: None)
```


## dinf_mc

### Tool Description
Adversarial Monte Carlo.

### Metadata
- **Docker Image**: quay.io/biocontainers/dinf:0.5.0--pyhdfd78af_0
- **Homepage**: https://github.com/RacimoLab/dinf
- **Package**: https://anaconda.org/channels/bioconda/packages/dinf/overview
- **Validation**: PASS

### Original Help Text
```text
usage: dinf mc [-h] [-v | -q] [-S SEED] [-j PARALLELISM]
               [-r TRAINING_REPLICATES] [-R TEST_REPLICATES] [-e EPOCHS]
               [--top N] [-P PROPOSAL_REPLICATES] [-i ITERATIONS]
               [-o OUTPUT_FOLDER] -m model.py

Adversarial Monte Carlo.

In the first iteration, p[0] is the prior distribution.
The following steps are taken for iteration j:

  - sample training and proposal datasets from distribution p[j],
  - train the discriminator,
  - make predictions with the discriminator on the proposal dataset,
  - construct distribution p[j+1] as a weighted KDE of the proposals,
    where the weights are given by the discriminator predictions.

options:
  -h, --help            show this help message and exit
  -v, --verbose         Increase verbosity. Specify once for INFO messages and
                        twice for DEBUG messages. (default: 0)
  -q, --quiet           Disable output. Only ERROR and CRITICAL messages are
                        printed. (default: False)

common arguments:
  -S SEED, --seed SEED  Seed for the random number generator. CPU-based
                        training is expected to produce deterministic results.
                        Results may differ between CPU and GPU trained
                        networks for the same seed value. Also note that
                        operations on a GPU are not fully determinstic, so
                        training or applying a neural network twice with the
                        same seed value will not produce identical results.
                        (default: None)
  -j PARALLELISM, --parallelism PARALLELISM
                        Number of processes to use for parallelising calls to
                        the DinfModel's generator_func and target_func. If not
                        specified, all CPU cores will be used. The number of
                        cores used for CPU-based neural networks is not set
                        with this parameter---instead use the`taskset`
                        command. See https://github.com/google/jax/issues/1539
                        (default: None)

training arguments:
  -r TRAINING_REPLICATES, --training-replicates TRAINING_REPLICATES
                        Size of the dataset used to train the discriminator.
                        (default: 1000)
  -R TEST_REPLICATES, --test-replicates TEST_REPLICATES
                        Size of the test dataset used to evaluate the
                        discriminator after each training epoch. (default:
                        1000)
  -e EPOCHS, --epochs EPOCHS
                        Number of full passes over the training dataset when
                        training the discriminator. (default: 1)

SMC arguments:
  --top N               In each iteration, accept only the N top proposals,
                        ranked by discriminator prediction. (default: None)
  -P PROPOSAL_REPLICATES, --proposal-replicates PROPOSAL_REPLICATES
                        Number of replicates for Monte Carlo proposals.
                        (default: 1000)

GAN arguments:
  -i ITERATIONS, --iterations ITERATIONS
                        Number of iterations. (default: 1)
  -o OUTPUT_FOLDER, --output-folder OUTPUT_FOLDER
                        Folder to output results. If not specified, the
                        current directory will be used. (default: None)
  -m model.py, --model model.py
                        Python script from which to import the variable
                        "dinf_model". This is a dinf.DinfModel object that
                        describes the model components. See the examples/
                        folder of the git repository for example models.
                        https://github.com/RacimoLab/dinf (default: None)
```


## dinf_mcmc

### Tool Description
Adversarial MCMC.

### Metadata
- **Docker Image**: quay.io/biocontainers/dinf:0.5.0--pyhdfd78af_0
- **Homepage**: https://github.com/RacimoLab/dinf
- **Package**: https://anaconda.org/channels/bioconda/packages/dinf/overview
- **Validation**: PASS

### Original Help Text
```text
usage: dinf mcmc [-h] [-v | -q] [-S SEED] [-j PARALLELISM]
                 [-r TRAINING_REPLICATES] [-R TEST_REPLICATES] [-e EPOCHS]
                 [-w WALKERS] [-s STEPS] [--Dx-replicates DX_REPLICATES]
                 [-i ITERATIONS] [-o OUTPUT_FOLDER] -m model.py

Adversarial MCMC.

In the first iteration, p[0] is the prior distribution.
The following steps are taken for iteration j:

  - sample training dataset from the distribution p[j],
  - train the discriminator,
  - run the MCMC,
  - obtain distribution p[j+1] as a KDE of the MCMC sample.

options:
  -h, --help            show this help message and exit
  -v, --verbose         Increase verbosity. Specify once for INFO messages and
                        twice for DEBUG messages. (default: 0)
  -q, --quiet           Disable output. Only ERROR and CRITICAL messages are
                        printed. (default: False)

common arguments:
  -S SEED, --seed SEED  Seed for the random number generator. CPU-based
                        training is expected to produce deterministic results.
                        Results may differ between CPU and GPU trained
                        networks for the same seed value. Also note that
                        operations on a GPU are not fully determinstic, so
                        training or applying a neural network twice with the
                        same seed value will not produce identical results.
                        (default: None)
  -j PARALLELISM, --parallelism PARALLELISM
                        Number of processes to use for parallelising calls to
                        the DinfModel's generator_func and target_func. If not
                        specified, all CPU cores will be used. The number of
                        cores used for CPU-based neural networks is not set
                        with this parameter---instead use the`taskset`
                        command. See https://github.com/google/jax/issues/1539
                        (default: None)

training arguments:
  -r TRAINING_REPLICATES, --training-replicates TRAINING_REPLICATES
                        Size of the dataset used to train the discriminator.
                        (default: 1000)
  -R TEST_REPLICATES, --test-replicates TEST_REPLICATES
                        Size of the test dataset used to evaluate the
                        discriminator after each training epoch. (default:
                        1000)
  -e EPOCHS, --epochs EPOCHS
                        Number of full passes over the training dataset when
                        training the discriminator. (default: 1)

MCMC arguments:
  -w WALKERS, --walkers WALKERS
                        Number of independent MCMC chains. (default: 64)
  -s STEPS, --steps STEPS
                        The chain length for each MCMC walker. (default: 1000)
  --Dx-replicates DX_REPLICATES
                        Number of generator replicates for approximating
                        E[D(G(θ))]. (default: 32)

GAN arguments:
  -i ITERATIONS, --iterations ITERATIONS
                        Number of iterations. (default: 1)
  -o OUTPUT_FOLDER, --output-folder OUTPUT_FOLDER
                        Folder to output results. If not specified, the
                        current directory will be used. (default: None)
  -m model.py, --model model.py
                        Python script from which to import the variable
                        "dinf_model". This is a dinf.DinfModel object that
                        describes the model components. See the examples/
                        folder of the git repository for example models.
                        https://github.com/RacimoLab/dinf (default: None)
```


## dinf_pg-gan

### Tool Description
PG-GAN style simulated annealing.

### Metadata
- **Docker Image**: quay.io/biocontainers/dinf:0.5.0--pyhdfd78af_0
- **Homepage**: https://github.com/RacimoLab/dinf
- **Package**: https://anaconda.org/channels/bioconda/packages/dinf/overview
- **Validation**: PASS

### Original Help Text
```text
usage: dinf pg-gan [-h] [-v | -q] [-S SEED] [-j PARALLELISM]
                   [-r TRAINING_REPLICATES] [-R TEST_REPLICATES] [-e EPOCHS]
                   [--Dx-replicates DX_REPLICATES]
                   [--num-proposals NUM_PROPOSALS]
                   [--max-pretraining-iterations MAX_PRETRAINING_ITERATIONS]
                   [-i ITERATIONS] [-o OUTPUT_FOLDER] -m model.py

PG-GAN style simulated annealing.

options:
  -h, --help            show this help message and exit
  -v, --verbose         Increase verbosity. Specify once for INFO messages and
                        twice for DEBUG messages. (default: 0)
  -q, --quiet           Disable output. Only ERROR and CRITICAL messages are
                        printed. (default: False)

common arguments:
  -S SEED, --seed SEED  Seed for the random number generator. CPU-based
                        training is expected to produce deterministic results.
                        Results may differ between CPU and GPU trained
                        networks for the same seed value. Also note that
                        operations on a GPU are not fully determinstic, so
                        training or applying a neural network twice with the
                        same seed value will not produce identical results.
                        (default: None)
  -j PARALLELISM, --parallelism PARALLELISM
                        Number of processes to use for parallelising calls to
                        the DinfModel's generator_func and target_func. If not
                        specified, all CPU cores will be used. The number of
                        cores used for CPU-based neural networks is not set
                        with this parameter---instead use the`taskset`
                        command. See https://github.com/google/jax/issues/1539
                        (default: None)

training arguments:
  -r TRAINING_REPLICATES, --training-replicates TRAINING_REPLICATES
                        Size of the dataset used to train the discriminator.
                        (default: 1000)
  -R TEST_REPLICATES, --test-replicates TEST_REPLICATES
                        Size of the test dataset used to evaluate the
                        discriminator after each training epoch. (default:
                        1000)
  -e EPOCHS, --epochs EPOCHS
                        Number of full passes over the training dataset when
                        training the discriminator. (default: 1)

PG-GAN arguments:
  --Dx-replicates DX_REPLICATES
                        Number of generator replicates for approximating
                        E[D(G(θ))]. (default: 32)
  --num-proposals NUM_PROPOSALS
                        Number of proposals for each parameter in a given
                        iteration. (default: 10)
  --max-pretraining-iterations MAX_PRETRAINING_ITERATIONS
                        Maximum number of pretraining rounds. (default: 100)

GAN arguments:
  -i ITERATIONS, --iterations ITERATIONS
                        Number of iterations. (default: 1)
  -o OUTPUT_FOLDER, --output-folder OUTPUT_FOLDER
                        Folder to output results. If not specified, the
                        current directory will be used. (default: None)
  -m model.py, --model model.py
                        Python script from which to import the variable
                        "dinf_model". This is a dinf.DinfModel object that
                        describes the model components. See the examples/
                        folder of the git repository for example models.
                        https://github.com/RacimoLab/dinf (default: None)
```


## Metadata
- **Skill**: generated
