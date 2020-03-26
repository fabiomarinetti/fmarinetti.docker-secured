TEST_PLAYBOOK = 'test.yml'

def test_role(host):
    host.run_expect([0], 'ansible-playbook -i inventory ' + TEST_PLAYBOOK)

def test_idempotency(host):
    host.run_expect([0], 'ansible-playbook -i inventory ' + TEST_PLAYBOOK)
