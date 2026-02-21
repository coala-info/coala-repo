# ansible CWL Generation Report

## ansible

### Tool Description
Ansible is an IT automation tool that can configure systems, deploy software, and orchestrate more advanced IT tasks such as continuous deployments or zero downtime rolling updates.

### Metadata
- **Docker Image**: quay.io/biocontainers/ansible:1.9.4--py27_0
- **Homepage**: https://github.com/ansible/ansible
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ansible/overview
- **Total Downloads**: 9.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ansible/ansible
- **Stars**: N/A
### Original Help Text
```text
Usage: ansible <host-pattern> [options]

Options:
  -a MODULE_ARGS, --args=MODULE_ARGS
                        module arguments
  --ask-become-pass     ask for privilege escalation password
  -k, --ask-pass        ask for SSH password
  --ask-su-pass         ask for su password (deprecated, use become)
  -K, --ask-sudo-pass   ask for sudo password (deprecated, use become)
  --ask-vault-pass      ask for vault password
  -B SECONDS, --background=SECONDS
                        run asynchronously, failing after X seconds
                        (default=N/A)
  -b, --become          run operations with become (nopasswd implied)
  --become-method=BECOME_METHOD
                        privilege escalation method to use (default=sudo),
                        valid choices: [ sudo | su | pbrun | pfexec | runas ]
  --become-user=BECOME_USER
                        run operations as this user (default=None)
  -C, --check           don't make any changes; instead, try to predict some
                        of the changes that may occur
  -c CONNECTION, --connection=CONNECTION
                        connection type to use (default=smart)
  -e EXTRA_VARS, --extra-vars=EXTRA_VARS
                        set additional variables as key=value or YAML/JSON
  -f FORKS, --forks=FORKS
                        specify number of parallel processes to use
                        (default=5)
  -h, --help            show this help message and exit
  -i INVENTORY, --inventory-file=INVENTORY
                        specify inventory host file
                        (default=/etc/ansible/hosts)
  -l SUBSET, --limit=SUBSET
                        further limit selected hosts to an additional pattern
  --list-hosts          outputs a list of matching hosts; does not execute
                        anything else
  -m MODULE_NAME, --module-name=MODULE_NAME
                        module name to execute (default=command)
  -M MODULE_PATH, --module-path=MODULE_PATH
                        specify path(s) to module library (default=None)
  -o, --one-line        condense output
  -P POLL_INTERVAL, --poll=POLL_INTERVAL
                        set the poll interval if using -B (default=15)
  --private-key=PRIVATE_KEY_FILE
                        use this file to authenticate the connection
  -S, --su              run operations with su (deprecated, use become)
  -R SU_USER, --su-user=SU_USER
                        run operations with su as this user (default=root)
                        (deprecated, use become)
  -s, --sudo            run operations with sudo (nopasswd) (deprecated, use
                        become)
  -U SUDO_USER, --sudo-user=SUDO_USER
                        desired sudo user (default=root) (deprecated, use
                        become)
  -T TIMEOUT, --timeout=TIMEOUT
                        override the SSH timeout in seconds (default=10)
  -t TREE, --tree=TREE  log output to this directory
  -u REMOTE_USER, --user=REMOTE_USER
                        connect as this user (default=qianghu)
  --vault-password-file=VAULT_PASSWORD_FILE
                        vault password file
  -v, --verbose         verbose mode (-vvv for more, -vvvv to enable
                        connection debugging)
  --version             show program's version number and exit
```


## Metadata
- **Skill**: generated

## ansible_ansible-galaxy

### Tool Description
Manage Ansible roles and collections.

### Metadata
- **Docker Image**: quay.io/biocontainers/ansible:1.9.4--py27_0
- **Homepage**: https://github.com/ansible/ansible
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
Usage: ansible-galaxy [init|info|install|list|remove] [--help] [options] ...

Options:
  -h, --help  show this help message and exit

See 'ansible-galaxy <command> --help' for more information on a specific command.
```

## ansible_ansible-pull

### Tool Description
Pulls playbooks from a VCS repo and executes them for the local host.

### Metadata
- **Docker Image**: quay.io/biocontainers/ansible:1.9.4--py27_0
- **Homepage**: https://github.com/ansible/ansible
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
Usage: ansible-pull [options] [playbook.yml]

Options:
  --accept-host-key     adds the hostkey for the repo url if not already added
  -K, --ask-sudo-pass   ask for sudo password
  -C CHECKOUT, --checkout=CHECKOUT
                        branch/tag/commit to checkout.  Defaults to behavior
                        of repository module.
  -d DEST, --directory=DEST
                        directory to checkout repository to
  -e EXTRA_VARS, --extra-vars=EXTRA_VARS
                        set additional variables as key=value or YAML/JSON
  -f, --force           run the playbook even if the repository could not be
                        updated
  --git-force           modified files in the working git repository will be
                        discarded
  -h, --help            show this help message and exit
  -i INVENTORY, --inventory-file=INVENTORY
                        location of the inventory host file
  --key-file=KEY_FILE   Pass '-i <key_file>' to the SSH arguments used by git.
  -m MODULE_NAME, --module-name=MODULE_NAME
                        Module name used to check out repository.  Default is
                        git.
  -o, --only-if-changed
                        only run the playbook if the repository has been
                        updated
  --purge               purge checkout after playbook run
  -s SLEEP, --sleep=SLEEP
                        sleep for random interval (between 0 and n number of
                        seconds) before starting. this is a useful way to
                        disperse git requests
  -t TAGS, --tags=TAGS  only run plays and tasks tagged with these values
  --track-submodules    submodules will track the latest commit on their
                        master branch (or other branch specified in
                        .gitmodules). This is equivalent to specifying the
                        --remote flag to git submodule update
  -U URL, --url=URL     URL of the playbook repository
  --vault-password-file=VAULT_PASSWORD_FILE
                        vault password file
  -v, --verbose         Pass -vvvv to ansible-playbook
```

