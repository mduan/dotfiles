import json
import subprocess
import sys


def call_shell(command):
    return subprocess.check_output(command, shell=True)


def catch_shell(command):
    try:
        return call_shell(command), 0
    except subprocess.CalledProcessError as grepexc:
        return grepexc.output, grepexc.returncode


def get_jabra_address():
    devices_json = call_shell('blueutil --paired --format json')
    devices = json.loads(devices_json)

    jabra_device = next((device for device in devices if device['name'] == 'Jabra Elite 75t'), None)
    if not jabra_device:
        print 'Could not find "Jabra Elite 75t" device'
        return None

    return jabra_device['address']


def sleep():
    address = get_jabra_address()
    if not address:
        sys.exit(1)
    catch_shell('blueutil --disconnect {}'.format(address))

def wake():
    address = get_jabra_address()
    if not address:
        sys.exit(1)
    catch_shell('blueutil --connect {}'.format(address))
