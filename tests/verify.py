import os


def get_port(host):
    if 'docker_port' in host.ansible.get_variables():
        port = host.ansible.get_variables()['docker_port']
    else:
        port = (os.getenv('DOCKER_PORT') or '2375')
    return str(port)


def test_package(host):
    if host.system_info.distribution == 'ubuntu':
        package_name = 'docker.io'
    else:
        package_name = 'docker-ce'
    p = host.package(package_name)
    assert p.is_installed


def test_service(host):
    docker = host.service("docker")
    assert docker.is_running
    assert docker.is_enabled


def test_socket(host):
    assert host.socket('tcp://0.0.0.0:' + get_port(host)).is_listening


def test_ssl(host):
    cmd_string = "openssl s_client -connect localhost:" + get_port(host)
                 " -showcerts </dev/null 2>/dev/null |"
                 " sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' |"
                 " openssl x509 -noout -serial | cut -d '=' -f 2"
    server_cert_serial = host.run(cmd_string).stdout.strip()
    cmd_string = 'openssl x509 -in ../files/server.crt -noout -serial | cut -d = -f 2'
    serial_from_file = os.popen(cmd_string).read().strip()
    assert server_cert_serial == serial_from_file
