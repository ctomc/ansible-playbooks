## Deploy teamcity agent

- Requires Ansible 1.8 or newer
- Expects CentOS/RHEL 6.x/7.x hosts

This playbooks are for deploying teamcity agnets from scratch 
and for post inital deployment mgmt.

Then deploy teamcity agent the playbook, run it like this:

	ansible-playbook -i hosts inital-setup.yml

When the playbook run completes, you should be able to see new agent in teamcity server. 


