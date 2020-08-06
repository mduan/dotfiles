import json
import subprocess
import sys


# TODO(mack): For some reason just using "blueutil" in script doesn't work with sleepwatcher
# when started via. launchd (although it does work when sleepwatcher is started from command line
# See https://stackoverflow.com/a/29926482 for how to debug launchd
BLUEUTIL_PATH = '/usr/local/bin/blueutil'


def call_shell(command):
    return subprocess.check_output(command, shell=True)


def catch_shell(command):
    try:
        return call_shell(command), 0
    except subprocess.CalledProcessError as grepexc:
        return grepexc.output, grepexc.returncode


def get_jabra_address():
    devices_json = call_shell('{} --paired --format json'.format(BLUEUTIL_PATH))
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
    catch_shell('{} --disconnect {}'.format(BLUEUTIL_PATH, address))

def wakeup():
    address = get_jabra_address()
    if not address:
        sys.exit(1)
    catch_shell('{} --connect {}'.format(BLUEUTIL_PATH, address))
