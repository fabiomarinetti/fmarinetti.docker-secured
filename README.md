[![Build Status](https://travis-ci.com/fabiomarinetti/fmarinetti.docker-secured.svg?branch=master)](https://travis-ci.com/fabiomarinetti/fmarinetti.docker-secured)

faminetti.docker-securd
=========

This role installs and expose securely the docker APIs

Requirements
------------

None

Role Variables
--------------

  - key_dir: the directory where to store the server key (default: /etc/ssl/private)
  - cert_dir: the directory where to store the certificates (default: /etc/ssl/certs)
  - server_key_file: the name of the server key file (default: server.key)
  - server_cert_file: the name of the server certificate file (default: server.crt)
  - ca_cert_file: the name of the CA certificate file (default: ca.crt)
  - use_vault: states if the certificates are taken from vault (default: false)
  - docker_port: the docker port (default: 2375) 

Dependencies
------------

  - nephelaiio.docker
 
Example Playbook
----------------

Create a secured docker server with certificates copied from server. The files are embedded in role itself.
Client files are in the files directory of role.
```
    - hosts: servers
      roles:
         - fmarinetti.docker-secured
```
Create a secured docker server with certificates taken from vault. In the playbook file **use_vault: true** must be specified. The vault file must be created as:
```
server_key: |
 ...
server_cert: |
 ...
ca_cert: |
 ...
```
and the command to launch should be:
```
ansible-playbook -i <inventory-file> -e @/path/to/vault <playbook> --vault-password-file <vault-password-file>
```

    
License
-------

BSD

Author Information
------------------
