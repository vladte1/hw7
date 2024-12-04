1. Run ec2-instance (ami-053b0d53c279acc90) Ubuntu 22.04
2. Connect to instance via ssh with dynamic port forward ( -D)
3. Configure SOCKS-proxy for your desktop browser using ssh dynamic port forwarding. Check your
   proxy by changing location of your browser. (Visit: whatismyipaddress.com)
4. Run any web server on your home computer. (see: one line python web-server)
5. Connect to instance ssh-reverse using ssh remote port forwarding (-R). Check your connection from
   the Internet to your home computer web server.
6. Do not forget:
- modify with used-data /etc/ssh/sshd_config on your instance for GatewayPorts=yes using sed - restart ssh service on instance (in user-data)
- add inbound port in AWS SG rules on instance (preferably via aws cli)
7. Store ssh command lines used in 2. and 5,6
8. Push user-data and commands to github.
## How to start: 
aws ec2 run-instances \
--image-id ami-053b0d53c279acc90 \
--instance-type t2.micro \
--security-group-ids sg-087a411be8bacfad1\
--subnet-id subnet-00d298a49da8fc733 \
--associate-public-ip-address \
--user-data file://user-data.sh

ssh -i ec2key.pem -D 8080 ubuntu@54.226.55.19

aws ec2 authorize-security-group-ingress \
--group-id sg-087a411be8bacfad1 \
--protocol tcp \
--port 9000 \
--cidr 0.0.0.0/0

ssh -i my-key.pem -R 9000:localhost:8000 ubuntu@54.226.55.19