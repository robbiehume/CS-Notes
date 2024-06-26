import subprocess

# Subprocess module
output = subprocess.run(["hostname", "-s"], stdout=subprocess.PIPE)  # stderr=subprocess.STDOUT?
hostname = output.stdout.decode('utf-8')
