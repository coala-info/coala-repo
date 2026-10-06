# ansible CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ansible | Failed | image problem: Ansible 1.9.4 crashes because the container user (uid 1001) is not in /etc/passwd; it runs only with cwltool --no-match-user. |
| ansible_ansible-galaxy_info | Failed | image problem: Ansible 1.9.4 crashes because the container user (uid 1001) is not in /etc/passwd; it runs only with cwltool --no-match-user. |
| ansible_ansible-galaxy_init | Failed | image problem: Ansible 1.9.4 crashes because the container user (uid 1001) is not in /etc/passwd; it runs only with cwltool --no-match-user. |
| ansible_ansible-galaxy_install | Failed | image problem: Ansible 1.9.4 crashes because the container user (uid 1001) is not in /etc/passwd; it runs only with cwltool --no-match-user. |
| ansible_ansible-galaxy_list | Failed | image problem: Ansible 1.9.4 crashes because the container user (uid 1001) is not in /etc/passwd; it runs only with cwltool --no-match-user. |
| ansible_ansible-galaxy_remove | Failed | image problem: Ansible 1.9.4 crashes because the container user (uid 1001) is not in /etc/passwd; it runs only with cwltool --no-match-user. |
| ansible_ansible-pull | Failed | image problem: Ansible 1.9.4 crashes because the container user (uid 1001) is not in /etc/passwd; it runs only with cwltool --no-match-user. |

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
- **Stars**: 68124
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


## ansible_ansible-galaxy_info

### Tool Description
Show details about an Ansible role (ansible-galaxy info [options] role_name[,version])

### Metadata
- **Docker Image**: quay.io/biocontainers/ansible:1.9.4--py27_0
- **Homepage**: https://github.com/ansible/ansible
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ansible/overview
- **Total Downloads**: 9.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ansible/ansible
- **Stars**: 68124
### Original Help Text
```text
Usage: ansible-galaxy info [options] role_name[,version]

Options:
  -h, --help            show this help message and exit
  -p ROLES_PATH, --roles-path=ROLES_PATH
                        The path to the directory containing your roles. The
                        default is the roles_path configured in your
                        ansible.cfg file (/etc/ansible/roles if not
                        configured)
  -s API_SERVER, --server=API_SERVER
                        The API server destination

See 'ansible-galaxy <command> --help' for more information on a specific command.
```


## ansible_ansible-galaxy_init

### Tool Description
Create the skeleton of a new Ansible role (ansible-galaxy init [options] role_name)

### Metadata
- **Docker Image**: quay.io/biocontainers/ansible:1.9.4--py27_0
- **Homepage**: https://github.com/ansible/ansible
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ansible/overview
- **Total Downloads**: 9.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ansible/ansible
- **Stars**: 68124
### Original Help Text
```text
Usage: ansible-galaxy init [options] role_name

Options:
  -h, --help            show this help message and exit
  -p INIT_PATH, --init-path=INIT_PATH
                        The path in which the skeleton role will be created.
                        The default is the current working directory.
  --offline             Don't query the galaxy API when creating roles
  -s API_SERVER, --server=API_SERVER
                        The API server destination
  -f, --force           Force overwriting an existing role

See 'ansible-galaxy <command> --help' for more information on a specific command.
```


## ansible_ansible-galaxy_install

### Tool Description
Install Ansible roles from Galaxy, SCM URLs, tar files or a role file

### Metadata
- **Docker Image**: quay.io/biocontainers/ansible:1.9.4--py27_0
- **Homepage**: https://github.com/ansible/ansible
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ansible/overview
- **Total Downloads**: 9.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ansible/ansible
- **Stars**: 68124
### Original Help Text
```text
Usage: ansible-galaxy install [options] [-r FILE | role_name(s)[,version] | scm+role_repo_url[,version] | tar_file(s)]

Options:
  -h, --help            show this help message and exit
  -i, --ignore-errors   Ignore errors and continue with the next specified
                        role.
  -n, --no-deps         Don't download roles listed as dependencies
  -r ROLE_FILE, --role-file=ROLE_FILE
                        A file containing a list of roles to be imported
  -p ROLES_PATH, --roles-path=ROLES_PATH
                        The path to the directory containing your roles. The
                        default is the roles_path configured in your
                        ansible.cfg file (/etc/ansible/roles if not
                        configured)
  -s API_SERVER, --server=API_SERVER
                        The API server destination
  -f, --force           Force overwriting an existing role

See 'ansible-galaxy <command> --help' for more information on a specific command.
```


## ansible_ansible-galaxy_list

### Tool Description
List installed Ansible roles (ansible-galaxy list [role_name])

### Metadata
- **Docker Image**: quay.io/biocontainers/ansible:1.9.4--py27_0
- **Homepage**: https://github.com/ansible/ansible
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ansible/overview
- **Total Downloads**: 9.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ansible/ansible
- **Stars**: 68124
### Original Help Text
```text
Usage: ansible-galaxy list [role_name]

Options:
  -h, --help            show this help message and exit
  -p ROLES_PATH, --roles-path=ROLES_PATH
                        The path to the directory containing your roles. The
                        default is the roles_path configured in your
                        ansible.cfg file (/etc/ansible/roles if not
                        configured)

See 'ansible-galaxy <command> --help' for more information on a specific command.
```


## ansible_ansible-galaxy_remove

### Tool Description
Remove installed Ansible roles (ansible-galaxy remove role1 role2 ...)

### Metadata
- **Docker Image**: quay.io/biocontainers/ansible:1.9.4--py27_0
- **Homepage**: https://github.com/ansible/ansible
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ansible/overview
- **Total Downloads**: 9.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ansible/ansible
- **Stars**: 68124
### Original Help Text
```text
Usage: ansible-galaxy remove role1 role2 ...

Options:
  -h, --help            show this help message and exit
  -p ROLES_PATH, --roles-path=ROLES_PATH
                        The path to the directory containing your roles. The
                        default is the roles_path configured in your
                        ansible.cfg file (/etc/ansible/roles if not
                        configured)

See 'ansible-galaxy <command> --help' for more information on a specific command.
```


## Metadata
- **Skill**: generated

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

